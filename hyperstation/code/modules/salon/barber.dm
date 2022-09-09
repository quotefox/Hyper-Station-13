//Proper modularity to come at a later date
/obj/structure/chair/barber_chair
	name = "barbers chair"
	desc = "You sit in this, and your hair shall be cut."
	icon = 'icons/obj/chairs.dmi'
	icon_state = "barber_chair"

/obj/structure/closet/secure_closet/barber
	name = "Barber's locker"
	icon_state = "barber"
	icon = 'icons/obj/closet.dmi'
	req_access = list(ACCESS_BARBER)

/obj/structure/closet/secure_closet/barber/PopulateContents()
	new /obj/item/clothing/mask/surgical(src) // These three are here, so the barber can pick and choose what he's painting.
	new /obj/item/clothing/under/rank/medical/blue(src)
	new /obj/item/clothing/suit/apron/surgical(src)
	new /obj/item/clothing/accessory/waistcoat(src)
	//new /obj/item/clothing/under/rank/civilian/lawyer/purpsuit(src)
	new /obj/item/clothing/suit/toggle/lawyer/purple(src)
	new /obj/item/razor(src)
	//new /obj/item/straight_razor(src)
	new /obj/item/hairbrush/comb(src)
	new /obj/item/scissors(src)
	new /obj/item/fur_dyer(src)
	new /obj/item/dyespray(src)
	new /obj/item/storage/box/lipsticks(src)
	new /obj/item/reagent_containers/spray/quantum_hair_dye(src)
	new /obj/item/reagent_containers/spray/barbers_aid(src)
	new /obj/item/reagent_containers/spray/cleaner(src)
	new /obj/item/reagent_containers/rag(src)
	new /obj/item/storage/firstaid/regular(src)

/obj/machinery/vending/barbervend
	name = "Fab-O-Vend"
	desc = "It would seem it vends dyes, and other stuff to make you pretty."
	icon = 'hyperstation/icons/obj/barber.dmi'
	icon_state = "barbervend"
	product_slogans = "Spread the colour, like butter, onto toast... Onto their hair.; Sometimes, I dream about dyes...; Paint 'em up and call me Mr. Painter.; Look brother, I'm a vendomat, I solve practical problems."
	product_ads = "Cut 'em all!; To sheds!; Hair be gone!; Prettify!; Beautify!"
	vend_reply = "Come again!; Buy another!; Dont you love your new look?"
	req_access = list(ACCESS_BARBER)
	refill_canister = /obj/item/vending_refill/barbervend
	products = list(
		/obj/item/reagent_containers/spray/quantum_hair_dye = 3,
		// /obj/item/reagent_containers/spray/baldium = 3,
		/obj/item/reagent_containers/spray/barbers_aid = 3,
		/obj/item/dyespray = 5,
		/obj/item/hairbrush = 3,
		/obj/item/hairbrush/comb = 3,
		/obj/item/fur_dyer = 1,
	)
	premium = list(
		/obj/item/scissors = 3,
		/obj/item/reagent_containers/spray/super_barbers_aid = 3,
		/obj/item/storage/box/lipsticks = 3,
		/obj/item/lipstick/quantum = 1,
		/obj/item/razor = 1,
		// /obj/item/storage/box/perfume = 1,
	)
	refill_canister = /obj/item/vending_refill/barbervend

/obj/item/vending_refill/barbervend
	machine_name = "barber vend resupply"
	icon_state = "refill_snack" //generic item refill because there isnt one sprited yet.

/obj/effect/landmark/start/barber
	name = "Barber"
	icon_state = "Barber"
	//icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'

//Brush
/obj/item/hairbrush
	name = "hairbrush"
	desc = "A small, circular brush with an ergonomic grip for efficient brush application."
	icon = 'hyperstation/icons/obj/barber.dmi'
	icon_state = "brush"
	//Put lefthand and righthand files here
	w_class = WEIGHT_CLASS_TINY
	var/brush_speed = 3 SECONDS

