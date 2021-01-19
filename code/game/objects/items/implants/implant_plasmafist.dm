/obj/item/implant/plasmafist
	name = "Plasma Fist implant"
	desc = "Teaches you the arts of Plasma Fist in 5 short instructional videos beamed directly into your eyeballs."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state ="disintegrate"
	activated = 1
	var/datum/martial_art/plasma_fist/style = new

/obj/item/implant/plasmafist/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Plasma Fist Implant<BR>
				<b>Life:</b> 4 hours after death of host<BR>
				<b>Implant Details:</b> <BR>
				<b>Function:</b> Teaches even the clumsiest host the arts of Plasma Fist."}
	return dat

/obj/item/implant/plasmafist/activate()
	. = ..()
	var/mob/living/carbon/human/H = imp_in
	if(!ishuman(H))
		return
	if(!H.mind)
		return
	if(H.mind.has_martialart(MARTIALART_PLASMAFIST))
		style.remove(H)
		to_chat(H, "<span class='notice'>You forget the teachings of the Plasma Fist.</span>")
	else
		style.teach(H,1)
		to_chat(H, "<span class='notice'>You learn the arts of the Plasma Fist!</span>")

/obj/item/implanter/plasmafist
	name = "implanter (Plasma Fist)"
	imp_type = /obj/item/implant/plasmafist

/obj/item/implantcase/plasmafist
	name = "implant case - 'Plasma Fist'"
	desc = "A glass case containing an implant that can teach the user the arts of Plasma Fist."
	imp_type = /obj/item/implant/plasmafist
