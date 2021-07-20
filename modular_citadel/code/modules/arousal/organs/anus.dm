/obj/item/organ/genital/anus
	name 					= "anus"
	desc 					= "You see a butt."
	icon_state 				= "butt"
	icon 					= 'modular_citadel/icons/obj/genitals/breasts.dmi'
	zone 					= "groin"
	slot 					= "anus"
	w_class 				= 3
	size 					= 0
	var/statuscheck			= FALSE
	shape					= "Pair"
	masturbation_verb 		= "massage"
	can_climax				= FALSE




/obj/item/organ/genital/anus/on_life()
	if(QDELETED(src))
		return
	if(!owner)
		return


/obj/item/organ/genital/anus/update_appearance()
	var/string
	if(owner)
		var/mob/living/carbon/human/H = owner
		color = "#[skintone2hex(H.skin_tone)]"

		if(ishuman(owner))
			icon_state = sanitize_text(string)
			H.update_genitals()

			icon_state = sanitize_text(string)

