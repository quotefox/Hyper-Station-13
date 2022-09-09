//Mob vars
/mob/living
	var/arousalloss = 0									//How aroused the mob is.
	var/min_arousal = AROUSAL_MINIMUM_DEFAULT			//The lowest this mobs arousal will get. default = 0
	var/max_arousal = AROUSAL_MAXIMUM_DEFAULT			//The highest this mobs arousal will get. default = 100
	var/arousal_rate = AROUSAL_START_VALUE				//The base rate that arousal will increase in this mob.
	var/arousal_loss_rate = AROUSAL_START_VALUE			//How easily arousal can be relieved for this mob.
	var/canbearoused = FALSE					//Mob-level disabler for arousal. Starts off and can be enabled as features are added for different mob types.
	var/mb_cd_length = 5 SECONDS						//5 second cooldown for masturbating because fuck spam.
	var/mb_cd_timer = 0									//The timer itself

/mob/living/carbon/human
	canbearoused = TRUE
	var/saved_underwear = ""//saves their underwear so it can be toggled later
	var/saved_undershirt = ""
	var/saved_socks = ""
	var/hidden_underwear = FALSE
	var/hidden_undershirt = FALSE
	var/hidden_socks = FALSE

/mob/living/carbon/human/New()
	..()
	saved_underwear = underwear
	saved_undershirt = undershirt

//Species vars
/datum/species
	var/arousal_gain_rate = AROUSAL_START_VALUE //Rate at which this species becomes aroused
	var/arousal_lose_rate = AROUSAL_START_VALUE //Multiplier for how easily arousal can be relieved
	var/list/cum_fluids = list(/datum/reagent/consumable/semen)
	var/list/milk_fluids = list(/datum/reagent/consumable/milk)
	var/list/femcum_fluids = list(/datum/reagent/consumable/femcum)

//Mob procs
/mob/living/carbon/human/proc/underwear_toggle()
	set name = "Toggle undergarments"
	set category = "Object"
	if(ishuman(src))
		var/mob/living/carbon/human/humz = src
		var/confirm = input(src, "Select what part of your form to alter", "Undergarment Toggling", "Cancel") in list("Top", "Bottom", "Socks", "All", "Cancel")
		if(confirm == "Top")
			humz.hidden_undershirt = !humz.hidden_undershirt

		if(confirm == "Bottom")
			humz.hidden_underwear = !humz.hidden_underwear

		if(confirm == "Socks")
			humz.hidden_socks = !humz.hidden_socks

		if(confirm == "All")
			humz.hidden_undershirt = !humz.hidden_undershirt
			humz.hidden_underwear = !humz.hidden_underwear
			humz.hidden_socks = !humz.hidden_socks

		if(confirm == "Cancel")
			return
		src.update_body()

	else
		to_chat(src, "Humans only. How the fuck did you get this verb anyway.")

/mob/living/proc/handle_arousal()

/mob/living/carbon/handle_arousal()
	if(canbearoused && dna)
		var/datum/species/S
		S = dna.species
		if(S && !(SSmobs.times_fired % 36) && getArousalLoss() < max_arousal)//Totally stolen from breathing code. Do this every 36 ticks.
			adjustArousalLoss(arousal_rate * S.arousal_gain_rate)
			if(dna.features["exhibitionist"] && client)
				var/amt_nude = 0
				if(is_chest_exposed() && (getorganslot("breasts")))
					amt_nude++
				if(is_groin_exposed())
					if(getorganslot("penis"))
						amt_nude++
					if(getorganslot("vagina"))
						amt_nude++
				if(is_butt_exposed())
					if(getorganslot("anus"))
						amt_nude++
				if(amt_nude)
					var/watchers = 0
					for(var/mob/_M in view(world.view, src))
						var/mob/living/M = _M
						if(!istype(M))
							continue
						if(M.client && !M.stat && !M.eye_blind && (locate(src) in viewers(world.view,M)))
							watchers++
					if(watchers)
						adjustArousalLoss((amt_nude * watchers) + S.arousal_gain_rate)


/mob/living/proc/getArousalLoss()
	return arousalloss

/mob/living/proc/adjustArousalLoss(amount, updating_arousal=1)
	if(status_flags & GODMODE || !canbearoused)
		return FALSE
	arousalloss = CLAMP(arousalloss + amount, min_arousal, max_arousal)
	if(updating_arousal)
		updatearousal()

/mob/living/proc/setArousalLoss(amount, updating_arousal=1)
	if(status_flags & GODMODE || !canbearoused)
		return FALSE
	arousalloss = CLAMP(amount, min_arousal, max_arousal)
	if(updating_arousal)
		updatearousal()

/**
	* despite the name of this, it actually returns a number between 0 and 100
  */
