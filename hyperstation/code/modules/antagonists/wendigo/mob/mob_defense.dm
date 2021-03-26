/mob/living/carbon/wendigo/handle_environment(datum/gas_mixture/environment)
	if(!environment)
		return

	var/loc_temp = get_temperature(environment)

	if(stat != DEAD)
		adjust_bodytemperature(natural_bodytemperature_stabilization())

	if(!on_fire) //If you're on fire, you do not heat up or cool down based on surrounding gases
		if(loc_temp < bodytemperature)
			adjust_bodytemperature(max((loc_temp - bodytemperature) / BODYTEMP_COLD_DIVISOR, BODYTEMP_COOLING_MAX))
		else
			adjust_bodytemperature(min((loc_temp - bodytemperature) / BODYTEMP_HEAT_DIVISOR, BODYTEMP_HEATING_MAX))


	if(bodytemperature > BODYTEMP_HEAT_DAMAGE_LIMIT && !HAS_TRAIT(src, TRAIT_RESISTHEAT))
		switch(bodytemperature)
			if(280 to 300)
				throw_alert("temp", /obj/screen/alert/hot, 1)
				apply_damage(HEAT_DAMAGE_LEVEL_1*physiology.heat_mod, BURN)
			if(300 to 350)
				throw_alert("temp", /obj/screen/alert/hot, 2)
				apply_damage(HEAT_DAMAGE_LEVEL_2*physiology.heat_mod, BURN)
			if(350 to INFINITY)
				throw_alert("temp", /obj/screen/alert/hot, 3)
				if(on_fire)
					apply_damage(HEAT_DAMAGE_LEVEL_3*physiology.heat_mod, BURN)
				else
					apply_damage(HEAT_DAMAGE_LEVEL_2*physiology.heat_mod, BURN)

	else if(bodytemperature < BODYTEMP_COLD_DAMAGE_LIMIT && !HAS_TRAIT(src, TRAIT_RESISTCOLD))
		if(!istype(loc, /obj/machinery/atmospherics/components/unary/cryo_cell))
			switch(bodytemperature)
				if(200 to 260)
					throw_alert("temp", /obj/screen/alert/cold, 1)
					apply_damage(COLD_DAMAGE_LEVEL_1*physiology.cold_mod, BURN)
				if(0 to 120)
					throw_alert("temp", /obj/screen/alert/cold, 2)
					apply_damage(COLD_DAMAGE_LEVEL_2*physiology.cold_mod, BURN)
				if(-INFINITY to 0)
					throw_alert("temp", /obj/screen/alert/cold, 3)
					apply_damage(COLD_DAMAGE_LEVEL_3*physiology.cold_mod, BURN)
		else
			clear_alert("temp")

	else
		clear_alert("temp")

	//Account for massive pressure differences

	var/pressure = environment.return_pressure()
	var/adjusted_pressure = calculate_affecting_pressure(pressure) //Returns how much pressure actually affects the mob.
	switch(adjusted_pressure)
		if(HAZARD_HIGH_PRESSURE to INFINITY)
			adjustBruteLoss(min((((adjusted_pressure / HAZARD_HIGH_PRESSURE)-1)*PRESSURE_DAMAGE_COEFFICIENT)*physiology.pressure_mod, MAX_HIGH_PRESSURE_DAMAGE))
			throw_alert("pressure", /obj/screen/alert/highpressure, 2)
		if(WARNING_HIGH_PRESSURE to HAZARD_HIGH_PRESSURE)
			throw_alert("pressure", /obj/screen/alert/highpressure, 1)
		if(WARNING_LOW_PRESSURE to WARNING_HIGH_PRESSURE)
			clear_alert("pressure")
		if(HAZARD_LOW_PRESSURE to WARNING_LOW_PRESSURE)
			throw_alert("pressure", /obj/screen/alert/lowpressure, 1)
		else
			adjustBruteLoss( LOW_PRESSURE_DAMAGE*physiology.pressure_mod )
			throw_alert("pressure", /obj/screen/alert/lowpressure, 2)

	return

/mob/living/carbon/wendigo/handle_breath_temperature(datum/gas_mixture/breath)
	if(abs(BODYTEMP_NORMAL - breath.temperature) > 50)
		switch(breath.temperature)
			if(-INFINITY to 0)
				adjustFireLoss(3)
			if(0 to 120)	//We flourish in a cold environment
				adjustFireLoss(1.5)
			if(298 to 350)	//But hoo boy do we not like the heat
				adjustFireLoss(2)
			if(350 to 800)
				adjustFireLoss(3)
			if(800 to INFINITY)
				adjustFireLoss(8)

/mob/living/carbon/wendigo/handle_fire()
	if(..())
		return
	adjust_bodytemperature(BODYTEMP_HEATING_MAX*physiology.heat_mod)
	return

/mob/living/carbon/wendigo/adjustBruteLoss(amount, updating_health, forced)
	return ..(amount*physiology.brute_mod, updating_health, forced)

/mob/living/carbon/wendigo/adjustFireLoss(amount, updating_health, forced)
	return ..(amount*physiology.burn_mod, updating_health, forced)

/mob/living/carbon/wendigo/adjustToxLoss(amount, updating_health, forced)
	return ..(amount*physiology.tox_mod, updating_health, forced)

/mob/living/carbon/wendigo/adjustOxyLoss(amount, updating_health, forced)
	return ..(amount*physiology.oxy_mod, updating_health, forced)

/mob/living/carbon/wendigo/adjustCloneLoss(amount, updating_health, forced)
	return ..(amount*physiology.clone_mod, updating_health, forced)

/mob/living/carbon/wendigo/adjustStaminaLoss(amount, updating_health, forced)
	return ..(amount*physiology.stamina_mod, updating_health, forced)

/mob/living/carbon/wendigo/do_after_coefficent()
	. = ..()
	. *= physiology.do_after_speed

/mob/living/carbon/wendigo/electrocute_act(shock_damage, obj/source, siemens_coeff = 1, safety = 0, override = 0, tesla_shock = 0, illusion = 0, stun = TRUE)
	return ..(shock_damage, source, physiology.siemens_coeff, safety, override, tesla_shock, illusion, stun)

/mob/living/carbon/wendigo/Stun(amount, updating, ignore_canstun)
	return ..(amount*physiology.stun_mod, updating, ignore_canstun)

/mob/living/carbon/wendigo/Knockdown(amount, updating, ignore_canknockdown, override_hardstun, override_stamdmg)
	return ..(amount*physiology.stun_mod, updating, ignore_canknockdown, override_hardstun, override_stamdmg)

/mob/living/carbon/wendigo/Unconscious(amount, updating, ignore_canunconscious)
	return ..(amount*physiology.stun_mod, updating, ignore_canunconscious)

/mob/living/carbon/wendigo/bleed(amt)
	return ..(amt*physiology.bleed_mod)
