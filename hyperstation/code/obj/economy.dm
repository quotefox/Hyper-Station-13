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
	var/pin = 0

/obj/machinery/atm/ui_interact(mob/user)
	. = ..()
	var/dat	=	{""}
	dat += "<p>"
	dat += "<center><span class = 'big'><p>ATM</span></span></h1>"
	dat += "<b><p>Welcome to Hyper Station 13's Automated Teller Service.</b>"
	dat += "<p>"
	if(!held_card)
		dat += "<p>Welcome, please insert your ID to continue."
	else
		dat += "<p>Welcome user, <a href='byond://?src=[REF(src)];card=1'>[held_card ? user : "------"]</a><br><br>"
		var/obj/item/card/id/idcard = held_card
		if(idcard.registered_account)
			dat += "<p>Account ID: <b>([idcard.registered_account.account_id])</b>"
		else
			dat += "<p>Error, this account number does not exsist, please contact your local administration.</b>"

		if(idcard.registered_account)
			if(!idcard.registered_account.account_pin || pin == idcard.registered_account.account_pin)
				dat += "<p>Balance: <b>$[idcard.registered_account.account_balance]</b>"
				//dat += "<p>Offstation Balance: <b()</b>"
				dat += "<p>"
				dat	+= "<a href='byond://?src=[REF(src)];withdraw=1'>Withdraw</A>"
				dat	+= "<a href='byond://?src=[REF(src)];changepin=1'>Change Pin</A>"
				//dat	+= "<a href='byond://?src=[REF(src)];settings=1'>Account Settings</A>"
				dat	+= "<a href='byond://?src=[REF(src)];card=1'>Eject</A>"
			else
				dat += "<p>Please enter your bank pin to continue!"
				dat += "<p>"
				dat	+= "<a href='byond://?src=[REF(src)];pin=1'>[pin ? pin : "----"]</a><br><br>"

		dat += "<p></center>"

	dat += "<p>"


	var/datum/browser/popup = new(user, "atm", "ATM")
	popup.set_content(dat)
	popup.set_title_image(user.browse_rsc_icon(icon, icon_state), 500,300)

	popup.open()

/obj/machinery/atm/attackby(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/card)) //input id!
		if(!held_card)
			var/obj/item/card/id/idcard = I
			if(!user.transferItemToLoc(I, src)) //check if you can put it in
				return
			held_card = idcard
			user = idcard.registered_name
			pin = ""
			playsound(src, 'sound/machines/button.ogg', 50, FALSE)
			src.ui_interact(usr)

	if(istype(I, /obj/item/stack/credits)) //feed money back into the machine! dont need a pin to donate stuff.
		if(held_card)
			var/obj/item/stack/credits/cred = I
			var/obj/item/card/id/idcard = held_card
			idcard.registered_account.account_balance = (idcard.registered_account.account_balance+cred.amount)
			to_chat(usr, "<span class='notice'>You insert [cred] into the ATM.</span>")
			src.ui_interact(usr)
			del(cred)

/obj/machinery/atm/Topic(href, href_list)
	. = ..()
	if(..())
		return

	if(href_list["card"])
		if(held_card)
			if(usr.CanReach(src))
				playsound(src, 'sound/machines/button.ogg', 50, FALSE)
				if(usr.put_in_hands(held_card))
					to_chat(usr, "<span class='notice'>You take the ID out of the slot.</span>")
					held_card = null
				else
					to_chat(usr, "<span class='warning'>The machine drops the ID onto the floor!</span>")
					held_card = null
				pin = ""
				user = ""

	if(href_list["pin"])
		playsound(src, get_sfx("terminal_type"), 25, 1)
		var/pininput = input(user, "Input pin", "Pin Number") as num|null
		if(pininput)
			if(pininput > 9999 || pininput < 1000)
				to_chat(usr, "<span class='notice'>[src.name] buzzes, you must input a 4 digit number between 1000 and 9999.</span>")
				return
			pin = max(min( round(text2num(pininput)), 9999),1000) //4 numbers or less.
			var/obj/item/card/id/idcard = held_card
			if(pin == idcard.registered_account.account_pin)
				to_chat(usr, "<span class='notice'>[src.name] beeps, accepting the pin.</span>")
			else
				to_chat(usr, "<span class='notice'>[src.name] buzzes, denying the pin.</span>")

	if(href_list["changepin"])
		playsound(src, get_sfx("terminal_type"), 25, 1)
		var/pinchange = input(user, "Input pin", "Pin Number") as num|null
		if(pinchange > 9999 || pinchange < 1000)
			to_chat(usr, "<span class='warning'>[src.name], you must have a 4 digit number for a pin and be between 1000 and 9999.</span>")
			return
		if(pinchange)
			var/pinchange2 = input(user, "Confirm pin", "Confirm pin") as num|null //time to confirm!
			if(pinchange == pinchange2)
				var/obj/item/card/id/idcard = held_card
				idcard.registered_account.account_pin = pinchange
				to_chat(usr, "<span class='notice'>[src.name] beeps, your pin has been changed to [pinchange]!.</span>")
			else
				to_chat(usr, "<span class='warning'>[src.name] buzzes, your pins did not match!</span>")
		pin = ""

	if(href_list["withdraw"])
		playsound(src, get_sfx("terminal_type"), 25, 1)
		if(held_card)
			var/obj/item/card/id/idcard = held_card
			if(idcard.registered_account)
				var/amount = input(user, "Choose amount", "Withdraw") as num|null
				if(amount>0)
					amount = max(min( round(text2num(amount)), idcard.registered_account.account_balance),0) //make sure they aint taking out more then what they have
					to_chat(usr, "<span class='notice'>The machine prints out [amount] credits.</span>")
					idcard.registered_account.account_balance = (idcard.registered_account.account_balance-amount) //subtract the amount they took out.
					var/obj/item/stack/credits/C = new /obj/item/stack/credits/(loc)
					C.amount = amount
					if(usr.put_in_hands(C))
						to_chat(usr, "<span class='notice'>You take [C] out of the ATM.</span>")

	src.ui_interact(usr)


//Money, Well, get back, I'm all right Jack, Keep your hands off of my stack.
//making our own currency, just to stop exploits (for now)

/obj/item/stack/credits
	name = "credits"
	singular_name = "credit"
	desc = "Legal tender, a bundle of shiny metalic looking notes."
	icon = 'hyperstation/icons/obj/economy.dmi'
	icon_state = "cash"
	amount = 1
	max_amount = 99999999
	throwforce = 0
	throw_speed = 2
	throw_range = 2
	w_class = WEIGHT_CLASS_TINY
	full_w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	var/value = 1