/mob/living/proc/getPercentAroused()
	var/percentage = ((arousalloss / max_arousal) * 100)
	return percentage

/mob/living/proc/isPercentAroused(percentage)//returns true if the mob's arousal (measured in a percent of 100) is greater than the arg percentage.
	if(!isnum(percentage) || percentage > 100 || percentage < 0)
		CRASH("Provided percentage is invalid")
	if(getPercentAroused() >= percentage)
		return TRUE
	return FALSE

//H U D//
/mob/living/proc/updatearousal()
	update_arousal_hud()

/mob/living/carbon/updatearousal()
	. = ..()
	for(var/obj/item/organ/genital/genital in internal_organs)
		if(istype(genital))
			var/datum/sprite_accessory/S
			switch(genital.type)
				if(/obj/item/organ/genital/penis)
					S = GLOB.cock_shapes_list[genital.shape]
				if(/obj/item/organ/genital/testicles)
					S = GLOB.balls_shapes_list[genital.shape]
				if(/obj/item/organ/genital/vagina)
					S = GLOB.vagina_shapes_list[genital.shape]
				if(/obj/item/organ/genital/breasts)
					S = GLOB.breasts_shapes_list[genital.shape]
				if(/obj/item/organ/genital/lips)
					S = GLOB.lips_shapes_list[genital.shape]
			if(S?.alt_aroused)
				genital.aroused_state = isPercentAroused(genital.aroused_amount)
			if(getArousalLoss() >= isPercentAroused(33))
				genital.aroused_state = TRUE
			else
				genital.aroused_state = FALSE
			genital.update_appearance()



/mob/living/proc/update_arousal_hud()
	return FALSE

/datum/species/proc/update_arousal_hud(mob/living/carbon/human/H)
	return FALSE

/mob/living/carbon/human/update_arousal_hud()
	if(!client || !hud_used)
		return FALSE
	if(dna.species.update_arousal_hud())
		return FALSE
	if(!canbearoused)
		hud_used.arousal.icon_state = ""
		return FALSE
	else
		if(hud_used.arousal)
			var/arousal_state = "arousal0"
			if(stat != DEAD)
				var/arousal_percent = getPercentAroused()
				var/arousal_rounded = FLOOR(arousal_percent, 10)
				arousal_state = "arousal[arousal_rounded]"
			hud_used.arousal.icon_state = arousal_state
			return TRUE

/obj/screen/arousal
	name = "arousal"
	icon_state = "arousal0"
	icon = 'modular_citadel/icons/obj/genitals/hud.dmi'
	screen_loc = ui_arousal

/obj/screen/arousal/Click()
	if(!isliving(usr))
		return FALSE
	if(isobserver(usr))
		return
	var/mob/living/M = usr
	if(M.canbearoused)
		ui_interact(usr)

/**
	* Checks if this mob can orgasm. Criteria includes:
	* - Mob is human
	* - Mob is capable of arousal
	* - Mob has DNA
	* - Mob is aroused past a certain threshold
	*
	* Arguments:
	* - `arousal` - The minimum arousal needed to pass the check. Default is `100`.
	*
	* Returns: `TRUE`/`FALSE` - Whether or not the mob passes all of the above checks.
	*/
/mob/living/proc/can_orgasm(arousal=100)
	if(src.canbearoused && src.getArousalLoss() >= arousal && ishuman(src) && src.has_dna())
		return TRUE
	return FALSE


/mob/living/proc/mob_climax()
	set name = "Masturbate"
	set category = "IC"
	if(canbearoused && !restrained() && !stat)
		if(mb_cd_timer <= world.time)
			//start the cooldown even if it fails
			mb_cd_timer = world.time + mb_cd_length
			if(isPercentAroused(33))//33% arousal or greater required
				src.visible_message("<span class='danger'>[src] starts masturbating!</span>", \
					"<span class='userdanger'>You start masturbating.</span>")
				if(do_after(src, 30, target = src))
					src.visible_message("<span class='danger'>[src] relieves [p_them()]self!</span>", \
						"<span class='userdanger'>You have relieved yourself.</span>")
					SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "orgasm", /datum/mood_event/orgasm)
					setArousalLoss(min_arousal)
			else
				to_chat(src, "<span class='notice'>You aren't aroused enough for that.</span>")


/**
	*	Arguments:
	* - `genital`: Genitals being used for this interaction.
	* - `cover`: Whether or not the mob is climaxing over themselves.
	* - `mb_time`: Warm-up time for this interaction.
	*/
