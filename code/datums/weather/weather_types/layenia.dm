/datum/weather/layenia
	name = "Layenia Weather"
	desc = "A subset of weather affecting Layenia"

	telegraph_message = "<span class='warning'>Thundering clouds pass overhead, swept up by a steady wind.</span>"
	telegraph_duration = 300
	telegraph_overlay = "light_snow"
	telegraph_sound = 'sound/ambience/acidrain_start.ogg'

	weather_message = "<span class='boldwarning'><i>Clouds storm over the station slowly...</i></span>"
	weather_duration_lower = 600
	weather_duration_upper = 8200
	weather_overlay = "snow_storm"
	weather_sound = 'sound/ambience/acidrain_mid.ogg'

	end_message = "<span class='boldannounce'>Sunlight arches over the station once more; the storm has passed.</span>"
	end_duration = 300
	end_overlay = "light_snow"
	end_sound = 'sound/ambience/acidrain_end.ogg'

	area_type = /area/layenia
	target_trait = ZTRAIT_AWAY

	probability = 100

	barometer_predictable = TRUE


///datum/weather/layenia/telegraph()

///datum/weather/layenia/start()

///datum/weather/layenia/wind_down()

///datum/weather/layenia/end()
