/obj/item/implant/wrestling
	name = "Wrestling implant"
	desc = "Teaches you the arts of Wrestling in 5 short instructional videos beamed directly into your eyeballs."
	icon = 'icons/obj/clothing/masks.dmi'
	icon_state ="luchador"
	activated = 1
	var/datum/martial_art/wrestling/style = new

/obj/item/implant/wrestling/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Wrestling Implant<BR>
				<b>Life:</b> 4 hours after death of host<BR>
				<b>Implant Details:</b> <BR>
				<b>Function:</b> Teaches even the clumsiest host the arts of Wrestling."}
	return dat

/obj/item/implant/wrestling/activate()
	. = ..()
	var/mob/living/carbon/human/H = imp_in
	if(!ishuman(H))
		return
	if(!H.mind)
		return
	if(H.mind.has_martialart(MARTIALART_WRESTLING))
		style.remove(H)
		to_chat(H, "<span class='notice'>You forget the teachings of Wrestling.</span>")
	else
		style.teach(H,1)
		to_chat(H, "<span class='notice'>You learn the arts of Wrestling!</span>")

/obj/item/implanter/wrestling
	name = "implanter (Wrestling)"
	imp_type = /obj/item/implant/wrestling

/obj/item/implantcase/wrestling
	name = "implant case - 'Wrestling'"
	desc = "A glass case containing an implant that can teach the user the arts of Wrestling."
	imp_type = /obj/item/implant/wrestling