/obj/item/hairbrush/comb
	name = "comb"
	desc = "A rather simple tool, used to straighten out hair and knots in it."
	icon_state = "blackcomb"

/obj/item/hairbrush/attack(mob/target, mob/user)
	if(target.stat == DEAD)
		to_chat(usr, "<span class='warning'>There isn't much point in brushing someone who can't appreciate it!</span>")
		return
	brush(target, user)
	return COMPONENT_CANCEL_ATTACK_CHAIN

//Brushes someone
/obj/item/hairbrush/proc/brush(mob/living/target, mob/user)
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		var/obj/item/bodypart/head = human_target.get_bodypart(BODY_ZONE_HEAD)

		//Don't brush if you can't reach their head or cancel the action
		if(!head) //No head? No bitches?
			to_chat(usr, "<span class='warning'>[human_target] has no head!</span>")
			return
		if(human_target.is_mouth_covered(head_only = 1))
			to_chat(usr, "<span class='warning'>You can't brush [human_target]'s hair while [human_target.p_their()] head is covered!</span>")
			return
		if(!do_mob(user, human_target,brush_speed))
			return

		// Do 1 brute to their head if they're bald. Should've been more careful.
		if(human_target.hair_style == "Bald" || human_target.hair_style == "Skinhead" && is_species(human_target, /datum/species/human)) //It can be assumed most anthros have hair on them!
			human_target.visible_message("<span class='warning'>[usr] scrapes the bristles uncomfortably over [human_target]'s scalp.</span>","<span class='warning'>You scrape the bristles uncomfortably over [human_target]'s scalp.</span>")
			playsound(target, 'hyperstation/sound/misc/bonk.ogg', 100, 1) //Until I fix it
			return

		//Brush their hair
		if(human_target == user)
			human_target.visible_message("<span class='notice'>[usr] brushes [usr.p_their()] hair!</span>","<span class='notice'>You brush your hair.</span>")
			//SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "brushed", /datum/mood/brushed/self)
		else
			user.visible_message("<span class='notice'>[usr] brushes [human_target]'s hair!</span>","<span class='notice'>You brush [human_target]'s hair.</span>")
			//SEND_SIGNAL(human_target, COMISG_ADD_MOOD_EVENT, "brushed", /datum/mood_event/brushed, user)



//fur dyer
#define COLOR_MODE_SPECIFIC "Specific Marking"
#define COLOR_MODE_GENERAL "General Color"

/obj/item/fur_dyer
	name = "electric fur dyer"
	desc = "Dye that is capable of recoloring fur in a mostly permanent way."
	icon = 'hyperstation/icons/obj/barber.dmi'
	icon_state = "fur_sprayer"
	w_class = WEIGHT_CLASS_TINY

	var/mode = COLOR_MODE_GENERAL
/*
/obj/item/fur_dyer/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/cell)
*/
/obj/item/fur_dyer/attack_self(mob/user, modifiers)
	. = ..()
	if(mode == COLOR_MODE_SPECIFIC)
		mode = COLOR_MODE_GENERAL
	else
		mode = COLOR_MODE_SPECIFIC

	to_chat(user, "Set to [mode]!")

/obj/item/fur_dyer/attack(mob/living/M, mob/living/user, params)
	if(!ishuman(M))
		return ..()

	var/mob/living/carbon/human/target_human = M

	switch(mode)
		if(COLOR_MODE_SPECIFIC)
			to_chat(user, "The device resonates ominously, and stops. It seems to be interfered by an Engram.")
			//dye_marking(target_human, user)
		if(COLOR_MODE_GENERAL)
			dye_general(target_human, user)

