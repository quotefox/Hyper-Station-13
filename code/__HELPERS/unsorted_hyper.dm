// This list was originally created to narrow the list of safe areas for mobs to spawn in the station. If an area is considered too dangerous for something to spawn in, kindly add it to this list.
GLOBAL_LIST_INIT(basic_blacklisted_area_list, typecacheof(list(
	/area/space, 
	/area/shuttle,
	/area/mine, 
	/area/holodeck, 
	/area/ruin, 
	/area/hallway, 
	/area/hallway/primary, 
	/area/hallway/secondary, 
	/area/hallway/secondary/entry,
	/area/engine/supermatter, 
	/area/engine/atmospherics_engine, 
	/area/engine/engineering/reactor_core, 
	/area/engine/engineering/reactor_control, 
	/area/ai_monitored/turret_protected,
	/area/layenia/cloudlayer, 
	/area/asteroid/nearstation, 
	/area/science/server, 
	/area/science/explab, 
	/area/science/xenobiology,
	/area/security/processing)))

// Performance intensive check for picking an area with turfs that are considered the safest possible to spawn something in.
//Only use this for creatures, as it considers people around, temperature, area size and more.
/proc/get_safest_spawn_turfs(list/blacklisted_areas, spawncount) 
	var/list/area/stationAreas = list()
	var/list/area/eligible_areas = list()
	var/validFound = FALSE
	var/list/turf/validTurfs = list()
	var/area/pickedArea
	if(!blacklisted_areas.len)
		blacklisted_areas = GLOB.basic_blacklisted_area_list
	for(var/area/A in world) // Get the areas in the Z level
		if(A.z == SSmapping.station_start)
			stationAreas += A
	for(var/area/place in stationAreas) // first we check if it's a valid area
		if(place.outdoors)
			continue
		if(place.areasize < spawncount * 2)
			continue
		if(is_type_in_typecache(place, blacklisted_areas))
			continue
		eligible_areas += place
	for(var/area/place in eligible_areas) // now we check if there are people in that area
		var/numOfPeople
		for(var/mob/living/carbon/H in place)
			numOfPeople++
			break
		if(numOfPeople > 0)
			eligible_areas -= place // removes this area from the list of eligible areas, it has people in it
	while(!validFound || !eligible_areas.len)
		pickedArea = pick_n_take(eligible_areas)
		var/list/turf/t = get_area_turfs(pickedArea, SSmapping.station_start)
		for(var/turf/thisTurf in t) // now we check if it's a closed turf, cold turf or occupied turf and yeet it
			if(isopenturf(thisTurf))
				var/turf/open/tempGet = thisTurf
				if(tempGet.air.temperature <= T0C)
					t -= thisTurf
					continue
			if(isclosedturf(thisTurf))
				t -= thisTurf
			else
				for(var/obj/O in thisTurf)
					if(O.density && !(istype(O, /obj/structure/table)))
						t -= thisTurf
						break
		if(t.len >= spawncount) //Is the number of available turfs equal or bigger than spawncount?
			validFound = TRUE
			validTurfs = t
			return validTurfs
	if(!validFound)
		message_admins("A function attempted to get safe turfs, but we found none.")
		return null
