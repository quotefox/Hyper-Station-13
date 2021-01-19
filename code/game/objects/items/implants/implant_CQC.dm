/obj/item/implant/cqc
	name = "CQC implant"
	desc = "Teaches you the arts of CQC in 5 short instructional videos beamed directly into your eyeballs."
	icon = 'icons/obj/library.dmi'
	icon_state ="cqcmanual"
	activated = 1
	var/datum/martial_art/cqc/style = new

/obj/item/implant/cqc/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> CQC Implant<BR>
				<b>Life:</b> 4 hours after death of host<BR>
				<b>Implant Details:</b> <BR>
				<b>Function:</b> Teaches even the clumsiest host the arts of CQC."}
	return dat

/obj/item/implant/cqc/activate()
	. = ..()
	var/mob/living/carbon/human/H = imp_in
	if(!ishuman(H))
		return
	if(!H.mind)
		return
	if(H.mind.has_martialart(MARTIALART_CQC))
		style.remove(H)
		to_chat(H, "<span class='notice'>You forget the basics of CQC.</span>")
	else
		style.teach(H,1)
		to_chat(H, "<span class='notice'>You remember the basics of CQC!</span>")

/obj/item/implanter/cqc
	name = "implanter (CQC)"
	imp_type = /obj/item/implant/cqc

/obj/item/implantcase/cqc
	name = "implant case - 'CQC'"
	desc = "A glass case containing an implant that can teach the user the arts of CQC."
	imp_type = /obj/item/implant/cqc