/mob/living/carbon/human/proc/mob_masturbate(obj/item/organ/genital/genital, cover=FALSE, mb_time=3 SECONDS)
	var/total_fluids = 0
	var/datum/reagents/fluid_source = genital.get_fluid_source()
	var/condomed = FALSE
	var/sounded = FALSE
	if(genital.name == "penis")
		var/obj/item/organ/genital/penis/P = src.getorganslot("penis")
		condomed = P.condom
		sounded = P.sounding
	if(!fluid_source)
		to_chat(src, "<span class='warning'>Your [genital.name] is unable to produce it's own fluids, it's missing the organs for it.</span>")
		return
	total_fluids = fluid_source.total_volume
	if(mb_time)
		src.visible_message("<span class='love'>[src] starts to [genital.masturbation_verb] [p_their()] [genital.name].</span>", \
			"<span class='userlove'>You start to [genital.masturbation_verb] your [genital.name].</span>", \
			"<span class='userlove'>You start to [genital.masturbation_verb] your [genital.name].</span>")
	if(do_after(src, mb_time, target = src))
		if(total_fluids > 5 &&!condomed &&!sounded)
			fluid_source.reaction(src.loc, TOUCH, 1, 0)
			fluid_source.clear_reagents()
		if(!condomed && !sounded)//For when you want to make a mess of yourself.
			if(cover)
				fluid_source.trans_to(src, total_fluids*genital.fluid_transfer_factor)
				total_fluids -= total_fluids*genital.fluid_transfer_factor
				if(total_fluids > 80) // now thats a big cum!
					src.add_cum_overlay("large")
				if(total_fluids > 5)
					fluid_source.reaction(src.loc, TOUCH, 1, 0)
					var/mob/living/carbon/human/H = src
					if(H && genital.name == "penis")
						H.cumdrip_rate += rand(5,10)
				fluid_source.clear_reagents()
				src.visible_message("<span class='love'>[src] climaxes over [p_their()] self, using [p_their()] [genital.name]!</span>", \
					"<span class='userlove'>You orgasm over yourself, using your [genital.name].</span>", \
					"<span class='userlove'>You have climaxed over something, using your [genital.name].</span>")
				src.add_cum_overlay()
			else
				src.visible_message("<span class='love'>[src] orgasms, cumming[istype(src.loc, /turf/open/floor) ? " onto [src.loc]" : ""]!</span>", \
					"<span class='userlove'>You cum[istype(src.loc, /turf/open/floor) ? " onto [src.loc]" : ""].</span>", \
					"<span class='userlove'>You have relieved yourself.</span>")
		if(condomed) //condomed
			src.visible_message("<span class='love'>[src] orgasms, climaxing into [p_their()] condom!</span>", \
				"<span class='userlove'>You cum into your condom.</span>", \
				"<span class='userlove'>You have relieved yourself.</span>")
		if(sounded) //sounded
			src.visible_message("<span class='love'>[src] orgasms, but the rod blocks anything from leaking out!</span>", \
				"<span class='userlove'>You cum with the rod inside.</span>", \
				"<span class='userlove'>You don't quite feel totally relieved.</span>")
		if(total_fluids > 0 && condomed && !sounded)
			src.condomclimax()
		SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "orgasm", /datum/mood_event/orgasm)
		if(genital.can_climax)
			setArousalLoss(min_arousal)


/**
	* Mob climaxes using provided genitals without a partner. This is in contrast with `mob_climax_instant()`,
	* which does not have a warm-up time and uses all genitals at once to climax.
	*
	* Arguments:
	* - `genital`: The selected genitals for this interaction. Determines fluid type.
	* - `mb_time`: The warm-up time for this interaction.
	* - `spillage`: Whether or not climaxing causes this mob to spill fluids on the floor.
	*/
/mob/living/carbon/human/proc/mob_climax_outside(obj/item/organ/genital/genital, spillage=TRUE, mb_time=3 SECONDS)
	var/total_fluids = 0
	var/datum/reagents/fluid_source = genital.get_fluid_source()
	var/unable_to_come = FALSE
	if(fluid_source)
		total_fluids = fluid_source.total_volume
	else
		unable_to_come = TRUE
	if(unable_to_come)
		src.visible_message("<span class='danger'>[src] shudders, their [genital.name] unable to cum.</span>", \
			"<span class='userdanger'>Your [genital.name] cannot cum, giving no relief.</span>", \
			"<span class='userdanger'>Your [genital.name] cannot cum, giving no relief.</span>")
		return
	total_fluids = fluid_source.total_volume
	if(mb_time) //as long as it's not instant, give a warning
		src.visible_message("<span class='love'>[src] looks like they're about to cum.</span>", \
			"<span class='userlove'>You feel yourself about to orgasm.</span>", \
			"<span class='userlove'>You feel yourself about to orgasm.</span>")
	if(do_after(src, mb_time, target = src))
		if(spillage)
			if(total_fluids > 5)
				fluid_source.reaction(src.loc, TOUCH, 1, 0)
			fluid_source.clear_reagents()
			src.visible_message("<span class='love'>[src] orgasms[istype(src.loc, /turf/open/floor) ? ", spilling onto [src.loc]" : ""], with [p_their()] [genital.name]!</span>", \
				"<span class='userlove'>You climax[istype(src.loc, /turf/open/floor) ? ", spilling onto [src.loc]" : ""] with your [genital.name].</span>", \
				"<span class='userlove'>You climax using your [genital.name].</span>")
		else
			src.visible_message("<span class='love'>[src] orgasms with [p_their()] [genital.name]!</span>", \
				"<span class='userlove'>You climax with your [genital.name].</span>", \
				"<span class='userlove'>You climax using your [genital.name].</span>")
		SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "orgasm", /datum/mood_event/orgasm)
		if(genital.can_climax)
			setArousalLoss(min_arousal)


