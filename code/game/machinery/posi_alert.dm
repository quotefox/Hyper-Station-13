/obj/machinery/posialert
	name = "automated positronic alert console"
	desc = "A console that will ping when a positronic personality is available for download."
	icon = 'icons/obj/machines/terminals.dmi'
	icon_state = "posialert"
	var/inuse = FALSE
	var/online = TRUE

	var/obj/item/radio/radio
	var/radio_key = /obj/item/encryptionkey/headset_sci
	var/science_channel = "Science"

/obj/machinery/posialert/Initialize()
	. = ..()
	radio = new(src)
	radio.keyslot = new radio_key
	radio.listening = 0
	radio.recalculateChannels()

/obj/machinery/posialert/Destroy()
	QDEL_NULL(radio)
	return ..()
	

/obj/machinery/posialert/attack_hand(mob/living/user)
	online = !online
	to_chat(user, "<span class='warning'>You turn the posi-alert system [online ? "on" : "off"]!</span>")
	return

/obj/machinery/posialert/attack_ghost(mob/user)
	. = ..()
	if(!online)
		return
	if(inuse)
		return
	inuse = TRUE
	flick("posialertflash",src)
	visible_message("There are positronic personalities available!", runechat_popup = TRUE)
	radio.talk_into(src, "There are positronic personalities available!", science_channel)
	playsound(loc, 'sound/machines/ping.ogg', 50)
	addtimer(CALLBACK(src, .proc/liftcooldown), 300)

/obj/machinery/posialert/proc/liftcooldown()
	inuse = FALSE
