/*
 * Vending machine types - Can be found under /code/modules/vending/
 */

/*

/obj/machinery/vending/[vendors name here]   // --vending machine template   :)
	name = ""
	desc = ""
	icon = ''
	icon_state = ""
	products = list()
	contraband = list()
	premium = list()

IF YOU MODIFY THE PRODUCTS LIST OF A MACHINE, MAKE SURE TO UPDATE ITS RESUPPLY CANISTER CHARGES in vending_items.dm
*/

/datum/data/vending_product
	name = "generic"
	var/product_path = null
	var/amount = 0
	var/max_amount = 0
	var/price = 0


/obj/machinery/vending
	name = "\improper Vendomat"
	desc = "A generic vending machine."
	icon = 'icons/obj/vending.dmi'
	icon_state = "generic"
	layer = BELOW_OBJ_LAYER
	density = TRUE
	verb_say = "beeps"
	verb_ask = "beeps"
	verb_exclaim = "beeps"
	max_integrity = 300
	integrity_failure = 100
	armor = list("melee" = 20, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 70)
	circuit = /obj/item/circuitboard/machine/vendor
	var/active = 1		//No sales pitches if off!
	var/vend_ready = 1	//Are we ready to vend?? Is it time??

	// To be filled out at compile time
	var/list/products	= list()	//For each, use the following pattern:
	var/list/contraband	= list()	//list(/type/path = amount, /type/path2 = amount2)
	var/list/premium 	= list()	//No specified amount = only one in stock

	var/product_slogans = ""	//String of slogans separated by semicolons, optional
	var/product_ads = ""		//String of small ad messages in the vending screen - random chance
	var/list/product_records = list()
	var/list/hidden_records = list()
	var/list/coin_records = list()
	var/list/slogan_list = list()
	var/list/small_ads = list()	//Small ad messages in the vending screen - random chance of popping up whenever you open it
	var/vend_reply				//Thank you for shopping!
	var/last_reply = 0
	var/last_slogan = 0			//When did we last pitch?
	var/slogan_delay = 6000		//How long until we can pitch again?
	var/icon_vend				//Icon_state when vending!
	var/icon_deny				//Icon_state when vending!
	var/seconds_electrified = 0	//Shock customers like an airlock.
	var/shoot_inventory = 0		//Fire items at customers! We're broken!
	var/shoot_inventory_chance = 2
	var/shut_up = 0				//Stop spouting those godawful pitches!
	var/extended_inventory = 0	//can we access the hidden inventory?
	var/scan_id = 1
	var/obj/item/coin/coin
	var/obj/item/stack/spacecash/bill

	var/global/vending_cache = list() //used for storing the icons of items being vended

	var/dish_quants = list()  //used by the snack machine's custom compartment to count dishes.

	var/obj/item/vending_refill/refill_canister = null		//The type of refill canisters used by this machine

	//tilting stuff
	var/tilted = FALSE
	var/tiltable = TRUE
	var/squish_damage = 75
	var/forcecrit = 0
	var/num_shards = 7
	var/list/pinned_mobs = list()
	
	//hyper economy stuff
	var/credits = 0
	var/baseprice = 0
	var/menu = 1
	var/datum/bank_account/bankid
	var/datum/data/vending_product/buying
	var/free = FALSE //everythings free!

/obj/machinery/vending/Initialize()
	var/build_inv = FALSE
	if(!refill_canister)
		circuit = null
		build_inv = TRUE
	. = ..()
	wires = new /datum/wires/vending(src)
	if(build_inv) //non-constructable vending machine
		build_inventory(products, product_records)
		build_inventory(contraband, hidden_records)
		build_inventory(premium, coin_records)

	slogan_list = splittext(product_slogans, ";")
	// So not all machines speak at the exact same time.
	// The first time this machine says something will be at slogantime + this random value,
	// so if slogantime is 10 minutes, it will say it at somewhere between 10 and 20 minutes after the machine is crated.
	last_slogan = world.time + rand(0, slogan_delay)
	power_change()