/**
	* Climax over a partner with a selected organ. This is external and creates spills on the partner/floor,
	* and does not have a chance to impregnate. For this interaction, the partner may be an object instead of
	* a person (but it cannot be an animal).
	*
	* Arguments:
	* - `genital`: The genital being used for this interaction. Determines fluid type and volume.
	* - `partner`: The thing being used as a partner. Generally an object or a person.
	* - `mb_time`: The warm-up time for this interaction. Default is 3 seconds
	*/
/mob/living/carbon/human/proc/mob_climax_cover(obj/item/organ/genital/genital, atom/partner, mb_time=3 SECONDS)
	if(isnoncarbon(partner)) // deny animals
		return FALSE
	if(istype(genital, /obj/item/organ/genital/penis))
		var/obj/item/organ/genital/penis/P = genital
		if(P.condom)
			to_chat(src, "<span class='warning'>You cannot do this action with a condom on.</span>")
			return
		if(P.sounding)
			to_chat(src, "<span class='warning'>You cannot do this action with a sounding in.</span>")
			return
	var/total_fluids = 0
	var/datum/reagents/fluid_source = genital.get_fluid_source()
	if(!fluid_source)
		to_chat(src, "<span class='warning'>Your [genital.name] is unable to produce it's own fluids, it's missing the organs for it.</span>")
		return
	total_fluids = fluid_source.total_volume
	if(mb_time)
		src.visible_message("<span class='love'>[src] is about to climax with [partner]!</span>", \
			"<span class='userlove'>You're about to climax with [partner]!</span>", \
			"<span class='userlove'>You're preparing to climax with something!</span>")
	if(!do_after(src, mb_time, target = src))
		return
	if(!in_range(src, partner))
		return
	var/transferred_units = total_fluids * genital.fluid_transfer_factor
	fluid_source.trans_to(partner, transferred_units)
	total_fluids -= transferred_units
	if(total_fluids > 5)
		fluid_source.reaction(partner.loc, TOUCH, 1, 0)
	fluid_source.clear_reagents()
	if(ismob(partner))
		var/mob/living/carbon/partner_carbon = partner
		if(partner_carbon)
			var/cum_overlay = "normal"
			if(total_fluids > 80)
				cum_overlay = "large"
			partner_carbon.add_cum_overlay(cum_overlay)
			var/mob/living/carbon/human/partner_human = partner_carbon
			if(partner_human)
				partner_human.cumdrip_rate += rand(5,10)
	else
		partner.add_cum_overlay()
	src.visible_message("<span class='love'>[src] climaxes over [partner], using [p_their()] [genital.name]!</span>", \
		"<span class='userlove'>You orgasm over [partner], using your [genital.name].</span>", \
		"<span class='userlove'>You have climaxed over something, using your [genital.name].</span>")
	SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "orgasm", /datum/mood_event/orgasm)
	setArousalLoss(min_arousal)


/**
	* Climax inside a partner using a selected organ.
	*
	* Arguments:
	* - `genital`: The genital being used for this interaction. Determines type/volume of fluids.
	* - `partner`: The person that this mob is climaxing in.
	* - `spillage`: Whether or not the fluids will spill on the ground.
	* - `remote`: Whether or not this interaction is being triggered long-distance.
	* - `mb_time`: Warm-up time for this interaction.
	*
	* Returns: `TRUE`/`FALSE` - whether or not this interaction succeeded.
	*/
