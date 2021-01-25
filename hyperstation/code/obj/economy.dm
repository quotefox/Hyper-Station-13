//Hyper station economy. Because coding it yourself is easier than port sometimes.

/obj/machinery/atm
	name = "automated teller machine"
	desc = "a wall mounted electronic banking outlet for accessing your bank account."
	icon = 'hyperstation/icons/obj/economy.dmi'
	icon_state = "atm"
	max_integrity = 250
	integrity_failure = 100
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 30)
	use_power = IDLE_POWER_USE
	idle_power_usage = 0
	active_power_usage = 0
	power_channel = ENVIRON
	resistance_flags = FIRE_PROOF
	var/obj/item/card/held_card
	var/user = ""
	light_power = 0
	light_range = 7
	light_color = "#ff3232"

/obj/machinery/atm/ui_interact(mob/user)
	. = ..()
	var/dat	=	{""}
	dat += "<body style='background-color:green;'><center>"
	dat += "<p>"
	dat += "<span class = 'big'><p>ATM</span></span></h1>"
	dat += "<b><p>Welcome to Hyper Station 13's Automated Bank Teller Service.</b>"
	dat += "<p>"
	if(!held_card)
		dat += "<p>Welcome, please insert your ID to continue."
	else
		dat += "<p>Welcome user, <a href='byond://?src=[REF(src)];card=1'>[held_card ? user : "------"]</a><br><br>"
		var/obj/item/card/id/idcard = held_card
		if(idcard.registered_account)
			dat += "<p>Account ID: <b>([idcard.registered_account.account_id])</b>"
			dat += "<p>Balance: <b>$[idcard.registered_account.account_balance]</b>"
			dat += "<p>"
			dat	+= "<a href='byond://?src=[REF(src)];withdraw=1'>Withdraw</A>"
			dat	+= "<a href='byond://?src=[REF(src)];pin=1'>Change Pin</A>"
			dat	+= "<a href='byond://?src=[REF(src)];settings=1'>Account Settings</A>"
			dat	+= "<a href='byond://?src=[REF(src)];card=1'>Eject</A>"
		else
			dat += "<p>Error, You don't seem to have a bank account with us.</b>"
		dat += "<p>"

	dat += "<p>"


	var/datum/browser/popup = new(user, "atm", "ATM")
	popup.set_content(dat)
	popup.set_title_image(user.browse_rsc_icon(icon, icon_state), 500,300)

	popup.open()

/obj/machinery/atm/attackby(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/card))
		if(!held_card)
			var/obj/item/card/id/idcard = I
			if(!user.transferItemToLoc(I, src)) //check if you can put it in
				return
			held_card = idcard
			user = idcard.registered_name
			playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)

/obj/machinery/atm/Topic(href, href_list)
	. = ..()
	if(..())
		return

	if(href_list["card"])
		if(held_card)
			if(usr.CanReach(src))
				if(usr.put_in_hands(held_card))
					to_chat(usr, "<span class='notice'>You take the ID out of the slot.</span>")
					held_card = null
					user = ""
				else
					to_chat(usr, "<span class='warning'>The machine drops the ID onto the floor!</span>")
					held_card = null
					user = ""
	if(href_list["withdraw"])
		if(held_card)
			var/obj/item/card/id/idcard = held_card
			if(idcard.registered_account)
				var/ammount = input(user, "Choose ammount", "Withdraw") as num|null
				if(ammount)
					ammount = max(min( round(text2num(ammount)), idcard.registered_account.account_balance),0)



	src.ui_interact(usr)


//Money, Well, get back, I'm all right Jack, Keep your hands off of my stack.
//making our own currency, just to stop exploits (for now)

/obj/item/stack/credits
	name = "credits"
	singular_name = "credit"
	icon = 'hyperstation/icons/obj/economy.dmi'
	icon_state = "cash"
	amount = 1
	max_amount = 100
	throwforce = 0
	throw_speed = 2
	throw_range = 2
	w_class = WEIGHT_CLASS_TINY
	full_w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	var/value = 1

/obj/item/stack/spacecash/proc/update_desc()
	var/total_worth = amount*value
	desc = "Legal tender, It's worth [total_worth] credit[( total_worth > 1 ) ? "s" : ""]"