/obj/machinery/vending/Destroy()
	unbuckle_all_mobs(TRUE)
	QDEL_NULL(wires)
	QDEL_NULL(coin)
	QDEL_NULL(bill)
	return ..()

/obj/machinery/vending/RefreshParts()         //Better would be to make constructable child
	if(!component_parts)
		return

	product_records = list()
	hidden_records = list()
	coin_records = list()
	build_inventory(products, product_records, start_empty = TRUE)
	build_inventory(contraband, hidden_records, start_empty = TRUE)
	build_inventory(premium, coin_records, start_empty = TRUE)
	for(var/obj/item/vending_refill/VR in component_parts)
		restock(VR)

/obj/machinery/vending/deconstruct(disassembled = TRUE)
	if(!refill_canister) //the non constructable vendors drop metal instead of a machine frame.
		if(!(flags_1 & NODECONSTRUCT_1))
			new /obj/item/stack/sheet/metal(loc, 3)
		qdel(src)
	else
		..()

/obj/machinery/vending/obj_break(damage_flag)
	if(!(stat & BROKEN) && !(flags_1 & NODECONSTRUCT_1))
		stat |= BROKEN
		icon_state = "[initial(icon_state)]-broken"

		var/dump_amount = 0
		var/found_anything = TRUE
		while (found_anything)
			found_anything = FALSE
			for(var/record in shuffle(product_records))
				var/datum/data/vending_product/R = record
				if(R.amount <= 0) //Try to use a record that actually has something to dump.
					continue
				var/dump_path = R.product_path
				if(!dump_path)
					continue
				R.amount--
				// busting open a vendor will destroy some of the contents
				if(found_anything && prob(80))
					continue

				var/obj/O = new dump_path(loc)
				step(O, pick(GLOB.alldirs))
				found_anything = TRUE
				dump_amount++
				if (dump_amount >= 16)
					return

/obj/machinery/vending/proc/build_inventory(list/productlist, list/recordlist, start_empty = FALSE)
	for(var/typepath in productlist)
		var/amount = productlist[typepath]
		if(isnull(amount))
			amount = 0

		var/atom/temp = typepath
		var/obj/item/product = typepath
		var/datum/data/vending_product/R = new /datum/data/vending_product()
		R.name = initial(temp.name)
		R.product_path = typepath
		R.price = baseprice
		if(product) //its a item!
			if((initial(product.price)))
				R.price = initial(product.price)
			else
				R.price = baseprice
		if(free)
			R.price = 0
		if(!start_empty)
			R.amount = amount
		R.max_amount = amount
		recordlist += R

/obj/machinery/vending/proc/restock(obj/item/vending_refill/canister)
	if (!canister.products)
		canister.products = products.Copy()
	if (!canister.contraband)
		canister.contraband = contraband.Copy()
	if (!canister.premium)
		canister.premium = premium.Copy()
	. = 0
	. += refill_inventory(canister.products, product_records)
	. += refill_inventory(canister.contraband, hidden_records)
	. += refill_inventory(canister.premium, coin_records)

/obj/machinery/vending/proc/refill_inventory(list/productlist, list/recordlist)
	. = 0
	for(var/R in recordlist)
		var/datum/data/vending_product/record = R
		var/diff = min(record.max_amount - record.amount, productlist[record.product_path])
		if (diff)
			productlist[record.product_path] -= diff
			record.amount += diff
			. += diff

/obj/machinery/vending/proc/update_canister()
	if (!component_parts)
		return

	var/obj/item/vending_refill/R = locate() in component_parts
	if (!R)
		CRASH("Constructible vending machine did not have a refill canister")
		return

	R.products = unbuild_inventory(product_records)
	R.contraband = unbuild_inventory(hidden_records)
	R.premium = unbuild_inventory(coin_records)

/obj/machinery/vending/proc/unbuild_inventory(list/recordlist)
	. = list()
	for(var/R in recordlist)
		var/datum/data/vending_product/record = R
		.[record.product_path] += record.amount