/mob/living/carbon/human/proc/mob_climax_in_partner(obj/item/organ/genital/genital, mob/living/carbon/partner, spillage=TRUE, remote=FALSE, mb_time=3 SECONDS)
	if(isnoncarbon(partner)) // deny animals
		return FALSE
	var/total_fluids = 0
	var/datum/reagents/fluid_source = genital.get_fluid_source()
	if(!fluid_source)
		to_chat(src, "<span class='warning'>Your [genital.name] is unable to produce it's own fluids, it's missing the organs for it.</span>")
		return FALSE
	total_fluids = fluid_source.total_volume
	var/partner_text = partner
	if(remote)
		partner_text = "someone"
	src.visible_message("<span class='love'>[src] is about to climax with [partner_text]!</span>", \
		"<span class='userlove'>You're about to climax with [partner_text]!</span>", \
		"<span class='userlove'>You're preparing to climax with something!</span>")
	if(!do_after(src, mb_time, target = src))
		return FALSE
	if(!remote && !in_range(src, partner))
		return FALSE
	if(spillage)
		fluid_source.trans_to(partner, total_fluids*genital.fluid_transfer_factor)
		total_fluids -= total_fluids*genital.fluid_transfer_factor
		if(total_fluids > 5)
			fluid_source.reaction(partner.loc, TOUCH, 1, 0)
			var/mob/living/carbon/human/H = partner
			if(H)
				H.cumdrip_rate += rand(5,10)
		fluid_source.clear_reagents()
		src.visible_message("<span class='love'>[src] climaxes with [partner], overflowing and spilling, using [p_their()] [genital.name]!</span>",\
			"<span class='userlove'>You orgasm with [partner], spilling out of them, using your [genital.name].</span>",\
			"<span class='userlove'>You have climaxed with someone, spilling out of them, using your [genital.name].</span>")
		SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "orgasm", /datum/mood_event/orgasm)
		SEND_SIGNAL(partner, COMSIG_ADD_MOOD_EVENT, "orgasm", /datum/mood_event/orgasm)
	else //knots, portal fleshlights, and other non-spilling orgasms
		var/can_inflate = TRUE
		if(istype(genital, /obj/item/organ/genital/penis))
			var/obj/item/organ/genital/penis/P = genital
			if(P.condom)//condomed.
				can_inflate = FALSE
				src.condomclimax()
		if(can_inflate)
			fluid_source.trans_to(partner, total_fluids)
			if(!spillage && total_fluids > 80) // hyper - cum inflation, ONLY if not wearing a condom
				partner.expand_belly(1)
		src.visible_message("<span class='love'>[src] climaxes with [partner_text], [p_their()] [genital.name] spilling nothing!</span>", \
			"<span class='userlove'>You ejaculate with [partner_text], your [genital.name] spilling nothing.</span>", \
			"<span class='userlove'>You have climaxed inside someone, your [genital.name] spilling nothing.</span>")
		if(remote)
			to_chat(partner, "<span class='userlove'>You feel someone ejaculate inside you.</span>")
		SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "orgasm", /datum/mood_event/orgasm)
		SEND_SIGNAL(partner, COMSIG_ADD_MOOD_EVENT, "orgasm", /datum/mood_event/orgasm)
	if(genital.can_climax)
		setArousalLoss(min_arousal)
	//Hyper - antag code
	var/mob/living/carbon/partner_carbon = partner
	if(src.mind.special_role == ROLE_LEWD_TRAITOR)
		for(var/datum/objective/obj in src.mind.objectives)
			if (partner_carbon.mind == obj.target)
				partner_carbon.mind.sexed = TRUE //sexed
				to_chat(src, "<span class='userlove'>You feel deep satisfaction with yourself.</span>")
	return TRUE


/**
	* User chooses whether or not their climax will spill outside of their partner.
	*
	* Arguments:
	* - `picked_organ`: The user's genital being used.
	* - `partner`: This mob's partner for the interaction.
	* - `impreg`: Whether or not this interaction has a chance to impregnate.
	*/
/mob/living/carbon/human/proc/mob_climax_inside_spillage(obj/item/organ/genital/picked_organ, mob/living/carbon/partner, impreg=FALSE)
	var/obj/item/organ/genital/penis/_penis = picked_organ
	if(picked_organ.name != "penis" || _penis.sounding || _penis.condom)
		mob_climax_in_partner(picked_organ, partner, spillage=FALSE)
		return
	var/_question = "Would your fluids spill outside?"
	var/_title = "Choose overflowing option"
	var/spillage = input(src, _question, _title, "Yes") as anything in list("Yes", "No")
	if(mob_climax_in_partner(picked_organ, partner, spillage == "Yes") && impreg)
		partner.impregnate(by=src)


/**
	* Attempt to climax into a container it, filling it with whatever fluids are
	* associated to the selected genitals.
	*
	* Arguments:
	* - `genital`: The genital being used for climax.
	* - `container`: The container being targeted.
	* - `mb_time`: The warm-up time for this interaction.
	*/