/obj/item/fur_dyer/proc/dye_general(mob/living/carbon/human/target_human, mob/living/user)
	var/selected_mutant_color = tgalert(user, "Please select which mutant color you'd like to change", "Select Color", "One", "Two", "Three")

	if(!selected_mutant_color)
		return

	var/selected_color = input(
			user,
			"Select marking color",
			null,
			"#FFFFFF"
		) as color | null

	if(!selected_color)
		return

	selected_color = sanitize_hexcolor(selected_color)

	visible_message("<span class='notice'>[user] starts to masterfully paint [target_human]!</span>")

	if(do_mob(user, target_human,20 SECONDS))
		switch(selected_mutant_color)
			if("One")
				target_human.dna.features["mcolor"] = selected_color
			if("Two")
				target_human.dna.features["mcolor2"] = selected_color
			if("Three")
				target_human.dna.features["mcolor3"] = selected_color

		target_human.regenerate_icons()
		//use power

		visible_message("<span class='notice'>[user] finishes painting [target_human]!</span>")

		playsound(src.loc, 'sound/effects/spray2.ogg', 50, TRUE)


/* We don't have markings that can be colored separately yet, so this is not needed
/obj/item/fur_dyer/proc/dye_marking(mob/living/carbon/human/target_human, mob/living/user)

	var/list/list/current_markings = target_human.dna.body_markings.Copy()

	if(!current_markings.len)
		to_chat(user, "<span class='warning'>[target_human] has no markings!</span>")
		return

	//power stuff here

	/var/selected_marking_area = user.zone_selected

	if(!current_markings[selected_marking_area])
		to_chat(user, "<span class='danger'>[target_human] has no bodymarkings on this limb!</span>")
		return

	var/selected_marking_id = input(user, "Please select which marking you'd like to color!", "Select marking", current_markings[selected_marking_area])

	if(!selected_marking_id)
		return

	var/selected_color = input(
			user,
			"Select marking color",
			null,
			"#FFFFFF"
		) as color | null

	if(!selected_color)
		return

	selected_color = sanitize_hexcolor(selected_color)

	visible_message("<span class='notice'>[user] starts to masterfully paint [target_human]!</span>")

	if(do_mob(user, target_human,20 SECONDS))
		current_markings[selected_marking_area][selected_marking_id] = selected_color

		target_human.dna.body_markings = current_markings.Copy()

		target_human.regenerate_icons()

		//item_use_power(power_use_amount, user)

		visible_message("<span class='notice'>[user] finishes painting [target_human]!</span>")

		playsound(src.loc, 'sound/effects/spray2.ogg', 50, TRUE)
*/

/obj/machinery/dryer
	name = "hand dryer"
	desc = "The Breath Of Lizards-3000, an experimental dryer."
	icon = 'hyperstation/icons/obj/dryer.dmi'
	icon_state = "dryer"
	density = FALSE
	anchored = TRUE
	var/busy = FALSE

/obj/machinery/dryer/attack_hand(mob/user)
	if(iscyborg(user) || isAI(user))
		return

	if(!can_interact(user))
		return

	if(busy)
		to_chat(user, "<span class='warning'>Someone is already drying here.</span>")
		return

	to_chat(user, "<span class='notice'>You start drying your hands.</span>")
	playsound(src, 'hyperstation/sound/salon/drying.ogg', 50)
	add_fingerprint(user)
	busy = TRUE
	if(do_mob(user, src,4 SECONDS))
		busy = FALSE
		user.visible_message("[user] dried their hands using \the [src].")
	else
		busy = FALSE

/obj/item/reagent_containers/dropper/precision
	name = "pipette"
	desc = "A high precision pippette. Holds 1 unit."
	icon = 'hyperstation/icons/obj/barber.dmi'
	icon_state = "pipette1"
	amount_per_transfer_from_this = 1
	possible_transfer_amounts = list(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1)
	volume = 1
	w_class = WEIGHT_CLASS_TINY

/obj/item/storage/box/lipsticks
	name = "lipstick box"