/obj/machinery/vending/crowbar_act(mob/living/user, obj/item/I)
	if(!component_parts)
		return FALSE
	default_deconstruction_crowbar(I)
	return TRUE

/obj/machinery/vending/wrench_act(mob/living/user, obj/item/I)
	if(panel_open)
		default_unfasten_wrench(user, I, time = 60)
		unbuckle_all_mobs(TRUE)
	return TRUE

/obj/machinery/vending/screwdriver_act(mob/living/user, obj/item/I)
	if(anchored)
		default_deconstruction_screwdriver(user, icon_state, icon_state, I)
		cut_overlays()
		if(panel_open)
			add_overlay("[initial(icon_state)]-panel")
		updateUsrDialog()
	else
		to_chat(user, "<span class='warning'>You must first secure [src].</span>")
	return TRUE

/obj/machinery/vending/attackby(obj/item/I, mob/user, params)
	if(panel_open && is_wire_tool(I))
		wires.interact(user)
		return


	else if(istype(I, /obj/item/stack/credits))
		var/obj/item/stack/credits/cred = I
		to_chat(usr, "<span class='notice'>You insert [cred] into [src].</span>")
		credits = credits+cred.amount
		src.ui_interact(usr)
		del(cred)

	/* we dont use this currency anymore!
	else if(istype(I, /obj/item/coin))
		if(coin)
			to_chat(user, "<span class='warning'>[src] already has [coin] inserted</span>")
			return
		if(bill)
			to_chat(user, "<span class='warning'>[src] already has [bill] inserted</span>")
			return
		if(!premium.len)
			to_chat(user, "<span class='warning'>[src] doesn't have a coin slot.</span>")
			return
		if(!user.transferItemToLoc(I, src))
			return
		coin = I
		to_chat(user, "<span class='notice'>You insert [I] into [src].</span>")
		return
	else if(istype(I, /obj/item/stack/spacecash))
		if(coin)
			to_chat(user, "<span class='warning'>[src] already has [coin] inserted</span>")
			return
		if(bill)
			to_chat(user, "<span class='warning'>[src] already has [bill] inserted</span>")
			return
		var/obj/item/stack/S = I
		if(!premium.len)
			to_chat(user, "<span class='warning'>[src] doesn't have a bill slot.</span>")
			return
		S.use(1)
		bill = new S.type(src, 1)
		to_chat(user, "<span class='notice'>You insert [I] into [src].</span>")
		return
	*/
	else if(refill_canister && istype(I, refill_canister))
		if (!panel_open)
			to_chat(user, "<span class='notice'>You should probably unscrew the service panel first.</span>")
		else if (stat & (BROKEN|NOPOWER))
			to_chat(user, "<span class='notice'>[src] does not respond.</span>")
		else
			//if the panel is open we attempt to refill the machine
			var/obj/item/vending_refill/canister = I
			if(canister.get_part_rating() == 0)
				to_chat(user, "<span class='notice'>[canister] is empty!</span>")
			else
				// instantiate canister if needed
				var/transferred = restock(canister)
				if(transferred)
					to_chat(user, "<span class='notice'>You loaded [transferred] items in [src].</span>")
				else
					to_chat(user, "<span class='notice'>There's nothing to restock!</span>")
			return
	else
		. = ..()
		if(tiltable && !tilted && I.force)
			switch(rand(1, 100))
				if(1 to 5)
					freebie(user, 3)
				if(6 to 15)
					freebie(user, 2)
				if(16 to 25)
					freebie(user, 1)
				if(76 to 90)
					tilt(user)
				if(91 to 100)
					tilt(user, crit=TRUE)

/obj/machinery/vending/proc/freebie(mob/fatty, freebies)
	visible_message("<span class='notice'>[src] yields [freebies > 1 ? "several free goodies" : "a free goody"]!</span>")

	for(var/i in 1 to freebies)
		playsound(src, 'sound/items/vending.ogg', 50, TRUE, extrarange = -3)
		for(var/datum/data/vending_product/R in shuffle(product_records))

			if(R.amount <= 0) //Try to use a record that actually has something to dump.
				continue
			var/dump_path = R.product_path
			if(!dump_path)
				continue

			R.amount--
			new dump_path(get_turf(src))
			break