/mob/living/carbon/human/proc/mob_fill_container(obj/item/organ/genital/genital, obj/item/reagent_containers/container, mb_time=3 SECONDS)
	if(!container) //Something weird happened
		to_chat(src, "<span class='warning'>You need a container to do this!</span>")
		return
	var/total_fluids = 0
	var/datum/reagents/fluid_source = genital.get_fluid_source()
	if(!fluid_source)
		to_chat(src, "<span class='warning'>Your [genital.name] is unable to produce it's own fluids, it's missing the organs for it.</span>")
		return
	total_fluids = fluid_source.total_volume
	if(genital.name == "penis")
		var/obj/item/organ/genital/penis/P = src.getorganslot("penis")
		if(P.condom)
			to_chat(src, "<span class='warning'>You cannot fill containers when there is a condom over your [genital.name].</span>")
			return
		if(P.sounding)
			to_chat(src, "<span class='warning'>You cannot fill containers when there is a rod inside your [genital.name].</span>")
			return
	src.visible_message("<span class='love'>[src] starts to [genital.masturbation_verb] their [genital.name] over [container].</span>", \
		"<span class='userlove'>You start to [genital.masturbation_verb] your [genital.name] over [container].</span>", \
		"<span class='userlove'>You start to [genital.masturbation_verb] your [genital.name] over something.</span>")
	if(do_after(src, mb_time, target = src) && in_range(src, container))
		fluid_source.trans_to(container, total_fluids)
		src.visible_message("<span class='love'>[src] uses [p_their()] [genital.name] to fill [container]!</span>", \
			"<span class='userlove'>You used your [genital.name] and fill [container] with a total of [total_fluids]u's.</span>", \
			"<span class='userlove'>You have relieved some pressure.</span>")
		SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "orgasm", /datum/mood_event/orgasm)
		container.add_cum_overlay() //your aim is bad...
		if(genital.can_climax)
			setArousalLoss(min_arousal)


/**
	* Prompts the user to select one of their target's genitals to interact with.
	* The target must have their genitals visible to be selectable.
	*
	* Returns: `null`|`obj/item/organ/genital`: The selected genital.
	*/
/mob/living/carbon/human/proc/target_genitals(mob/living/carbon/human/T)
	var/obj/item/organ/genital/ret_organ
	var/list/genitals_list = list()
	for(var/obj/item/organ/genital/genital in T.internal_organs)
		if(genital.is_exposed() && !genital.dontlist)
			genitals_list += genital
	if(genitals_list.len)
		ret_organ = input(src, "", "Genitals", null)  as null|obj in genitals_list
		return ret_organ
	return null //error stuff


/**
	* Prompts the user to select genitals. The genitals must be exposed to be selectable.
	*
	* Arguments:
	* - `masturbation`: Whether or not this is being used for masturbation interactions.
	* - `title`: The title of the prompt window.
	*
	* Returns: `null`|`obj/item/organ/genital`: The selected genital.
	*/
/mob/living/carbon/human/proc/pick_climax_genitals(masturbation=FALSE, title="Climax")
	var/obj/item/organ/genital/ret_organ
	var/list/genitals_list = list()
	for(var/obj/item/organ/genital/genital in internal_organs)
		if(genital.can_climax && genital.is_exposed() && !genital.dontlist)
			if(!masturbation || genital.can_masturbate_with)
				genitals_list += genital
	if(genitals_list.len)
		ret_organ = input(src, "with what?", title, null)  as null|obj in genitals_list
		return ret_organ
	return null //error stuff


/**
	* Prompts the user to select a mob that they are either pulling or being pulled by.
	*
	* Arguments:
	* - `needs_exposed`: Whether or not the partner must have exposed genitals.
	* Returns: `null`|`mob/living/carbon`: The selected mob.
	*/
/mob/living/carbon/human/proc/pick_partner(needs_exposed=TRUE)
	var/list/partners = list(src.pulling, src.pulledby)
	for(var/I in partners)
		if(!iscarbon(I))
			partners -= I
			continue
		if(!needs_exposed)
			continue
		var/mob/living/carbon/C = I
		if(!C.exposed_genitals.len && !C.is_groin_exposed() && !C.is_chest_exposed())
			partners -= I
	if(!partners.len)
		return null
	return input(src, "With whom?", "Sexual partner", null) as null|mob in partners


/**
	* Prompts the user to provide a container (or food item) based on what's in their hands.
	*
	* Returns: `null`|`obj/item/reagent_containers` - The selected container.
	*/
/mob/living/carbon/human/proc/pick_climax_container()
	var/obj/item/reagent_containers/SC = null
	var/list/containers_list = list()
	for(var/obj/item/reagent_containers/container in held_items)
		if(container.is_open_container() || istype(container, /obj/item/reagent_containers/food/snacks))
			containers_list += container
	if(containers_list.len)
		SC = input(src, "Into or onto what? (Cancel for nowhere)", null)  as null|obj in containers_list
		if(SC)
			if(in_range(src, SC))
				return SC
	return null


/**
	* The old arousal menu. This shows a BYOND-style input selection menu that
	* emulates the same functionality as the newer one.
	*/
