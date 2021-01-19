/obj/item/implant/psychobrawl
	name = "Psychotic Brawling implant"
	desc = "Teaches you the arts of Psychotic Brawling in 5 short instructional videos beamed directly into your eyeballs."
	icon = 'icons/obj/surgery.dmi'
	icon_state ="brain"
	activated = 1
	var/datum/martial_art/psychotic_brawling/style = new

/obj/item/implant/psychobrawl/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Psychotic Brawling Implant<BR>
				<b>Life:</b> 4 hours after death of host<BR>
				<b>Implant Details:</b> <BR>
				<b>Function:</b> Teaches even the clumsiest host the arts of Psychotic Brawling."}
	return dat

/obj/item/implant/psychobrawl/activate()
	. = ..()
	var/mob/living/carbon/human/H = imp_in
	if(!ishuman(H))
		return
	if(!H.mind)
		return
	if(H.mind.has_martialart(MARTIALART_PSYCHOBRAWL))
		style.remove(H)
		to_chat(H, "<span class='notice'>You forget the teachings of Psychotic Brawling.</span>")
	else
		style.teach(H,1)
		to_chat(H, "<span class='notice'>You learn the arts of Psychotic Brawling!</span>")

/obj/item/implanter/psychobrawl
	name = "implanter (Psychotic Brawling)"
	imp_type = /obj/item/implant/psychobrawl

/obj/item/implantcase/psychobrawl
	name = "implant case - 'Psychotic Brawling'"
	desc = "A glass case containing an implant that can teach the user the arts of Psychotic Brawling."
	imp_type = /obj/item/implant/psychobrawl