/obj/machinery/vending/proc/tilt(mob/fatty, crit=FALSE)
	visible_message("<span class='danger'>[src] tips over!</span>")
	tilted = TRUE
	layer = ABOVE_MOB_LAYER

	var/crit_case
	if(crit)
		crit_case = rand(1,5)

	if(forcecrit)
		crit_case = forcecrit

	if(in_range(fatty, src))
		for(var/mob/living/L in get_turf(fatty))
			var/mob/living/carbon/C = L

			if(istype(C))
				var/crit_rebate = 0 // lessen the normal damage we deal for some of the crits

				if(crit_case != 5) // the head asplode case has its own description
					C.visible_message("<span class='danger'>[C] is crushed by [src]!</span>", \
						"<span class='userdanger'>You are crushed by [src]!</span>")

				switch(crit_case) // only carbons can have the fun crits
					if(1) // shatter their legs and bleed 'em
						crit_rebate = 60
						C.bleed(150)
						var/obj/item/bodypart/l_leg/l = C.get_bodypart(BODY_ZONE_L_LEG)
						if(l)
							l.receive_damage(brute=200, updating_health=TRUE)
						var/obj/item/bodypart/r_leg/r = C.get_bodypart(BODY_ZONE_R_LEG)
						if(r)
							r.receive_damage(brute=200, updating_health=TRUE)
						if(l || r)
							C.visible_message("<span class='danger'>[C]'s legs shatter with a sickening crunch!</span>", \
								"<span class='userdanger'>Your legs shatter with a sickening crunch!</span>")
					if(2) // pin them beneath the machine until someone untilts it
						forceMove(get_turf(C))
						buckle_mob(C, force=TRUE)
						C.visible_message("<span class='danger'>[C] is pinned underneath [src]!</span>", \
							"<span class='userdanger'>You are pinned down by [src]!</span>")
					if(3) // glass candy
						crit_rebate = 50
						for(var/i = 0, i < num_shards, i++)
							var/obj/item/shard/shard = new /obj/item/shard(get_turf(C))
							shard.embedding = shard.embedding.setRating(embed_chance = 100)
							C.hitby(shard, skipcatch = TRUE, hitpush = FALSE)
							shard.embedding = shard.embedding.setRating(embed_chance = EMBED_CHANCE)
					if(4) // paralyze this binch
						// the new paraplegic gets like 4 lines of losing their legs so skip them
						visible_message("<span class='danger'>[C]'s spinal cord is obliterated with a sickening crunch!</span>", ignored_mobs = list(C))
						C.gain_trauma(/datum/brain_trauma/severe/paralysis/paraplegic)
					if(5) // skull squish!
						var/obj/item/bodypart/head/O = C.get_bodypart(BODY_ZONE_HEAD)
						if(O)
							C.visible_message("<span class='danger'>[O] explodes in a shower of gore beneath [src]!</span>", \
								"<span class='userdanger'>Oh f-</span>")
							O.dismember()
							O.drop_organs()
							qdel(O)
							new /obj/effect/gibspawner/human/bodypartless(get_turf(C))
				C.apply_damage(max(0, squish_damage - crit_rebate), BRUTE)
				C.AddElement(/datum/element/squish, 60 SECONDS)
			else
				L.visible_message("<span class='danger'>[L] is crushed by [src]!</span>", \
				"<span class='userdanger'>You are crushed by [src]!</span>")
				L.apply_damage(squish_damage, BRUTE)
				if(crit_case)
					L.apply_damage(squish_damage, BRUTE)

			//L.Paralyze(60) We don't have paralyze, too bad.
			L.Stun(60, TRUE, TRUE)
			L.Knockdown(60)
			L.emote("scream")
			playsound(L, 'sound/effects/blobattack.ogg', 40, TRUE)
			playsound(L, 'sound/effects/splat.ogg', 50, TRUE)

	var/matrix/M = matrix()
	M.Turn(pick(90, 270))
	transform = M

	if(get_turf(fatty) != get_turf(src))
		throw_at(get_turf(fatty), 1, 1, spin=FALSE)