/obj/item/storage/box/lipsticks/PopulateContents()
	..()
	new /obj/item/lipstick(src)
	new /obj/item/lipstick/purple(src)
	new /obj/item/lipstick/jade(src)
	new /obj/item/lipstick/black(src)

/obj/item/lipstick/quantum
	name = "quantum lipstick"

/obj/item/lipstick/quantum/attack(mob/attacked_mob, mob/user)
	if(!open || !ismob(attacked_mob))
		return

	if(!ishuman(attacked_mob))
		to_chat(user, "<span class='warning'>Where are the lips on that?</span>")
		return

	var/new_color = input(
			user,
			"Select lipstick color",
			null,
			"#FFFFFF"
		) as color | null

	var/mob/living/carbon/human/target = attacked_mob
	if(target.is_mouth_covered())
		to_chat(user, "<span class='warning'>Remove [ target == user ? "your" : "[target.p_their()]" ] mask!</span>")
		return
	if(target.lip_style) //if they already have lipstick on
		to_chat(user, "<span class'warning'>You need to wipe off the old lipstick first!</span>")
		return

	if(target == user)
		visible_message("<span class='notice'>[user] does [user.p_their()] lips with \the [src].</span>","<span class='notice'>You take a moment to apply \the [src]. Perfect!</span>")
		target.lip_style = "lipstick"
		target.lip_color = new_color
		target.update_body()
		return

	visible_message("<span class='warning'>[user] begins to do [target]'s lips with \the [src].</span>","<span class='notice'>You begin to apply \the [src] on [target]'s lips...</span>")
	if(!do_mob(user, target = target,2 SECONDS))
		return
	visible_message("<span class='notice'>[user] does [target]'s lips with \the [src].</span>","<span class='notice'>You apply \the [src] on [target]'s lips.</span>")
	target.lip_style = "lipstick"
	target.lip_color = new_color
	target.update_body()

/obj/effect/decal/cleanable/hair
	name = "hair cuttings"
	icon = 'hyperstation/icons/obj/barber.dmi'
	icon_state = "cut_hair"

/obj/item/razor
	name = "electric razor"
	desc = "The latest and greatest power razor born from the science of shaving."
	icon = 'hyperstation/icons/obj/barber.dmi'
	icon_state = "razor"
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_TINY
	// How long do we take to shave someone's (facial) hair?
	var/shaving_time = 10 SECONDS

/obj/item/razor/proc/shave(mob/living/carbon/human/target_human, location = BODY_ZONE_PRECISE_MOUTH)
	if(location == BODY_ZONE_PRECISE_MOUTH)
		target_human.facial_hair_style = "Shaved"
	else
		target_human.hair_style = "Bald"

	target_human.update_hair()
	playsound(loc, 'sound/items/unsheath.ogg', 20, TRUE)

