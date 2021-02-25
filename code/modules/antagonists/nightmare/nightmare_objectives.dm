/datum/objective/break_lights
	var/mode = FALSE	//If true, break all lights in determined area
	var/list/area_targets = list()		//Which areas we have to keep lights broken
	target_amount = LIGHTSTOBREAK_AREA_MIN
	var/lightsbroken = 0

	var/safe_areas = list(
				/area/space,
				/area/maintenance/solars,
				/area/maintenance/central,	//HOP/Conference room APC
				/area/ai_monitored,
				/area/shuttle,
				/area/engine/engine_smes,
				/area/security/prison,	//If you get unlucky, you'll have to break the lights in armory
				/area/security/execution)

/datum/objective/break_lights/proc/apply_rules()
	if(mode)
		var/list/valid_areas = list()
		for(var/obj/machinery/power/apc/C in GLOB.apcs_list)
			if(C.cell && is_station_level(C.z))
				var/is_safearea = 1
				for(var/A in safe_areas)
					if(istype(C.area, A))
						is_safearea = 0
						break
				if(is_safearea)
					valid_areas += C.area
		var/I = rand(LIGHTSTOBREAK_AREA_MIN, LIGHTSTOBREAK_AREA_MAX)
		for(var/N in 1 to I)
			var/area2add = pick(valid_areas)
			if(!locate(area2add) in area_targets)
				area_targets += area2add
	else
		target_amount = rand(LIGHTSTOBREAK_MINIMUM, LIGHTSTOBREAK_MAXIMUM)
		if(prob(LIGHTSTOBREAK_MAX_CHANCE))
			if(target_amount > LIGHTSTOBREAK_THRESHOLD)
				target_amount = LIGHTSTOBREAK_MAXIMUM
		else if(target_amount > LIGHTSTOBREAK_THRESHOLD)
			target_amount = LIGHTSTOBREAK_THRESHOLD
	explanation_text = update_explanation_text()
	return explanation_text

/datum/objective/break_lights/update_explanation_text()
	..()
	if(mode)
		if(!area_targets.len)
			return "Uh oh! Something broke! Report this."
		. += "There must not be any light sources in the "
		if(area_targets.len == 1)
			var/area/A = area_targets[1]
			. += "[A.name]"
		else if(area_targets.len == 2)
			var/area/A = area_targets[1]
			var/area/B = area_targets[2]
			. += "[A.name] and [B.name]"
		else		//Won't get here because of define values, but during development you can get here. leaving this here for future purposes
			var/i = 1
			for(var/area/A in area_targets)
				if(i != area_targets.len)	. += "[A.name], "
				else	. += "and [A.name]"

		. += " before the end."
	else
		. += "Break at least [target_amount] lights with your light eater."

/datum/objective/break_lights/check_completion()
	if(completed)
		return TRUE	//An attempt to stop this from being called twice
	if(!mode)
		if(lightsbroken >= target_amount)
			completed = TRUE
	else
		var/list/valid_turfs = list()
		for(var/area/target in area_targets)
			var/list/cached_area = get_area_turfs(target.type)
			for(var/turf/A in cached_area)
				if(!is_station_level(A.z))
					continue
				valid_turfs += A
		for(var/turf/T in valid_turfs)
			for(var/atom/C in T.contents)
				/*if(!C?.visibility)	//Doesn't compile, add this another time
					continue*/
				if(C.light_range > 0)
					if(C.light_power <= SHADOW_SPECIES_LIGHT_THRESHOLD*2)	//Give some leniency for not destroying that unbreakable requests console
						completed = TRUE
					else
						completed = FALSE
						break
			if(!completed)
				break

	return completed

/datum/objective/break_lights/area
	mode = TRUE


#undef LIGHTSTOBREAK_MINIMUM
#undef LIGHTSTOBREAK_MAXIMUM
#undef LIGHTSTOBREAK_THRESHOLD
#undef LIGHTSTOBREAK_MAX_CHANCE
#undef LIGHTSTOBREAK_AREA_MIN
#undef LIGHTSTOBREAK_AREA_MAX