/obj/machinery/vending/proc/untilt(mob/user)
	user.visible_message("<span class='notice'>[user] rights [src].", \
		"<span class='notice'>You right [src].")

	unbuckle_all_mobs(TRUE)

	tilted = FALSE
	layer = initial(layer)

	var/matrix/M = matrix()
	M.Turn(0)
	transform = M

/obj/machinery/vending/exchange_parts(mob/user, obj/item/storage/part_replacer/W)
	if(!istype(W))
		return FALSE
	if((flags_1 & NODECONSTRUCT_1) && !W.works_from_distance)
		return FALSE
	if(!component_parts || !refill_canister)
		return FALSE

	var/moved = 0
	if(panel_open || W.works_from_distance)
		if(W.works_from_distance)
			display_parts(user)
		for(var/I in W)
			if(istype(I, refill_canister))
				moved += restock(I)
	else
		display_parts(user)
	if(moved)
		to_chat(user, "[moved] items restocked.")
		W.play_rped_sound()
	return TRUE

/obj/machinery/vending/on_deconstruction()
	update_canister()
	. = ..()

/obj/machinery/vending/emag_act(mob/user)
	if(obj_flags & EMAGGED)
		return
	obj_flags |= EMAGGED
	to_chat(user, "<span class='notice'>You short out the product lock on [src].</span>")

/obj/machinery/vending/_try_interact(mob/user)
	if(seconds_electrified && !(stat & NOPOWER))
		if(shock(user, 100))
			return
	if(tilted && !user.buckled)
		to_chat(user, "<span class='notice'>You begin righting \the [src].")
		if(do_after(user, 50, target=src))
			untilt(user)
		return
	return ..()

/obj/machinery/vending/ui_interact(mob/user)
	var/dat = ""

	switch(menu)
		if(1)
			dat += "<h3>Select an item</h3><p>"
			if(!credits)
				dat += "<i>Inserted credits: $[credits] </i>&nbsp;&nbsp;<span class='linkOff'>remove</span>"
			else
				dat	+= "<i>Inserted credits: $[credits] </i><a href='byond://?src=[REF(src)];removecredits=1'>remove</A>"

			dat += "<div class='statusDisplay'>"
			if(!product_records.len)
				dat += "<font color = 'red'>No product loaded!</font>"
			else
				var/list/display_records = product_records
				if(extended_inventory) //hacking shows all inventory now since coins arent worth anything.
					display_records = product_records + hidden_records + coin_records
				else
					display_records = product_records + coin_records
				dat += "<table>"
				for (var/datum/data/vending_product/R in display_records)
					dat += "<tr><td><img src='data:image/jpeg;base64,[GetIconForProduct(R)]'/></td>"
					dat += "<td style=\"width: 10%\"><b>$[R.price]</b></td>"
					dat += "<td style=\"width: 100%\">[sanitize(R.name)]</td>"
					if(R.amount > 0)
						dat += "<td><b>[R.amount]&nbsp;</b></td><td><a href='byond://?src=[REF(src)];vend=[REF(R)]'>[!R.price  ? "Vend" : "Buy"]</a></td>"
					else
						dat += "<td>0&nbsp;</td><td><span class='linkOff'>Vend</span></td>"
					dat += "</tr>"
				dat += "</table>"
			dat += "</div>"

			if(istype(src, /obj/machinery/vending/snack))
				dat += "<h3>Chef's Food Selection</h3>"
				dat += "<div class='statusDisplay'>"
				for (var/O in dish_quants)
					if(dish_quants[O] > 0)
						var/N = dish_quants[O]
						dat += "<a href='byond://?src=[REF(src)];dispense=[sanitize(O)]'>Dispense</A> "
						dat += "<B>[capitalize(O)]: [N]</B><br>"
				dat += "</div>"
		if(2) //hyper economy purchase item menu
			dat += "<center>"
			if(buying)
				dat += "<h3>Purchase [buying.name]</h3><p>"
			else
				dat += "<h3>Purchase Item</h3><p>"
			dat += "<i>Inserted credits: $[credits]</i><p>"
			dat += "Not enough credits to purchase, please insert credits or swipe your card to purchase!<p>"
			dat += "<a href='byond://?src=[REF(src)];idpay=1;vend=[REF(buying)]'>Pay-By-Card</a>"
			dat += "<a href='byond://?src=[REF(src)];return=1]'>Return</a>"
			dat += "</center>"

	var/datum/browser/popup = new(user, "vending", (name))
	popup.set_content(dat)
	popup.set_title_image(user.browse_rsc_icon(icon, icon_state))
	popup.open()

