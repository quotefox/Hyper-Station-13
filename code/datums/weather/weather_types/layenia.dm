/datum/weather/ash_storm/layenia //because fuck writing my own code
	name = "Layenia Weather"
	desc = "A subset of weather affecting Layenia"
	weather_color = "white"

	telegraph_message = "<span class='warning'>Thundering clouds pass overhead, swept up by a steady wind.</span>"
	telegraph_duration = 300
	telegraph_overlay = "light_snow"

	weather_message = "<span class='boldwarning'><i>Clouds storm over the station slowly...</i></span>"
	weather_duration_lower = 600
	weather_duration_upper = 8200
	weather_overlay = "snow_storm"

	end_message = "<span class='boldannounce'>Sunlight arches over the station once more; the storm has passed.</span>"
	end_duration = 300
	end_overlay = "light_snow"

	area_type = /area/layenia
	target_trait = ZTRAIT_STATION

	probability = 98

	barometer_predictable = TRUE

	aesthetic = TRUE

//datum/weather/layenia/telegraph()

//datum/weather/layenia/start()

//datum/weather/layenia/wind_down()

//datum/weather/layenia/end()

//datum/weather/ash_storm/layenia/weather_act
