/datum/round_event_control/aurora_caelus
	name = "Aurora Caelus"
	typepath = /datum/round_event/aurora_caelus
	max_occurrences = 1
	weight = 4
	earliest_start = 5 MINUTES

/datum/round_event_control/aurora_caelus/canSpawnEvent(players, gamemode)
	if(!CONFIG_GET(flag/starlight))
		return FALSE
	return ..()

/datum/round_event/aurora_caelus
	announceWhen = 1
	startWhen = 8	//Delayed with sleep()
	endWhen = 50
	var/list/aurora_colors = list("#ffd980", "#eaff80", "#eaff80", "#ffd980", "#eaff80", "#A2FFC7", "#9400D3", "#FFC0CB")
	var/aurora_progress = 0 //this cycles from 1 to 8, slowly changing colors from gentle green to gentle blue
	var/list/applicable_areas = list()

/datum/round_event/aurora_caelus/announce()
	priority_announce("[station_name()]: A harmless cloud of ions is approaching your station, and will exhaust their energy battering the hull. Kinaris Command has approved a short break for all employees to relax and observe this very rare event. During this time, starlight will be bright but gentle, shifting between quiet green and blue colors. We will also play quiet music for you to enjoy and relax. Any staff who would like to view these lights for themselves may proceed to the area nearest to them with viewing ports to open space. We hope you enjoy the lights.",
	sound = 'sound/misc/notice2.ogg',
	sender_override = "Kinaris Meteorology Division")
	for(var/V in GLOB.player_list)
		var/mob/M = V
		if((M.client.prefs.toggles & SOUND_MIDI) && is_station_level(M.z))
			M.playsound_local(M, pick('sound/ambience/aurora_caelus_new.ogg','sound/ambience/aurora_caelus.ogg'), 40, FALSE, pressure_affected = FALSE) //ogg is "The Fire is Gone" by Heaven Pierce Her, used in the videogame ULTRAKILL. All respects and credits to the equivalent artists who worked on it.
	start_checking()

/datum/round_event/aurora_caelus/proc/start_checking()
	var/list/turfs_to_check = list()
	var/x = 1
	var/y = 1
	while(TRUE)
		turfs_to_check += locate(x,y,2)	//If the station z-level ever gets changed, change this too. I couldn't find if there's an easy way to get it
		x++
		if(x > 255)
			x = 0
			y++
		if(y > 255)
			break
	if(!turfs_to_check)
		CRASH("Aurora Caelus called, but there's no space!")
	var/tlen = turfs_to_check.len
	var/i = 0
	while(i < tlen)
		i++
		var/turf/T = turfs_to_check[i]
		if(!istype(T, /turf/open/space))
			continue
		if(i%2500 == 0)
			sleep(1)	//try to spread the lag around a bit
		var/sure = (!istype(get_step(T, NORTH)?.loc, /area/space)||\
					!istype(get_step(T, NORTHEAST)?.loc, /area/space)||\
					!istype(get_step(T, EAST)?.loc, /area/space)||\
					!istype(get_step(T, SOUTHEAST)?.loc, /area/space)||\
					!istype(get_step(T, SOUTH)?.loc, /area/space)||\
					!istype(get_step(T, SOUTHWEST)?.loc, /area/space)||\
					!istype(get_step(T, WEST)?.loc, /area/space)||\
					!istype(get_step(T, NORTHWEST)?.loc, /area/space))		//Better than using range()
		if(sure)
			applicable_areas += T

/datum/round_event/aurora_caelus/start()
	for(var/turf/S in applicable_areas)
		S.set_light(6, 0.8, l_color = aurora_colors[1])

/datum/round_event/aurora_caelus/tick()
	if(activeFor % 5 == 0)
		aurora_progress++
		if(aurora_progress > LAZYLEN(aurora_colors))
			aurora_progress = 1
		var/aurora_color = aurora_colors[aurora_progress]
		for(var/turf/S in applicable_areas)
			S.set_light(l_color = aurora_color)

/datum/round_event/aurora_caelus/end()
	priority_announce("The aurora caelus event is now ending. Starlight conditions will slowly return to normal. When this has concluded, please return to your workplace and continue work as normal. Have a pleasant shift, [station_name()], and thank you for watching with us.",
		sound = 'sound/misc/notice2.ogg',
		sender_override = "Kinaris Meteorology Division")
	for(var/S in applicable_areas)
		fade_to_black(S)

/datum/round_event/aurora_caelus/proc/fade_to_black(turf/open/space/S)
	set waitfor = FALSE
	var/i = 0.8
	while(i>0)
		S.set_light(l_power=i)
		sleep(10)
		i -= 0.05	//16 seconds
	S.set_light(initial(S.light_range), initial(S.light_power), initial(S.light_color))