/obj/machinery/vending/proc/GetIconForProduct(datum/data/vending_product/P)
	if(vending_cache[P.product_path])
		return vending_cache[P.product_path]
	var/product = new P.product_path()
	vending_cache[P.product_path] = icon2base64(getFlatIcon(product, no_anim = TRUE))
	qdel(product)
	return vending_cache[P.product_path]

/obj/machinery/vending/Topic(href, href_list)
	if(..())
		return

	if(href_list["remove_coin"])
		if(!(coin || bill))
			to_chat(usr, "<span class='notice'>There is no money in this machine.</span>")
			return
		if(coin)
			usr.put_in_hands(coin)
			to_chat(usr, "<span class='notice'>You remove [coin] from [src].</span>")
			coin = null
		if(bill)
			usr.put_in_hands(bill)
			to_chat(usr, "<span class='notice'>You remove [bill] from [src].</span>")
			bill = null

	if(href_list["removecredits"])
		var/obj/item/stack/credits/C = new /obj/item/stack/credits/(loc)
		C.amount = credits
		credits = 0 //empty the machine
		if(usr.put_in_hands(C))
			to_chat(usr, "<span class='notice'>You take [C] out of the ATM.</span>")

	usr.set_machine(src)

	if((href_list["dispense"]) && (vend_ready))
		var/N = href_list["dispense"]
		if(dish_quants[N] <= 0) // Sanity check, there are probably ways to press the button when it shouldn't be possible.
			return
		vend_ready = 0
		use_power(5)

		dish_quants[N] = max(dish_quants[N] - 1, 0)
		for(var/obj/O in contents)
			if(O.name == N)
				O.forceMove(drop_location())
				break
		vend_ready = 1
		updateUsrDialog()
		return

	if(href_list["idpay"])
		var/obj/item/card/id/I = usr.get_idcard(TRUE)
		if(I)
			if(I.registered_account)
				bankid = I.registered_account
			else
				to_chat(usr, "<span class='notice'>The vending machine fails to read your bank account!</span>")
		else
			to_chat(usr, "<span class='notice'>The vending machine fails to read your card!</span>")

	if(href_list["return"])
		menu = 1
		vend_ready = 1
		updateUsrDialog()
		return

	if((href_list["vend"]) && (vend_ready))
		if(panel_open)
			to_chat(usr, "<span class='notice'>The vending machine cannot dispense products while its service panel is open!</span>")
			return

		if((!allowed(usr)) && !(obj_flags & EMAGGED) && scan_id)	//For SECURE VENDING MACHINES YEAH
			to_chat(usr, "<span class='warning'>Access denied.</span>"	)
			flick(icon_deny,src)
			return

		vend_ready = 0 //One thing at a time!!

		var/datum/data/vending_product/R = locate(href_list["vend"])
		buying = R

		if(!R || !istype(R) || !R.product_path)
			vend_ready = 1
			return

		//check if they can afford it, if not open the next menu
		if(R.price > credits)
			menu = 2 //second menu
			updateUsrDialog()
			vend_ready = 1
			if(bankid && R == buying) //if we have a bank id, and we are trying to buy the same thing!
				if(bankid.account_balance >= R.price)
					bankid.account_balance -= R.price //take the money from the account.
					menu = 1
					to_chat(usr, "<span class='notice'>You [R.name] via the provided bank account!</span>")
					bankid = null //so noone can buy from your account after youve purchased stuff
				else
					to_chat(usr, "<span class='notice'>You do not have enough money in the bank account to purchase [R.name]!</span>")
					return
			else
				return

		else
			credits -= R.price
			menu = 1

		if(R in hidden_records)
			if(!extended_inventory)
				vend_ready = 1
				return

		if (R.amount <= 0)
			to_chat(usr, "<span class='warning'>Sold out.</span>")
			vend_ready = 1
			return
		else
			R.amount--

		if(((last_reply + 200) <= world.time) && vend_reply)
			speak(vend_reply)
			last_reply = world.time

		use_power(5)

		if(icon_vend) //Show the vending animation if needed
			flick(icon_vend,src)
		var/vended = new R.product_path(get_turf(src))
		playsound(src, 'sound/items/vending.ogg', 50, 1, -1)
		if(usr.CanReach(src))
			if(usr.put_in_hands(vended))
				to_chat(usr, "<span class='notice'>You take [R.name] out of the slot.</span>")
			else
				to_chat(usr, "<span class='warning'>[capitalize(R.name)] falls onto the floor!</span>")
		else
			to_chat(usr, "<span class'warning'>[capitalize(R.name)] falls onto the floor!</span>")
		SSblackbox.record_feedback("nested tally", "vending_machine_usage", 1, list("[type]", "[R.product_path]"))
		vend_ready = 1

		updateUsrDialog()
		return

	else if(href_list["togglevoice"] && panel_open)
		shut_up = !shut_up

	updateUsrDialog()


