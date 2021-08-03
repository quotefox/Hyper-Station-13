/obj/item/organ/genital/anus
	name 					= "anus"
	desc 					= "You see a pair of asscheeks."
	icon_state 				= "butt"
	icon 					= 'modular_citadel/icons/obj/genitals/breasts.dmi'
	zone 					= "anus"
	slot 					= "anus"
	w_class 				= 3
	size 					= 0
	var/size_name			= "nonexistant"
	var/statuscheck			= FALSE
	shape					= "Pair"
	can_masturbate_with 	= FALSE
	masturbation_verb 		= "massage"
	can_climax				= FALSE

/obj/item/organ/genital/anus/on_life()
	if(QDELETED(src))
		return
	if(!owner)
		return

/obj/item/organ/genital/anus/update_appearance()
	var/string
	var/lowershape = lowertext(shape)

	//Reflect the size of dat ass on examine.
	switch(size)
		if(1)
			size_name = "average"
		if(2)
			size_name = "sizable"
		if(3)
			size_name = "hefty"
		if(4)
			size_name = "godly"
		else
			size_name = "nonexistant"

	desc = "You see a [lowershape] of [size_name] asscheeks."

	if(owner)
		var/mob/living/carbon/human/H = owner
		color = "#[skintone2hex(H.skin_tone)]"

		if(ishuman(owner))
			icon_state = sanitize_text(string)
			H.update_genitals()

			icon_state = sanitize_text(string)

