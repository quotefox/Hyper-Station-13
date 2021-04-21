/datum/weather/fog
	name = "Heavy fog"
	desc = "Rising clouds results in low visibiliy and fuck shit piss cum."

	telegraph_message = "<span class='warning'>Rolling clouds begin to loom and engulf the station.</span>"
	telegraph_duration = 300
	telegraph_overlay = "fog1"

	weather_message = "<span class='boldwarning'><i>Clouds sweep up the station and engulf it within a hazy fog.</i></span>"
	weather_duration_lower = 600
	weather_duration_upper = 1200
	weather_overlay = "fog2"

	end_message = "<span class='boldannounce'>Passing clouds slowly fade away.</span>"
	end_duration = 300
	end_overlay = "fog1"

	area_type = /area/layenia
	target_trait = ZTRAIT_STATION

	probability = 100

	barometer_predictable = TRUE

	aesthetic = TRUE
