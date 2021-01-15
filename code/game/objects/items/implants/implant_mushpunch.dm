/obj/item/implant/mushpunch
	name = "Mushroom Punch implant"
	desc = "Teaches you the arts of Mushroom Punch in 5 short instructional videos beamed directly into your eyeballs."
	icon = 'icons/obj/hydroponics/harvest.dmi'
	icon_state ="angel"
	activated = 1
	var/datum/martial_art/mushpunch/style = new

/obj/item/implant/mushpunch/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Mushroom Punch Implant<BR>
				<b>Life:</b> 4 hours after death of host<BR>
				<b>Implant Details:</b> <BR>
				<b>Function:</b> Teaches even the clumsiest host the arts of Mushroom Punch."}
	return dat

/obj/item/implant/mushpunch/activate()
	. = ..()
	var/mob/living/carbon/human/H = imp_in
	if(!ishuman(H))
		return
	if(!H.mind)
		return
	if(H.mind.has_martialart(MARTIALART_MUSHPUNCH))
		style.remove(H)
		to_chat(H, "<span class='notice'>You forget the teachings of Mushroom Punch.</span>")
	else
		style.teach(H,1)
		to_chat(H, "<span class='notice'>You learn the arts of Mushroom Punch!</span>")

/obj/item/implanter/mushpunch
	name = "implanter (Mushroom Punch)"
	imp_type = /obj/item/implant/mushpunch

/obj/item/implantcase/mushpunch
	name = "implant case - 'Mushroom Punch'"
	desc = "A glass case containing an implant that can teach the user the arts of Mushroom Punch."
	imp_type = /obj/item/implant/mushpunch