/obj/item/razor/attack(mob/attacked_mob, mob/living/user)
	if(ishuman(attacked_mob))
		var/mob/living/carbon/human/target_human = attacked_mob
		var/location = user.zone_selected
		if(!(location in list(BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_HEAD)))
			to_chat(user, "<span class='warning'>You stop, look down at what you're currently holding and ponder to yourself, \"This is probably to be used on their hair or their facial hair.\"</span>")
			return
		if((location in list(BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_HEAD)) && !target_human.get_bodypart(BODY_ZONE_HEAD))
			to_chat(user, "<span class='warning'>[target_human] doesn't have a head!</span>")
			return

		if(location == BODY_ZONE_PRECISE_MOUTH)
			if(!(FACEHAIR in target_human.dna.species.species_traits))
				to_chat(user, "<span class='warning'>There is no facial hair to shave!</span>")
				return
			if(!get_location_accessible(target_human, location))
				to_chat(user, "<span class'warning'>The mask is in the way!</span>")
				return
			if(target_human.facial_hair_style == "Shaved")
				to_chat(user, "<span class='warning'>Already clean-shaven!</span>")
				return

			var/self_shaving = target_human == user // Shaving yourself?
			visible_message("<span class='notice'>[user] starts to shave [self_shaving ? user.p_their() : "[target_human]'s"] hair with [src].</span>","<span class='notice'>You take a moment to shave [self_shaving ? "your" : "[target_human]'s" ] hair with [src]...</span>")
			if(do_mob(user, target = target_human,shaving_time))
				visible_message("<span class='notice'>[user] shaves [self_shaving ? user.p_their() : "[target_human]'s"] hair clean with [src].</span>","<span class='notice'>You finish shaving [self_shaving ? "your" : " [target_human]'s"] hair with [src]. Fast and clean!</span>")
				shave(target_human, location)

		else if(location == BODY_ZONE_HEAD)
			if(!(HAIR in target_human.dna.species.species_traits))
				to_chat(user, "<span class='warning'>There is no hair to shave!</span>")
				return
			if(!get_location_accessible(target_human, location))
				to_chat(user, "<span class='warning'>Their headgear is in the way!</span>")
				return
			if(target_human.hair_style == "Bald" || target_human.hair_style == "Balding Hair" || target_human.hair_style == "Skinhead")
				to_chat(user, "<span class='warning'>There is not enough hair left to shave!</span>")
				return

			var/self_shaving = target_human == user // Shaving yourself?
			visible_message("<span class='notice'>[user] starts to shave [self_shaving ? user.p_their() : "[target_human]'s"] hair with [src].</span>","<span class='notice'>You take a moment to shave [self_shaving ? "your" : "[target_human]'s" ] hair with [src]...</span>")
			if(do_mob(user, target = target_human,shaving_time))
				visible_message("<span class='notice'>[user] shaves [self_shaving ? user.p_their() : "[target_human]'s"] hair clean with [src].</span>","<span class='notice'>You finish shaving [self_shaving ? "your" : " [target_human]'s"] hair with [src]. Fast and clean!</span>")
				shave(target_human, location)
		else
			..()
	else
		..()

/obj/structure/sign/barber
	name = "barbershop sign"
	desc = "A glowing red-blue-white stripe you won't mistake for any other!"
	icon = 'hyperstation/icons/obj/barber.dmi'
	icon_state = "barber"
	buildable_sign = FALSE // Don't want them removed, they look too jank.

/obj/item/scissors
	name = "barber's scissors"
	desc = "Some say a barbers best tool is his electric razor, that is not the case. These are used to cut hair in a professional way!"
	icon = 'hyperstation/icons/obj/barber.dmi'
	icon_state = "scissors"
	w_class = WEIGHT_CLASS_TINY
	sharpness = TRUE
	// How long does it take to change someone's hairstyle?
	var/haircut_duration = 1 MINUTES
	// How long does it take to change someone's facial hair style?
	var/facial_haircut_duration = 20 SECONDS

