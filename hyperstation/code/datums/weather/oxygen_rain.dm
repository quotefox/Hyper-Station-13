/datum/weather/oxygen_rain
	name = "oxygen rain"
	desc = "The weather of Layenia can be quite unpredictable... Given the low temperature outside the station, oxygen condenses into liquid droplets."

	telegraph_duration = 400
	telegraph_message = "<span class='boldwarning'>Oxygen clouds condense above and around the station...</span>"

	weather_message = "<span class='userdanger'><i>Liquid oxygen pours down around you! It's freezing!</i></span>"
	weather_overlay = "oxygen_rain"
	weather_duration_lower = 600
	weather_duration_upper = 1500

	end_duration = 100
	end_message = "<span class='boldannounce'>The downpour gradually slows to a light shower before fading away...</span>"

	area_type = /area/layenia/cloudlayer
	target_trait = ZTRAIT_STATION

	immunity_type = "storm" // temp

	barometer_predictable = TRUE

	var/datum/looping_sound/active_outside_oxygenrain/sound_ao = new(list(), FALSE, TRUE)
	var/datum/looping_sound/active_inside_oxygenrain/sound_ai = new(list(), FALSE, TRUE)
	var/datum/looping_sound/weak_outside_oxygenrain/sound_wo = new(list(), FALSE, TRUE)
	var/datum/looping_sound/weak_inside_oxygenrain/sound_wi = new(list(), FALSE, TRUE)

/datum/weather/oxygen_rain/telegraph()
	. = ..()
	var/list/inside_areas = list()
	var/list/outside_areas = list()
	var/list/eligible_areas = list()
	for (var/z in impacted_z_levels)
		eligible_areas += SSmapping.areas_in_z["[z]"]
	for(var/i in 1 to eligible_areas.len)
		var/area/place = eligible_areas[i]
		if(place.outdoors)
			outside_areas += place
		else
			inside_areas += place
		CHECK_TICK

	sound_ao.output_atoms = outside_areas
	sound_ai.output_atoms = inside_areas
	sound_wo.output_atoms = outside_areas
	sound_wi.output_atoms = inside_areas

	sound_wo.start()
	sound_wi.start()

/datum/weather/oxygen_rain/start()
	. = ..()
	sound_wo.stop()
	sound_wi.stop()

	sound_ao.start()
	sound_ai.start()

/datum/weather/oxygen_rain/wind_down()
	. = ..()
	sound_ao.stop()
	sound_ai.stop()

	sound_wo.start()
	sound_wi.start()

/datum/weather/oxygen_rain/end()
	. = ..()
	sound_wo.stop()
	sound_wi.stop()

/datum/weather/oxygen_rain/weather_act(mob/living/L)
	//This is liquid oxygen after all. (-90C)
	L.adjust_bodytemperature(-rand(5,10))




/datum/looping_sound/active_outside_oxygenrain
	mid_sounds = list(
		'sound/weather/oxygenrain/outside/active_mid1.ogg'=1,
		'sound/weather/oxygenrain/outside/active_mid1.ogg'=1,
		'sound/weather/oxygenrain/outside/active_mid1.ogg'=1
		)
	mid_length = 80
	start_sound = 'sound/weather/oxygenrain/outside/active_start.ogg'
	start_length = 130
	end_sound = 'sound/weather/oxygenrain/outside/active_end.ogg'
	volume = 60

/datum/looping_sound/active_inside_oxygenrain
	mid_sounds = list(
		'sound/weather/oxygenrain/inside/active_mid1.ogg'=1,
		'sound/weather/oxygenrain/inside/active_mid2.ogg'=1,
		'sound/weather/oxygenrain/inside/active_mid3.ogg'=1
		)
	mid_length = 80
	start_sound = 'sound/weather/oxygenrain/inside/active_start.ogg'
	start_length = 130
	end_sound = 'sound/weather/oxygenrain/inside/active_end.ogg'
	volume = 20

/datum/looping_sound/weak_outside_oxygenrain
	mid_sounds = list(
		'sound/weather/oxygenrain/outside/weak_mid1.ogg'=1,
		'sound/weather/oxygenrain/outside/weak_mid2.ogg'=1,
		'sound/weather/oxygenrain/outside/weak_mid3.ogg'=1
		)
	mid_length = 80
	start_sound = 'sound/weather/oxygenrain/outside/weak_start.ogg'
	start_length = 130
	end_sound = 'sound/weather/oxygenrain/outside/weak_end.ogg'
	volume = 50

/datum/looping_sound/weak_inside_oxygenrain
	mid_sounds = list(
		'sound/weather/oxygenrain/inside/weak_mid1.ogg'=1,
		'sound/weather/oxygenrain/inside/weak_mid2.ogg'=1,
		'sound/weather/oxygenrain/inside/weak_mid3.ogg'=1
		)
	mid_length = 80
	start_sound = 'sound/weather/oxygenrain/inside/weak_start.ogg'
	start_length = 130
	end_sound = 'sound/weather/oxygenrain/inside/weak_end.ogg'
	volume = 30




/datum/round_event_control/oxygen_rain
	name = "Oxygen Rain"
	typepath = /datum/round_event/oxygen_rain
	max_occurrences = 1

/datum/round_event/oxygen_rain

/datum/round_event/oxygen_rain/setup()
	startWhen = 3
	endWhen = startWhen + 1
	announceWhen	= 1

/datum/round_event/oxygen_rain/start()
	SSweather.run_weather(/datum/weather/oxygen_rain)

/datum/round_event/oxygen_rain/announce()
	priority_announce("[station_name()]: Oxygen Rain Placeholder",
	sound = 'sound/misc/notice2.ogg',
	sender_override = "Kinaris Meteorology Division")
	for(var/V in GLOB.player_list)
		var/mob/M = V
		if((M.client.prefs.toggles & SOUND_MIDI) && is_station_level(M.z))
			M.playsound_local(M, pick('sound/ambience/aurora_caelus_new.ogg','sound/ambience/aurora_caelus.ogg'), 40, FALSE, pressure_affected = FALSE) //ogg is "The Fire is Gone" by Heaven Pierce Her, used in the videogame ULTRAKILL. All respects and credits to the equivalent artists who worked on it.
