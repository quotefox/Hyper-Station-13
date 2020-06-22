/obj/item/organ/genital/testicles
	name 					= "testicles"
	desc 					= "A male reproductive organ."
	icon_state 				= "testicles"
	icon 					= 'modular_citadel/icons/obj/genitals/testicles.dmi'
	zone 					= "groin"
	slot 					= "testicles"
	size 					= BALLS_SIZE_MIN
	var/size_name			= "average"
	shape					= "single"
	var/sack_size			= BALLS_SACK_SIZE_DEF
	var/cached_size			= 6
	//fluid_mult				= 0.133 // Set to a lower value due to production scaling with size (I.E. 6 inches the "normal" amount)
	fluid_mult				= 1.0 //Defaults to 1 no matter what you do. It just does. Just gonna adapt I guess.
	fluid_max_volume		= 3
	fluid_id 				= "semen"
	producing				= TRUE
	can_masturbate_with		= FALSE
	masturbation_verb 		= "massage"
	can_climax				= TRUE
	var/sent_full_message	= TRUE //defaults to 1 since they're full to start

/obj/item/organ/genital/testicles/on_life()
	if(QDELETED(src))
		return
	if(!reagents || !owner)
		return
	//reagents.maximum_volume = fluid_max_volume * cached_size// fluid amount is also scaled by the size of the organ
	reagents.maximum_volume = fluid_max_volume * ((cached_size / 2) + 1) * ((size / 2) + 1) * fluid_mult //Hyper - New calculation for more dynamic fluid levels. I can't believe I typed that.
	if(fluid_id && producing)
		if(reagents.total_volume == 0) // Apparently, 0.015 gets rounded down to zero and no reagents are created if we don't start it with 0.1 in the tank.
			fluid_rate = 0.1
		else
			//fluid_rate = CUM_RATE * cached_size * fluid_mult // fluid rate is scaled by the size of the organ
			fluid_rate = ((CUM_RATE / 5) * (cached_size / 3) * (size / 4) * fluid_mult) / 10 //Hyper - Production was way too high by default. This should drop it back down, but allow for it to get really high
		generate_cum()

/obj/item/organ/genital/testicles/proc/generate_cum()
	//reagents.maximum_volume = fluid_max_volume //This is the line that broke cum for so long
	if(reagents.total_volume >= reagents.maximum_volume - 0.1) //Hyper - Check for it being close to the maximum. It sometimes doesn't proc due to a rounding error.
		if(!sent_full_message)
			send_full_message()
			sent_full_message = TRUE
		return FALSE
	sent_full_message = FALSE
	update_link()
	if(!linked_organ)
		return FALSE
	reagents.isolate_reagent(fluid_id)//remove old reagents if it changed and just clean up generally
	reagents.add_reagent(fluid_id, (fluid_rate))//generate the cum

/obj/item/organ/genital/testicles/update_link()
	if(owner && !QDELETED(src))
		linked_organ = (owner.getorganslot("penis"))
		if(linked_organ)
			linked_organ.linked_organ = src
			size = linked_organ.size
			var/obj/item/organ/genital/penis/O = linked_organ
			cached_size = O.length
	else
		if(linked_organ)
			linked_organ.linked_organ = null
		linked_organ = null

/obj/item/organ/genital/testicles/proc/send_full_message(msg = "Your balls finally feel full, again.")
	if(owner && istext(msg))
		to_chat(owner, msg)
		return TRUE

/obj/item/organ/genital/testicles/update_appearance()
	switch(size)
		//if(0.1 to 1) //Hyper - Change the displayed ball sizes
		if(0.1 to 3)
			size_name = "average"
		//if(1.1 to 2)
		if(3.1 to 8)
			size_name = "enlarged"
		//if(2.1 to INFINITY)
		if(8.1 to INFINITY)
			size_name = "engorged"
		else
			size_name = "nonexistant"

	if(!internal)
		desc = "You see an [size_name] pair of testicles."
	else
		desc = "They don't have any testicles you can see."

	if(owner)
		var/string
		if(owner.dna.species.use_skintones && owner.dna.features["genitals_use_skintone"])
			if(ishuman(owner)) // Check before recasting type, although someone fucked up if you're not human AND have use_skintones somehow...
				var/mob/living/carbon/human/H = owner // only human mobs have skin_tone, which we need.
				color = "#[skintone2hex(H.skin_tone)]"
				string = "testicles_[GLOB.balls_shapes_icons[shape]]_[size]-s"
		else
			color = "#[owner.dna.features["balls_color"]]"
			string = "testicles_[GLOB.balls_shapes_icons[shape]]_[size]"
		if(ishuman(owner))
			var/mob/living/carbon/human/H = owner
			icon_state = sanitize_text(string)
			H.update_genitals()
