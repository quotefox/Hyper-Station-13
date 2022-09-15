/turf/open/indestructible/concrete
	name = "concrete"
	icon = 'hyperstation/icons/turf/floors/layenia.dmi'
	icon_state = "concrete"
	baseturfs = /turf/open/floor/plating/asteroid/layenia
	initial_gas_mix = FROZEN_ATMOS
	planetary_atmos = TRUE

/turf/open/indestructible/concrete/smooth
	icon_state = "concrete2"
	initial_gas_mix = FROZEN_ATMOS
	planetary_atmos = TRUE

/turf/open/indestructible/layenia/crystal
	name = "Lattice Crystal"
	desc = "A glowing azure crystal, with strange properties to make things float."
	icon = 'hyperstation/icons/turf/floors/layeniacrystal.dmi'
	icon_state = "mapping"
	baseturfs = /turf/open/indestructible/layenia/crystal
	slowdown = 1
	light_range = 4
	light_power = 0.5
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	light_color = LIGHT_COLOR_BLUE
	initial_gas_mix = FROZEN_ATMOS
	planetary_atmos = TRUE
	smooth = SMOOTH_TRUE | SMOOTH_BORDER | SMOOTH_MORE
	canSmoothWith = list(/turf/open/indestructible/layenia/crystal)

/turf/open/indestructible/layenia/crystal/garden
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE

/turf/open/floor/plating/asteroid/layenia
	gender = PLURAL //trans rights
	name = "crimson Rock"
	desc = "A cold rock, rusted scarlet in color."
	icon = 'hyperstation/icons/turf/floors/layenia.dmi'
	baseturfs = /turf/open/floor/plating/asteroid/layenia
	icon_state = "layenia"
	icon_plating = "layenia"
	initial_gas_mix = FROZEN_ATMOS
	slowdown = 1
	environment_type = "layenia"
	flags_1 = NONE
	heat_capacity = INFINITY //Makes it so no matter the heat, it will not burn out.
	planetary_atmos = TRUE
	burnt_states = null
	bullet_sizzle = TRUE
	bullet_bounce_sound = null
	digResult = /obj/item/stack/ore/glass/basalt
	floor_variance = 50 //This means 50% chance of variating from the default tile.
	quantity_of_available_tiles = 5
	//light_range = 2
	//light_power = 0.15
	//light_color = LIGHT_COLOR_WHITE

/turf/open/floor/plating/asteroid/layenia/Initialize()
	. = ..()
	//We no longer randomize the icon state here. That is done by the supercall in our parent, asteroid.
	set_layenia_light(src)

/turf/open/floor/plating/asteroid/layenia/garden
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE

/turf/open/floor/plating/asteroid/layenia/sand
	name = "\improper crimson sand"
	desc = "A reddish sand."
	icon = 'hyperstation/icons/turf/floors/layeniasand.dmi'
	icon_state = "mapping"
	baseturfs = /turf/open/floor/plating/asteroid/layenia/sand
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	smooth = SMOOTH_TRUE | SMOOTH_BORDER | SMOOTH_MORE
	canSmoothWith = list(/turf/open/floor/plating/asteroid/layenia/sand)

/proc/set_layenia_light(turf/open/floor/B)
	switch(B.icon_state)
		if("layenia3", "layenia4")
			B.set_light(2, 0.6, LIGHT_COLOR_BLUE) //more light
