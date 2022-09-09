/obj/item/organ/genital/lips
	name 					= "lips"
	desc 					= "for kissing and sucking."
	//icon_state 				= ""
	//icon 					= 'modular_citadel/icons/obj/genitals/????
	zone 					= "lips"
	slot 					= "lips"
	w_class 				= 3
	size 					= 0
	var/size_name			= "normal"
	var/statuscheck			= FALSE
	shape					= "Pair"
	can_masturbate_with 	= FALSE
	masturbation_verb 		= "massage"
	can_climax				= FALSE
	var/list/lips_types = list("nonexistant","average", "puffy")
	nochange				= TRUE


/obj/item/organ/genital/lips/on_life()
	if(QDELETED(src))
		return
	if(!owner)
		return

/obj/item/organ/genital/lips/update_appearance()
	var/string //Keeping this code here, so making multiple sprites for the different kinds is easier.
	var/lowershape = lowertext(shape)
	var/details

	switch(lowershape)
		if("nonexistant")
			details = "It's almost nonexistant"
		if("average")
			details = "It has a average looking shape"
		if("puffy")
			details = "It has a puffy looking shape"
		if("hyper")
			details = "It has a plump oversized shape"
		else
			details = "It has an exotic shape"

	desc = "You see a pair of lips. [details]"

	if(owner)
		if(owner.dna.species.use_skintones && owner.dna.features["genitals_use_skintone"])
			if(ishuman(owner)) // Check before recasting type, although someone fucked up if you're not human AND have use_skintones somehow...
				var/mob/living/carbon/human/H = owner // only human mobs have skin_tone, which we need.
				color = "#[skintone2hex(H.skin_tone)]"
				string = "lips-s"
		else
			color = "#[owner.dna.features["lips_color"]]"
			string  = "lips"
		if(ishuman(owner))
			var/mob/living/carbon/human/H = owner
			icon_state = sanitize_text(string)
			H.update_genitals()

