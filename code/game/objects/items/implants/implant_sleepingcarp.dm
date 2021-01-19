/obj/item/implant/sleepingcarp
	name = "Sleeping Carp implant"
	desc = "Teaches you the arts of Sleeping Carp in 5 short instructional videos beamed directly into your eyeballs."
	icon = 'icons/obj/wizard.dmi'
	icon_state ="scroll2"
	activated = 1
	var/datum/martial_art/the_sleeping_carp/style = new

/obj/item/implant/sleepingcarp/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Sleeping Carp Implant<BR>
				<b>Life:</b> 4 hours after death of host<BR>
				<b>Implant Details:</b> <BR>
				<b>Function:</b> Teaches even the clumsiest host the arts of Sleeping Carp."}
	return dat

/obj/item/implant/sleepingcarp/activate()
	. = ..()
	var/mob/living/carbon/human/H = imp_in
	if(!ishuman(H))
		return
	if(!H.mind)
		return
	if(H.mind.has_martialart(MARTIALART_SLEEPINGCARP))
		style.remove(H)
		to_chat(H, "<span class='notice'>You forget the teachings of the Sleeping Carp.</span>")
	else
		style.teach(H,1)
		to_chat(H, "<span class='notice'>You learn the arts of the Sleeping Carp!</span>")

/obj/item/implanter/sleepingcarp
	name = "implanter (Sleeping Carp)"
	imp_type = /obj/item/implant/sleepingcarp

/obj/item/implantcase/sleepingcarp
	name = "implant case - 'Sleeping Carp'"
	desc = "A glass case containing an implant that can teach the user the arts of Sleeping Carp."
	imp_type = /obj/item/implant/sleepingcarp
