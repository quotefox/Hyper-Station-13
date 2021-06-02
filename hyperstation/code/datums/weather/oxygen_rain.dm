/datum/weather/oxygen_rain
	name = "oxygen rain"
	desc = "The weather of Layenia can be quite unpredictable. Given the natural low temperature of Layenia, the formation of natural croxygenic liquid gases is possible."

	telegraph_duration = 300
	telegraph_message = "<span class='boldwarning'>Oxygen clouds condense above and around the station...</span>"
	telegraph_overlay = "rain_med"

	weather_message = "<span class='userdanger'><i>Liquid oxygen pours down around you! It's freezing!</i></span>"
	weather_overlay = "rain_high"
	weather_duration_lower = 600
	weather_duration_upper = 1200

	end_duration = 300
	end_message = "<span class='boldannounce'>The downpour gradually slows to a light shower before fading away...</span>"
	end_overlay = "rain_low"

	area_type = /area/layenia
	target_trait = ZTRAIT_STATION

	immunity_type = "storm" // temp
	probability = 2 //The chances of this happening are very low after all. We'll rarely see it, but it's worth it.
	barometer_predictable = TRUE

	var/datum/looping_sound/weak_outside_oxygenrain/sound_wo = new(list(), FALSE, TRUE)
	var/datum/looping_sound/weak_inside_oxygenrain/sound_wi = new(list(), FALSE, TRUE)

/datum/weather/oxygen_rain/telegraph()
	. = ..()
	priority_announce("[station_name()]: A large quantity of condensed low temperature oxygen clouds has been detected around and above the station. A liquid oxygen downpour is expected.",
	sound = 'sound/misc/notice2.ogg',
	sender_override = "Kinaris Meteorology Division")
	for(var/V in GLOB.player_list)
		var/mob/M = V
		if((M.client.prefs.toggles & SOUND_MIDI) && is_station_level(M.z))
			M.playsound_local(M, 'hyperstation/sound/ambience/embrace.ogg', 40, FALSE, pressure_affected = FALSE)
			/*
			"Sappheiros - Embrace" is under a Creative Commons license (CC BY 3.0)
			https://www.youtube.com/channel/UCxLKyBhC6igFhLEb0gxvQNg
			Music promoted by BreakingCopyright: https://youtu.be/DzYp5uqixz0
			*/
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

	sound_wo.output_atoms = outside_areas
	sound_wi.output_atoms = inside_areas

	sound_wo.start()
	sound_wi.start()

/datum/weather/oxygen_rain/end()
	. = ..()
	sound_wo.stop()
	sound_wi.stop()

/datum/weather/oxygen_rain/weather_act(mob/living/L)
	//This is liquid oxygen after all. (-180C give or take)
	L.adjust_bodytemperature(-rand(5,10))

/datum/looping_sound/weak_outside_oxygenrain
	mid_sounds = list(
		'sound/weather/oxygenrain/outside/weak_mid1.ogg'=1,
		'sound/weather/oxygenrain/outside/weak_mid2.ogg'=1
		)
	mid_length = 80
	start_sound = 'sound/weather/oxygenrain/outside/weak_start.ogg'
	start_length = 130
	end_sound = 'sound/weather/oxygenrain/outside/weak_end.ogg'
	volume = 50

/datum/looping_sound/weak_inside_oxygenrain
	mid_sounds = list(
		'sound/weather/oxygenrain/inside/weak_mid1.ogg'=1,
		'sound/weather/oxygenrain/inside/weak_mid2.ogg'=1
		)
	mid_length = 80
	start_sound = 'sound/weather/oxygenrain/inside/weak_start.ogg'
	start_length = 130
	end_sound = 'sound/weather/oxygenrain/inside/weak_end.ogg'
	volume = 30
