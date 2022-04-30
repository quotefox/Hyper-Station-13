/mob/living/carbon
	var/total_pain = 0
	var/pain_effect = 0
	var/pain_cooldown = 0 //for defibs/surgry!

//pain
/mob/living/carbon/adjustPainLoss(amount, updating_health = TRUE, forced = FALSE, affected_zone = BODY_ZONE_CHEST)
	if(!forced && (status_flags & GODMODE))
		return FALSE
	apply_damage(amount > 0 ? amount : amount, PAIN, affected_zone)
	return amount

/mob/living/carbon/handle_status_effects()
	..()
	handle_pain()

/mob/living/carbon/proc/handle_pain()
	var/pain_amount = 0

	pain_effect += 1

	if (pain_cooldown)
		pain_cooldown -= 1
		pain_effect = 0 //ignore pain for now, you got adrenaline running through your body.

	//build up pain in the system from all your limbs and natrually heal pain if its attached to a live body.
	for(var/obj/item/bodypart/BP  in bodyparts)
		pain_amount += BP.pain_dam

		var/pain_target = (BP.brute_dam + BP.burn_dam)*0.8
		//natural healing of pain, capped at current damage * 0.8, if the pain is lower, slowly bring up the pain. this will let people "get used, to it."
		if (BP.pain_dam > (pain_target))
			BP.pain_dam -= 1 //bring down to the pain_level.
		else
			BP.pain_dam += 1 //slowly bring pain back, from pain killers.

		//just make sure its zero'd
		if (BP.pain_dam < 0)
			BP.pain_dam = 0
			continue //dont need to do the rest, your fine.

		if (BP.pain_dam && pain_effect > 5 && (stat == 0))
			var pain_level = (round(BP.pain_dam / 10))
			switch(pain_level) //for every 10 points of damage minor -> major
				if(1)//start at 10 just so it doesnt get annoying with micro damage
					to_chat(src, "<span class='warning'>You feel minor pain in your [BP.name].</span>")
				if(2)
					to_chat(src, "<span class='warning'>You feel pain in your [BP.name].</span>")
				if(3)
					to_chat(src, "<span class='warning'>You feel severe pain in your [BP.name].</span>")
				if(4 to 99)
					to_chat(src, "<span class='warning'>You feel overwhelming pain in your [BP.name].</span>")
					jitteriness += 2
					stuttering += 2


	total_pain = pain_amount

	//handle onscreen alert
	if (pain_effect > 5)
		switch(total_pain)
			if(-100 to 25)
				clear_alert("pain")
			if(25 to 69)
				throw_alert("pain", /obj/screen/alert/pain)
			if(70 to 99)
				throw_alert("pain", /obj/screen/alert/painmajor)
			if(100 to 999)
				throw_alert("pain", /obj/screen/alert/painshock)

	if (pain_effect > 5)
		pain_effect = 0 //reset the timer 5 seconds.
		if(stat == 0) //awake, not dead or asleep
			//status effects for pain..
			var/mob/living/H = src
			if (total_pain > 50 && total_pain < 80)
				if(HAS_TRAIT(H, TRAIT_MASO)) //just because your into it doesnt give you a advantage..
					to_chat(src, "<span class='love'>You love this pain, it excites you...</span>")
					H.adjustArousalLoss(6)
				else
					to_chat(src, "<span class='warning'>You cant handle the pain...</span>")
				if(prob(20))
					emote("scream")
				do_jitter_animation() //basic shake.
				stuttering += 3	 //stutter words, your in pain bro.

			if (total_pain > 80) //your in trouble. fainting..
				if(HAS_TRAIT(H, TRAIT_MASO))
					to_chat(src, "<span class='love'>You love this intense pain, it excites you...</span>")
					H.adjustArousalLoss(12)
				else
					to_chat(src, "<span class='big warning'>You cant handle the intense pain...</span>")
				if(prob(20)) //chance of fainting..
					visible_message("<span class='danger'>[src] collapses!</span>")
					Unconscious(100)
				jitteriness += 3 //shake
				stuttering += 3	 //stutter words

	//if they are asleep, this wont trigger.
	if (total_pain > 120 && stat == 0) //taking 130 all damage at once from full health, will put you into shock and kill you. This cant be achived with chip damage (or fist fights), because youll die before you reach this pain level.
		if(prob(50))
			emote("scream")//scream
		to_chat(src, "<span class='big warning'>You give into the pain...</span>")
		visible_message("<span class='danger'>[src] goes into neurogenic shock!</span>")
		Unconscious(200)
		if (can_heartattack()) //check if they can
			set_heartattack(1) //heart stopped!


//HS Pain heal
/mob/living/carbon/adjustPainLoss(amount, updating_health = TRUE, forced = FALSE)
	if (!forced && amount < 0 && HAS_TRAIT(src,TRAIT_NONATURALHEAL))
		return FALSE
	if(!forced && (status_flags & GODMODE))
		return FALSE

	//all attached limbs get pain damage
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		BP.pain_dam += amount

	return amount