/mob/living/carbon/human/mob_climax()
	if(!canbearoused || !has_dna())
		return
	if(mb_cd_timer > world.time)
		to_chat(src, "<span class='warning'>You need to wait [DisplayTimeText((mb_cd_timer - world.time), TRUE)] before you can do that again!</span>")
		return
	mb_cd_timer = (world.time + mb_cd_length)
	if(stat == DEAD)
		to_chat(src, "<span class='warning'>You can't do that while dead!</span>")
		return
	if(stat == UNCONSCIOUS)
		to_chat(src, "<span class='warning'>You must be conscious to do that!</span>")
		return
	if(getArousalLoss() < 33)
		to_chat(src, "<span class='warning'>You aren't aroused enough for that!</span>")
		return
	var/list/choices = list("Masturbate", "Climax alone", "Climax with partner","Climax over partner", "Fill container", "Remove condom", "Remove sounding rod")
	var/choice = input(src, "Select sexual activity", "Sexual activity:") as null|anything in choices
	switch(choice)
		if("Remove sounding rod")
			if(restrained(TRUE)) //TRUE ignores grabs
				to_chat(src, "<span class='warning'>You can't do that while restrained!</span>")
				return
			var/free_hands = get_num_arms()
			if(!free_hands)
				to_chat(src, "<span class='warning'>You need at least one free arm.</span>")
				return
			var/obj/item/organ/genital/penis/P = src.getorganslot("penis")
			if(!P.sounding)
				to_chat(src, "<span class='warning'>You don't have a rod inside!</span>")
				return
			if(P.sounding)
				to_chat(src, "<span class='warning'>You pull the rod off from the tip of your penis!</span>")
				src.removesounding()
				return
			return

		if("Remove condom")
			if(restrained(TRUE)) //TRUE ignores grabs
				to_chat(src, "<span class='warning'>You can't do that while restrained!</span>")
				return
			var/free_hands = get_num_arms()
			if(!free_hands)
				to_chat(src, "<span class='warning'>You need at least one free arm.</span>")
				return
			var/obj/item/organ/genital/penis/P = src.getorganslot("penis")
			if(!P.condom)
				to_chat(src, "<span class='warning'>You don't have a condom on!</span>")
				return
			if(P.condom)
				to_chat(src, "<span class='warning'>You tug the condom off the end of your penis!</span>")
				src.removecondom()
				return
			return

		if("Masturbate")
			if(restrained(TRUE)) //TRUE ignores grabs
				to_chat(src, "<span class='warning'>You can't do that while restrained!</span>")
				return
			var/free_hands = get_num_arms()
			if(!free_hands)
				to_chat(src, "<span class='warning'>You need at least one free arm.</span>")
				return
			for(var/helditem in held_items)//how many hands are free
				if(isobj(helditem))
					free_hands--
			if(free_hands <= 0)
				to_chat(src, "<span class='warning'>You're holding too many things.</span>")
				return
			//We got hands, let's pick an organ
			var/obj/item/organ/genital/picked_organ
			picked_organ = pick_climax_genitals(masturbation=TRUE, title="Masturbation")
			if(picked_organ)
				mob_masturbate(picked_organ)
				return
			else //They either lack organs that can masturbate, or they didn't pick one.
				to_chat(src, "<span class='warning'>You cannot masturbate without choosing genitals.</span>")
				return

		if("Climax alone")
			if(restrained(TRUE)) //TRUE ignores grabs
				to_chat(src, "<span class='warning'>You can't do that while restrained!</span>")
				return
			var/free_hands = get_num_arms()
			if(!free_hands)
				to_chat(src, "<span class='warning'>You need at least one free arm.</span>")
				return
			for(var/helditem in held_items)//how many hands are free
				if(isobj(helditem))
					free_hands--
			if(free_hands <= 0)
				to_chat(src, "<span class='warning'>You're holding too many things.</span>")
				return
			//We got hands, let's pick an organ
			var/obj/item/organ/genital/picked_organ
			picked_organ = pick_climax_genitals()
			if(picked_organ)
				mob_climax_outside(picked_organ)
				return
			else //They either lack organs that can masturbate, or they didn't pick one.
				to_chat(src, "<span class='warning'>You cannot climax without choosing genitals.</span>")
				return

		if("Climax with partner")
			//We need no hands, we can be restrained and so on, so let's pick an organ
			var/obj/item/organ/genital/picked_organ
			picked_organ = pick_climax_genitals()
			if(!picked_organ)
				to_chat(src, "<span class='warning'>You cannot climax without choosing genitals.</span>")
				return
			var/mob/living/carbon/partner = pick_partner() //Get someone
			if(!partner)
				to_chat(src, "<span class='warning'>You cannot do this alone.</span>")
				return
			var/obj/item/organ/genital/penis/P = picked_organ
			var/impreg = "No"
			if(partner.breedable && picked_organ.name == "penis" && !P.condom && !P.sounding)
				var/impreg_question = "Would this action carry the risk of pregnancy?"
				var/impreg_title = "Choose a option"
				impreg = input(src, impreg_question, impreg_title, "Yes") as anything in list("Yes", "No")
			mob_climax_inside_spillage(picked_organ, partner, impreg == "Yes")

		if("Climax over partner")
			var/obj/item/organ/genital/picked_organ
			picked_organ = pick_climax_genitals()
			if(picked_organ)
				var/mob/living/carbon/partner = pick_partner(needs_exposed=FALSE) //Get your partner, clothed or not.
				if(partner)
					mob_climax_cover(picked_organ, partner)
				else
					to_chat(src, "<span class='warning'>You cannot do this alone.</span>")

		if("Fill container")
			//We'll need hands and no restraints.
			if(restrained(TRUE)) //TRUE ignores grabs
				to_chat(src, "<span class='warning'>You can't do that while restrained!</span>")
				return
			var/free_hands = get_num_arms()
			if(!free_hands)
				to_chat(src, "<span class='warning'>You need at least one free arm.</span>")
				return
			for(var/helditem in held_items)//how many hands are free
				if(isobj(helditem))
					free_hands--
			if(free_hands <= 0)
				to_chat(src, "<span class='warning'>You're holding too many things.</span>")
				return
			//We got hands, let's pick an organ
			var/obj/item/organ/genital/picked_organ
			picked_organ = pick_climax_genitals() //Gotta be climaxable, not just masturbation, to fill with fluids.
			if(picked_organ)
				//Good, got an organ, time to pick a container
				var/obj/item/reagent_containers/fluid_container = pick_climax_container()
				if(fluid_container)
					mob_fill_container(picked_organ, fluid_container)
					return
				else
					to_chat(src, "<span class='warning'>You cannot do this without anything to fill.</span>")
					return
			else //They either lack organs that can climax, or they didn't pick one.
				to_chat(src, "<span class='warning'>You cannot fill anything without choosing genitals.</span>")
				return
		else //Somehow another option was taken, maybe something interrupted the selection or it was cancelled
			return //Just end it in that case.


