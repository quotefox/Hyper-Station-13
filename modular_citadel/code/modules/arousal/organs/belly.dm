/obj/item/organ/genital/belly //I know, I know a belly aint a genital. but it is in the sake of code.
	name 					= "belly"
	desc 					= "a belly."
	icon_state 				= "belly"
	icon 					= 'modular_citadel/icons/obj/genitals/breasts.dmi'
	zone 					= "chest"
	slot 					= "belly"
	w_class 				= 3
	size 					= 1
	var/breast_values 		= list ("a" =  1, "b" = 2, "c" = 3, "d" = 4, "e" = 5, "f" = 6, "g" = 7, "h" = 8, "i" = 9, "j" = 10, "k" = 11, "l" = 12, "m" = 13, "n" = 14, "o" = 15, "huge" = 16, "massive" = 17, "giga" = 25, "impossible" = 30, "flat" = 0) // Note: Do not forget to define new sizes.
	var/statuscheck			= FALSE
	shape					= "Pair"
	can_masturbate_with		= TRUE
	masturbation_verb 		= "massage"
	can_climax				= TRUE
	fluid_transfer_factor 	= 0.5
	var/sent_full_message	= TRUE //defaults to 1 since they're full to start

/obj/item/organ/genital/belly/on_life()
	if(QDELETED(src))
		return
	if(!owner)
		return

/obj/item/organ/genital/belly/update_appearance()
	var/string
	if(owner)
		if(owner.dna.species.use_skintones && owner.dna.features["genitals_use_skintone"])
			if(ishuman(owner)) .
				var/mob/living/carbon/human/H = owner
				color = "#[skintone2hex(H.skin_tone)]"
		else
			color = "#[owner.dna.features["belly_color"]]"
		if(ishuman(owner))
			var/mob/living/carbon/human/H = owner
			icon_state = sanitize_text(string)
			H.update_genitals()

			icon_state = sanitize_text(string)


