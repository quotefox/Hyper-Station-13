/obj/structure/medscreen/
	name = "medical screen"
	desc = "No peaking now!"
	icon_state = "screen"
	icon = 'hyperstation/icons/obj/medical.dmi'
	anchored = TRUE
	resistance_flags = FLAMMABLE
	max_integrity = 100
	integrity_failure = 30
	var/buildstacktype = /obj/item/stack/sheet/metal
	var/buildstackamount = 2
	density = TRUE

/obj/structure/medscreen/Moved()
	. = ..()
	if(has_gravity())
		playsound(src, 'sound/effects/roll.ogg', 100, 1)