/**
  * Causes a mob to climax on the spot. There is no warmup time, nor a
  * menu for selecting genitals. Instead, the mob will climax using all
  * climaxable genitals, either onto their location (floor) or on whatever
  * is pulling/being pulled by them.
	*/
/mob/living/carbon/proc/mob_climax_instant(arousal=100)
	if(stat == DEAD) //corpses can't cum
		to_chat(src, "<span class='warning'>You can't do that while dead!</span>")
		return
	if(!can_orgasm(arousal))
		return
	var/mob/living/carbon/human/user_human = src
	for(var/obj/item/organ/O in internal_organs)
		if(!istype(O, /obj/item/organ/genital))
			continue
		var/obj/item/organ/genital/current_genital = O
		if(!current_genital.can_climax)
			continue // no wombs or testicles
		var/mob/living/carbon/partner
		var/check_target
		if(current_genital.is_exposed())
			if(src.pulling)
				if(iscarbon(src.pulling))
					check_target = src.pulling
			else if(src.pulledby)
				if(iscarbon(src.pulledby))
					check_target = src.pulledby
			if(check_target)
				var/mob/living/carbon/C = check_target
				if(C.exposed_genitals.len || C.is_groin_exposed() || C.is_chest_exposed())
					partner = C
			if(partner)
				user_human.mob_climax_in_partner(current_genital, partner, mb_time=0)
				continue
		user_human.mob_climax_outside(current_genital, mb_time=0)
	return


/**
  * Rolls a chance for the mob to get pregnant, assuming they are capable of doing so.
  *
  * Arguments:
  * - `by` - The mob that is impregnating this one.
  */
/mob/living/carbon/proc/impregnate(mob/living/carbon/by)
	var/obj/item/organ/genital/womb/W = getorganslot("womb")
	if(!W || W.pregnant || !breedable)
		return
	if(!prob(impregchance))
		return
	W.pregnant = TRUE
	log_game("DEBUG: [src] has been impregnated by [by]")
	to_chat(src, "<span class='userlove'>You feel your hormones change, and a motherly instinct take over.</span>")
	if(HAS_TRAIT(src, TRAIT_HEAT))
		SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "heat", /datum/mood_event/heat)
		REMOVE_TRAIT(src, TRAIT_HEAT, ROUNDSTART_TRAIT)
	var/obj/item/organ/genital/breasts/B = src.getorganslot("breasts")
	if (B && B.fluid_mult < 0.5)
		B.fluid_mult = 0.5