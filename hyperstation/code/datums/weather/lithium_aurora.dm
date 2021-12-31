/datum/weather/lithium_aurora
	name = "Lithium Aurora"
	desc = "A natural process of Layenia's atmospheric purification, in the lower levels of Layenia lithium and hydrogen combine until they form small specs of lithium peroxide. This peroxide rises to the clouds of Layenia, assisting in removing carbon dioxide from the atmosphere and in the process, creating a beautiful aurora that lasts for a few minutes."

	telegraph_duration = 300
	telegraph_message = "<span class='boldwarning'>Sivery particles float around the station...</span>"
	telegraph_overlay = "lithium"

	weather_message = null
	weather_overlay = "lithium"
	weather_duration_lower = 1800
	weather_duration_upper = 2800

	end_duration = 300
	end_message = "<span class='boldannounce'>The particles slowly fade away...</span>"
	end_overlay = "lithium"

	area_type = /area/layenia
	target_trait = ZTRAIT_STATION

	immunity_type = "storm" // temp
	probability = 2 //The chances of this happening are very low after all. We'll rarely see it, but it's worth it.
	barometer_predictable = FALSE

	var/activeFor = 0
	var/list/aurora_colors = list("#80a8ff", "#a4e6fa", "#c1f0ff", "#e0f6ff", "#c1f0ff", "#a4e6fa")
	var/aurora_progress = 0 //this cycles from 1 to 8, slowly changing colors from gentle green to gentle blue
	var/list/applicable_areas = list()
	var/ended = FALSE

/datum/weather/lithium_aurora/telegraph()
	. = ..()
	ended = FALSE
	priority_announce("[station_name()]: Lithium peroxide particles are rising in the atmosphere, a natural part of Layenia's atmospheric purification cycle. Their chemical reactions will cause slight shifts in the visible light spectrums. Kinaris Command has approved a short break for all employees to relax and observe this very rare event. Any staff who would like to view these lights for themselves may proceed to the nearest windows or go outside. We hope you enjoy the lights.",
	sound = 'sound/misc/notice2.ogg',
	sender_override = "Kinaris Meteorology Division")
	for(var/V in GLOB.player_list)
		var/mob/M = V
		if((M.client.prefs.toggles & SOUND_MIDI) && is_station_level(M.z))
			M.playsound_local(M, 'hyperstation/sound/ambience/urano.ogg', 40, FALSE, pressure_affected = FALSE)
			/*
			"Alex Productions - Urano" is under a Creative Commons license (CC BY 3.0).
			https://www.youtube.com/channel/UCx0_M61F81Nfb-BRXE-SeVA
			Music promoted by BreakingCopyright: https://youtu.be/JsBBvctEblE
			*/
	start_checking()
	for(var/turf/S in applicable_areas)
		S.set_light(6, 0.8, l_color = aurora_colors[1])
	addtimer(CALLBACK(src, .proc/tick), 10) //Processing doesn't work, even when using custom SSprocessing. Welp, we'll settle for timers.

/datum/weather/lithium_aurora/end()
	. = ..()
	ended = TRUE
	priority_announce("The lithium aurora is now ending. Light conditions will slowly return to normal. When this has concluded, please return to your workplace and continue work as normal. Have a pleasant shift, [station_name()], and thank you for watching with us.",
		sound = 'sound/misc/notice2.ogg',
		sender_override = "Kinaris Meteorology Division")
	for(var/S in applicable_areas)
		fade_to_black(S)

/datum/weather/lithium_aurora/weather_act(mob/living/L)
	//L.adjust_bodytemperature(-rand(5,10)) //Nothing bad!

/datum/weather/lithium_aurora/proc/start_checking()
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
		CRASH("Lithium aurora called, but there's no clouds!")
	var/tlen = turfs_to_check.len
	var/i = 0
	while(i < tlen)
		i++
		var/turf/T = turfs_to_check[i]
		if(!istype(T, /turf/open/chasm/cloud))
			continue
		if(i%2500 == 0)
			sleep(1)	//try to spread the lag around a bit
		var/sure = (!istype(get_step(T, NORTH)?.loc, /area/layenia)||\
					!istype(get_step(T, NORTHEAST)?.loc, /area/layenia)||\
					!istype(get_step(T, EAST)?.loc, /area/layenia)||\
					!istype(get_step(T, SOUTHEAST)?.loc, /area/layenia)||\
					!istype(get_step(T, SOUTH)?.loc, /area/layenia)||\
					!istype(get_step(T, SOUTHWEST)?.loc, /area/layenia)||\
					!istype(get_step(T, WEST)?.loc, /area/layenia)||\
					!istype(get_step(T, NORTHWEST)?.loc, /area/layenia))		//Better than using range()
		if(sure)
			applicable_areas += T

/datum/weather/lithium_aurora/proc/fade_to_black(turf/open/chasm/cloud/S)
	set waitfor = FALSE
	var/i = 0.8
	while(i>0)
		S.set_light(l_power=i)
		sleep(10)
		i -= 0.05	//16 seconds
	S.set_light(initial(S.light_range), initial(S.light_power), initial(S.light_color))

/datum/weather/lithium_aurora/proc/tick()
	activeFor++
	if(!ended)
		if(activeFor % 5 == 0)
			aurora_progress++
			if(aurora_progress > LAZYLEN(aurora_colors))
				aurora_progress = 1
			var/aurora_color = aurora_colors[aurora_progress]
			for(var/turf/S in applicable_areas)
				S.set_light(l_color = aurora_color)
		addtimer(CALLBACK(src, .proc/tick), 10)
