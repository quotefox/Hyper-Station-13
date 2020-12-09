/datum/round_event_control/aurora_aquilae
	name = "Aurora Aquilae"
	typepath = /datum/round_event/aurora_aquilae
	max_occurrences = 1
	weight = 4
	earliest_start = 900 MINUTES

/datum/round_event_control/aurora_aquilae/canSpawnEvent(players, gamemode)
	if(!CONFIG_GET(flag/starlight))
		return FALSE
	return ..()

/datum/round_event/aurora_aquilae
	announceWhen = 30
	startWhen = 1 
	endWhen = 100
	var/list/aurora_colors = list("#ffc8bc", "#ed927f", "#d5745f", "#bf3a1d", "#c71414", "#FF3131", "#ee0808", "#ff0000")
	var/aurora_progress = 0 //this cycles from 1 to 8, slowly grading towards a bright red
	var/list/area/areasToFlicker = list()

/datum/round_event/aurora_aquilae/start()
	var/list/areasToFlicker = list(/area/hallway/primary,
								/area/security,
								/area/science)
	for(var/area in GLOB.sortedAreas)
		var/area/A = area
		if(initial(A.dynamic_lighting) == DYNAMIC_LIGHTING_IFSTARLIGHT)
			for(var/turf/open/space/S in A)
				S.set_light(S.light_range * 10, S.light_power * 1)
	for(var/V in GLOB.player_list)
		var/mob/M = V
		if(is_station_level(M.z))	
			M.playsound_local(M, 'sound/ambience/aurora_aquilae.ogg', 20, FALSE, pressure_affected = FALSE) //ogg is "In the presence of a King" by Heaven Pierce Her, used in the videogame ULTRAKILL. All respects and credits to the equivalent artists who worked on it.
	message_admins("start aurora aquilae")

/datum/round_event/aurora_aquilae/proc/flicker_lights()
	message_admins("flicker lights aquilae")
	for(var/area/A in world)
		for(var/typecheck in areasToFlicker)
			if(istype(A, typecheck))
				for(var/obj/machinery/light/L in A)
					L.flicker(30)

/datum/round_event/aurora_aquilae/proc/break_lights()
	message_admins("break lights aquilae")
	for(var/obj/O in areasToFlicker)
		if(istype(O, /obj/machinery/power/apc))
			var/obj/machinery/power/apc/temp = O
			temp.overload_lighting()

/datum/round_event/aurora_aquilae/announce()
	priority_announce("[station_name()]: A ·#HARMLESS#· cloud of ·|$% GLORY AND GUTS¬€#· ions is approaching your ·|%$ station, and will exhaust their energy battering the hull. Kinaris Command has approved a short break for all employees to relax and observe this very rare event. During this time, starlight will be bright but %%%BRUTAL·$ª, shifting between %$$%!ªTHE COMPLETE AND UTTER DESTRUCTION OF THE SENSES$ and %%THE ASHES OF THE GREAT AL-SHAIN%. Any staff who would like to view the %%PRESENCE OF A KING%$ for themselves may proceed to the nearest area with viewing ports to open space.",
	sound = 'sound/misc/interference.ogg',
	sender_override = "Kin]·|Aari$s Meteo%&rology DivD··isio#n")
	addtimer(CALLBACK(src, .proc/flicker_lights), 5 SECONDS)
	message_admins("announce aurora aquilae")
	addtimer(CALLBACK(src, .proc/break_lights), 35 SECONDS)

/datum/round_event/aurora_aquilae/tick()
	if(activeFor % 7 == 0)
		aurora_progress++
		var/aurora_color = aurora_colors[aurora_progress]
		for(var/area in GLOB.sortedAreas)
			var/area/A = area
			if(initial(A.dynamic_lighting) == DYNAMIC_LIGHTING_IFSTARLIGHT)
				for(var/turf/open/space/S in A)
					S.set_light(l_color = aurora_color)
	if(activeFor == 75)
		message_admins("battle aquilae")
		for(var/mob/living/carbon/human/H in GLOB.alive_mob_list)
			new /datum/hallucination/delusion(H)
			new /datum/hallucination/battle(H)
			sleep (100)
			for(var/i in 1 to 25)
				new /datum/hallucination/stray_pistol_bullet(H)
				new /datum/hallucination/battle(H)
				sleep(2.5)
	if(activeFor == 60)
		for(var/mob/living/carbon/human/H in GLOB.alive_mob_list)
			new /datum/hallucination/fire(H)

/datum/round_event/aurora_aquilae/end()
	for(var/area in GLOB.sortedAreas)
		var/area/A = area
		if(initial(A.dynamic_lighting) == DYNAMIC_LIGHTING_IFSTARLIGHT)
			for(var/turf/open/space/S in A)
				fade_to_black(S)
	priority_announce("Have a pleasant shift, [station_name()], and thank you for watching us.",
	sound = 'sound/misc/notice2.ogg',
	sender_override = "???")

/datum/round_event/aurora_aquilae/proc/fade_to_black(turf/open/space/S)
	set waitfor = FALSE
	var/new_light = initial(S.light_range)
	while(S.light_range > new_light)
		S.set_light(S.light_range - 0.2)
		sleep(30)
	S.set_light(new_light, initial(S.light_power), initial(S.light_color))
