/obj/item/organ/genital/belly //I know, I know a belly aint a genital. but it is in the sake of code.
	name 					= "belly"
	desc 					= "You see a belly on their midsection."
	icon_state 				= "belly"
	icon 					= 'modular_citadel/icons/obj/genitals/breasts.dmi'
	zone 					= "chest"
	slot 					= "belly"
	w_class 				= 3
	size 					= 0
	var/statuscheck			= FALSE
	shape					= "round"
	masturbation_verb 		= "massage"
	can_climax				= FALSE
	var/sent_full_message	= TRUE //defaults to 1 since they're full to start
	var/inflatable			= FALSE //For inflation connoisseurs


/obj/item/organ/genital/belly/on_life()
	if(QDELETED(src))
		return
	if(!owner)
		return

/obj/item/organ/genital/belly/update_appearance()
	var/string
	if(owner)
		if(owner.dna.species.use_skintones && owner.dna.features["genitals_use_skintone"])
			if(ishuman(owner))
				var/mob/living/carbon/human/H = owner
				color = "#[skintone2hex(H.skin_tone)]"
		else
			color = "#[owner.dna.features["belly_color"]]"
		if(ishuman(owner))
			var/mob/living/carbon/human/H = owner
			icon_state = sanitize_text(string)
			H.update_genitals()

			icon_state = sanitize_text(string)