/obj/machinery/vending/process()
	if(stat & (BROKEN|NOPOWER))
		return
	if(!active)
		return

	if(seconds_electrified > 0)
		seconds_electrified--

	//Pitch to the people!  Really sell it!
	if(last_slogan + slogan_delay <= world.time && slogan_list.len > 0 && !shut_up && prob(5))
		var/slogan = pick(slogan_list)
		speak(slogan)
		last_slogan = world.time

	/* no freebies
	if(shoot_inventory && prob(shoot_inventory_chance))
		throw_item()
	*/

/obj/machinery/vending/proc/speak(message)
	if(stat & (BROKEN|NOPOWER))
		return
	if(!message)
		return

	say(message)

/obj/machinery/vending/power_change()
	if(stat & BROKEN)
		icon_state = "[initial(icon_state)]-broken"
	else
		if(powered())
			icon_state = initial(icon_state)
			stat &= ~NOPOWER
		else
			icon_state = "[initial(icon_state)]-off"
			stat |= NOPOWER

//Somebody cut an important wire and now we're following a new definition of "pitch."
/obj/machinery/vending/proc/throw_item()
	var/obj/throw_item = null
	var/mob/living/target = locate() in view(7,src)
	if(!target)
		return 0

	for(var/datum/data/vending_product/R in shuffle(product_records))
		if(R.amount <= 0) //Try to use a record that actually has something to dump.
			continue
		var/dump_path = R.product_path
		if(!dump_path)
			continue

		R.amount--
		throw_item = new dump_path(loc)
		break
	if(!throw_item)
		return 0

	pre_throw(throw_item)

	throw_item.throw_at(target, 16, 3)
	visible_message("<span class='danger'>[src] launches [throw_item] at [target]!</span>")
	return 1

/obj/machinery/vending/proc/pre_throw(obj/item/I)
	return

/obj/machinery/vending/proc/shock(mob/user, prb)
	if(stat & (BROKEN|NOPOWER))		// unpowered, no shock
		return FALSE
	if(!prob(prb))
		return FALSE
	do_sparks(5, TRUE, src)
	var/check_range = TRUE
	if(electrocute_mob(user, get_area(src), src, 0.7, check_range))
		return TRUE
	else
		return FALSE

/obj/machinery/vending/onTransitZ()
	return
