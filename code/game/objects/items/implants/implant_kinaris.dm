/obj/item/implant/kinaris
	name = "KNS ENH implant"
	desc = "Enables enhanced reflexes, permitting the user to deploy specialised training."
	icon = 'icons/obj/implants.dmi'
	icon_state ="adrenal"
	activated = 1
	var/datum/martial_art/kinaris/style = new

/obj/item/implant/kinaris/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> KNS ENH Implant<BR>
				<b>Life:</b> Roughly twelve hours after death of host<BR>
				<b>Implant Details:</b> <BR>
				<b>Function:</b> Forces certain sections of the brain and body into a state of higher function, permitting the user to deploy specialised training."}
	return dat

/obj/item/implant/kinaris/activate()
	. = ..()
	var/mob/living/carbon/human/H = imp_in
	if(!ishuman(H))
		return
	if(!H.mind)
		return
	if(H.mind.has_martialart(MARTIALART_KNS_CQC))
		style.remove(H)
		to_chat(H, "<span class='notice'>You disable your reflex implant.</span>")
	else
		style.teach(H,1)
		to_chat(H, "<span class='notice'>You feel your body burn briefly as you enable your reflex implant.</span>")

/obj/item/implanter/kinaris
	name = "implanter (KNS ENH)"
	imp_type = /obj/item/implant/kinaris

/obj/item/implantcase/kinaris
	name = "implant case - 'KNS ENH'"
	desc = "A glass case containing an implant that can enhance the body of the user."
	imp_type = /obj/item/implant/kinaris