/obj/item/scissors/attack(mob/living/carbon/attacked_mob, mob/living/user, params)
	if(!ishuman(attacked_mob))
		return

	var/mob/living/carbon/human/target_human = attacked_mob

	var/location = user.zone_selected
	if(!(location in list(BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_HEAD)))
		to_chat(user, "<span class='warning'>You stop, look down at what you're currently holding and ponder to yourself, \"This is probably to be used on their hair or their facial hair.\"</span>")
		return

	if(target_human.hair_style == "Bald" && target_human.facial_hair_style == "Shaved")
		to_chat(user, "<span class='warning'>What hair? They have none!</span>")
		return

	if(user.zone_selected != BODY_ZONE_HEAD)
		return ..()

	var/selected_part = tgalert(user, "Please select which part of [target_human] you would like to sculpt!", "It's sculpting time!", "Hair", "Facial Hair", "Cancel")

	if(!selected_part || selected_part == "Cancel")
		return

	if(selected_part == "Hair")
		if(!target_human.hair_style == "Bald" && target_human.head)
			to_chat(user, "<span class='warning'>There is no hair to cut!</span>")
			return

		var/hair_id = input(user, "Please select what hairstyle you'd like to sculpt!", "Select masterpiece") as null|anything in GLOB.hair_styles_list //dear god help me please
		if(!hair_id)
			return

		if(hair_id == "Bald")
			to_chat(target_human, "<span class='warning'>[user] seems to be cutting all your hair off!</span>")

		to_chat(user, "<span class='notice'>You begin to masterfully sculpt [target_human]'s hair!</span>")

		playsound(target_human, 'hyperstation/sound/salon/haircut.ogg', 100)

		if(!do_mob(user, attacked_mob, haircut_duration))
			return
		target_human.hair_style = hair_id
		target_human.update_hair()
		visible_message("<span class='notice'>[user] successfully cuts [target_human]'s hair!</span>","<span class='notice'>You successfully cut [target_human]'s hair!</span>")
		new /obj/effect/decal/cleanable/hair(get_turf(src))
	else
		if(!target_human.facial_hair_style == "Shaved" && target_human.wear_mask)
			to_chat(user, "<span class='warning'>There is no hair to cut!</span>")
			return

		var/facial_hair_id = input(user, "Please select what facial hairstyle you'd like to sculpt!", "Select masterpiece")  as null|anything in GLOB.facial_hair_styles_list
		if(!facial_hair_id)
			return

		if(facial_hair_id == "Shaved")
			to_chat(target_human, "<span class='warning'>[user] seems to be cutting all your facial hair off!</span>")

		to_chat(user, "<span class='notice'>You begin to masterfully sculpt [target_human]'s facial hair!</span>")

		playsound(target_human, 'hyperstation/sound/salon/haircut.ogg', 100)

		if(!do_mob(user, attacked_mob, facial_haircut_duration))
			return

		target_human.facial_hair_style = facial_hair_id
		target_human.update_hair()
		visible_message("<span class='notice'>[user] successfully cuts [target_human]'s facial hair!</span>","<span class='notice'>You successfully cut [target_human]'s facial hair!</span>")
		new /obj/effect/decal/cleanable/hair(get_turf(src))


//reagents
/obj/item/reagent_containers/spray/quantum_hair_dye
	name = "quantum hair dye"
	desc = "Changes hair colour RANDOMLY! Don't forget to read the label!"
	icon = 'hyperstation/icons/obj/barber.dmi'
	icon_state = "hairspraywhite"
	amount_per_transfer_from_this = 1
	possible_transfer_amounts = list(5,10)
	list_reagents = list(/datum/reagent/hair_dye = 30)
	volume = 50
/*
/obj/item/reagent_containers/spray/baldium
	name = "baldium spray"
	desc = "Causes baldness, exessive use may cause customer disatisfaction."
	icon = 'hyperstation/icons/obj/barber.dmi'
	icon_state = "hairremoval"
	amount_per_transfer_from_this = 1
	possible_transfer_amounts = list(5,10)
	list_reagents = list(/datum/reagent/baldium = 30)
	volume = 50
*/
/obj/item/reagent_containers/spray/barbers_aid
	name = "barber's aid"
	desc = "Causes rapid hair and facial hair growth!"
	icon = 'hyperstation/icons/obj/barber.dmi'
	icon_state = "hairaccelerator"
	amount_per_transfer_from_this = 1
	possible_transfer_amounts = list(5,10)
	list_reagents = list(/datum/reagent/barbers_aid = 50)
	volume = 50

/obj/item/reagent_containers/spray/super_barbers_aid
	name = "super barber's aid"
	desc = "Causes SUPER rapid hair and facial hair growth!"
	icon = 'hyperstation/icons/obj/barber.dmi'
	icon_state = "hairaccelerator"
	amount_per_transfer_from_this = 1
	possible_transfer_amounts = list(5,10)
	list_reagents = list(/datum/reagent/concentrated_barbers_aid = 30)
	volume = 50
