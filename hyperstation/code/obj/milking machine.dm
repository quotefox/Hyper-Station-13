/obj/item/milking_machine
	icon = 'hyperstation/icons/obj/milking_machine.dmi'
	name = "milking machine"
	icon_state = "Off"
	item_state = "Off"
	desc = "A pocket sized pump and tubing assembly designed to collect and store products from mammary glands."

	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_POCKET

	var/on = FALSE
	var/obj/item/reagent_containers/glass/inserted_item = null

	var/transfer_rate = 0.50 // How much we transfer every 2 seconds
	var/target_organ  = "breasts" // What organ we are transfering from

/obj/item/milking_machine/examine(mob/user)
	. = ..()
	to_chat(user, "<span class='notice'>[src] is currently [on ? "on" : "off"].</span>")
	if (inserted_item)
		to_chat(user, "<span class='notice'>[inserted_item] contains [inserted_item.reagents.total_volume]/[inserted_item.reagents.maximum_volume] units</span>")

/obj/item/milking_machine/attackby(obj/item/W, mob/user, params)
	add_fingerprint(user)
	if(istype(W, /obj/item/reagent_containers/glass) && !inserted_item)
		if(!user.transferItemToLoc(W, src))
			return ..()
		inserted_item = W
		UpdateIcon()
	else
		return ..()

/obj/item/milking_machine/interact(mob/user)
	if(!isAI(user) && inserted_item)
		add_fingerprint(user)
		on = !on
		if (on)
			to_chat(user, "<span class='notice'>You turn [src] on.</span>")
			START_PROCESSING(SSobj, src)
		else
			to_chat(user, "<span class='notice'>You turn [src] off.</span>")
			STOP_PROCESSING(SSobj, src)
		UpdateIcon()
	else
		..()

/obj/item/milking_machine/proc/UpdateIcon()
	icon_state = "[on ? "On" : "Off"][inserted_item ? "Beaker" : ""]"
	item_state = icon_state


/obj/item/milking_machine/AltClick(mob/living/user)
	add_fingerprint(user)
	user.put_in_hands(inserted_item)
	inserted_item = null
	on = FALSE
	STOP_PROCESSING(SSobj, src)
	UpdateIcon()

/obj/item/milking_machine/process()
	var/mob/living/carbon/W = loc
	if (W)
		var/obj/item/organ/genital/breasts/O = W.getorganslot(target_organ)
		if (O)
			if (O.reagents.total_volume >= transfer_rate * 2)
				if (inserted_item.reagents.total_volume < inserted_item.reagents.maximum_volume)
					O.reagents.trans_to(inserted_item.reagents, amount = transfer_rate)
				else
					to_chat(W, "<span class='notice'>[src] stops pumping. [inserted_item] is full.</span>")
					on = FALSE
					STOP_PROCESSING(SSobj, src)
					UpdateIcon()

/obj/item/milking_machine/penis
	name = "penis milking machine"
	icon_state = "PenisOff"
	item_state = "PenisOff"
	desc = "A pocket sized pump and tubing assembly designed to collect and store products from the penis."

	target_organ  = "testicles" // Since semen is stored in the balls

/obj/item/milking_machine/penis/UpdateIcon()
	icon_state = "Penis[on ? "On" : "Off"][inserted_item ? "Beaker" : ""]"
	item_state = icon_state
