/turf/closed
	layer = CLOSED_TURF_LAYER
	opacity = 1
	density = TRUE
	blocks_air = 1
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE
	rad_insulation = RAD_MEDIUM_INSULATION

/turf/closed/AfterChange()
	. = ..()
	SSair.high_pressure_delta -= src

/turf/closed/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	return FALSE

/turf/closed/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && (mover.pass_flags & PASSCLOSEDTURF))
		return TRUE
	return ..()

/turf/closed/indestructible
	name = "wall"
	icon = 'icons/turf/walls.dmi'
	explosion_block = 50

/turf/closed/indestructible/TerraformTurf(path, defer_change = FALSE, ignore_air = FALSE)
	return

/turf/closed/indestructible/acid_act(acidpwr, acid_volume, acid_id)
	return 0

/turf/closed/indestructible/Melt()
	to_be_destroyed = FALSE
	return src

/turf/closed/indestructible/singularity_act()
	return

/turf/closed/indestructible/oldshuttle
	name = "strange shuttle wall"
	icon = 'icons/turf/shuttleold.dmi'
	icon_state = "block"

/turf/closed/indestructible/sandstone
	name = "sandstone wall"
	desc = "A wall with sandstone plating. Rough."
	icon = 'icons/turf/walls/sandstone_wall.dmi'
	icon_state = "sandstone"
	baseturfs = /turf/closed/indestructible/sandstone
	smooth = SMOOTH_TRUE

/turf/closed/indestructible/wood
	name = "wooden wall"
	desc = "A wall with wooden plating. Stiff."
	icon = 'icons/turf/walls/wood_wall.dmi'
	icon_state = "wood"
	baseturfs = /turf/closed/indestructible/wood
	smooth = SMOOTH_TRUE

/turf/closed/indestructible/oldshuttle/corner
	icon_state = "corner"

/turf/closed/indestructible/splashscreen
	name = "Space Station 13"
	icon = 'icons/blank_title.png'
	icon_state = ""
	layer = FLY_LAYER
	bullet_bounce_sound = null

/turf/closed/indestructible/splashscreen/New()
	SStitle.splash_turf = src
	if(SStitle.icon)
		icon = SStitle.icon
	..()

/turf/closed/indestructible/splashscreen/vv_edit_var(var_name, var_value)
	. = ..()
	if(.)
		switch(var_name)
			if("icon")
				SStitle.icon = icon

/turf/closed/indestructible/riveted
	icon = 'icons/turf/walls/riveted.dmi'
	icon_state = "riveted"
	smooth = SMOOTH_TRUE
	explosion_block = INFINITY

	canSmoothWith = list(
	/turf/closed/wall,
	/turf/closed/wall/r_wall,
	/obj/structure/falsewall,
	/obj/structure/falsewall/brass,
	/obj/structure/falsewall/reinforced,
	/turf/closed/wall/rust,
	/turf/closed/wall/r_wall/rust,
	/turf/closed/wall/clockwork,
	/turf/closed/indestructible/riveted/,
	/turf/closed/indestructible/riveted/uranium,
	/obj/structure/window/fulltile,
	/obj/structure/window/reinforced/fulltile,
	/obj/structure/window/reinforced/tinted/fulltile,
	/obj/structure/window/plasma/fulltile,
	/obj/structure/window/plasma/reinforced/fulltile,
	/obj/machinery/door,
	/obj/machinery/door/airlock/,
	/obj/machinery/door/airlock/mining,
	/obj/machinery/door/airlock/mining/glass,
	/obj/machinery/door/airlock/medical,
	/obj/machinery/door/airlock/medical/glass,
	/obj/machinery/door/airlock/public,
	/obj/machinery/door/airlock/public/glass,
	/obj/machinery/door/airlock/research,
	/obj/machinery/door/airlock/research/glass,
	/obj/machinery/door/airlock/maintenance,
	/obj/machinery/door/airlock/maintenance/glass,
	/obj/machinery/door/airlock/command/,
	/obj/machinery/door/airlock/command/glass,
	/obj/machinery/door/airlock/engineering,
	/obj/machinery/door/airlock/engineering/glass,
	/obj/machinery/door/airlock/engineering/abandoned,
	/obj/machinery/door/airlock/security,
	/obj/machinery/door/airlock/security/glass,
	/obj/machinery/door/airlock/maintenance/abandoned,
	/obj/machinery/door/poddoor/shutters/preopen,
	/obj/machinery/door/poddoor/shutters,
	/obj/machinery/door/window/eastright,
	/obj/machinery/door/window/eastleft,
	/obj/machinery/door/window/northleft,
	/obj/machinery/door/window/northright,
	/obj/machinery/door/airlock/external,
	/obj/machinery/door/airlock,
	/obj/machinery/door/airlock/hatch,
	/obj/machinery/door/airlock/engineering/glass/critical,
	/obj/machinery/door/airlock/atmos,
	/obj/machinery/door/airlock/highsecurity,
	/obj/machinery/door/airlock/centcom)

/turf/closed/indestructible/riveted/uranium
	icon = 'icons/turf/walls/uranium_wall.dmi'
	icon_state = "uranium"
	canSmoothWith = list(
	/turf/closed/wall,
	/turf/closed/wall/r_wall,
	/obj/structure/falsewall,
	/obj/structure/falsewall/brass,
	/obj/structure/falsewall/reinforced,
	/turf/closed/wall/rust,
	/turf/closed/wall/r_wall/rust,
	/turf/closed/wall/clockwork,
	/turf/closed/indestructible/riveted/,
	/turf/closed/indestructible/riveted/uranium,
	/obj/structure/window/fulltile,
	/obj/structure/window/reinforced/fulltile,
	/obj/structure/window/reinforced/tinted/fulltile,
	/obj/structure/window/plasma/fulltile,
	/obj/structure/window/plasma/reinforced/fulltile,
	/obj/machinery/door,
	/obj/machinery/door/airlock/,
	/obj/machinery/door/airlock/mining,
	/obj/machinery/door/airlock/mining/glass,
	/obj/machinery/door/airlock/medical,
	/obj/machinery/door/airlock/medical/glass,
	/obj/machinery/door/airlock/public,
	/obj/machinery/door/airlock/public/glass,
	/obj/machinery/door/airlock/research,
	/obj/machinery/door/airlock/research/glass,
	/obj/machinery/door/airlock/maintenance,
	/obj/machinery/door/airlock/maintenance/glass,
	/obj/machinery/door/airlock/command/,
	/obj/machinery/door/airlock/command/glass,
	/obj/machinery/door/airlock/engineering,
	/obj/machinery/door/airlock/engineering/glass,
	/obj/machinery/door/airlock/engineering/abandoned,
	/obj/machinery/door/airlock/security,
	/obj/machinery/door/airlock/security/glass,
	/obj/machinery/door/airlock/maintenance/abandoned,
	/obj/machinery/door/poddoor/shutters/preopen,
	/obj/machinery/door/poddoor/shutters,
	/obj/machinery/door/window/eastright,
	/obj/machinery/door/window/eastleft,
	/obj/machinery/door/window/northleft,
	/obj/machinery/door/window/northright,
	/obj/machinery/door/airlock/external,
	/obj/machinery/door/airlock,
	/obj/machinery/door/airlock/hatch,
	/obj/machinery/door/airlock/engineering/glass/critical,
	/obj/machinery/door/airlock/atmos,
	/obj/machinery/door/airlock/highsecurity,
	/obj/machinery/door/airlock/centcom)

/turf/closed/indestructible/abductor
	icon_state = "alien1"

/turf/closed/indestructible/opshuttle
	icon_state = "wall3"

/turf/closed/indestructible/fakeglass
	name = "window"
	icon_state = "fake_window"
	opacity = 0
	smooth = SMOOTH_TRUE
	icon = 'icons/obj/smooth_structures/reinforced_window.dmi'
	canSmoothWith = list(
	/turf/closed/wall,
	/turf/closed/wall/r_wall,
	/obj/structure/falsewall,
	/obj/structure/falsewall/brass,
	/obj/structure/falsewall/reinforced,
	/turf/closed/wall/rust,
	/turf/closed/wall/r_wall/rust,
	/turf/closed/wall/clockwork,
	/turf/closed/indestructible/riveted/,
	/turf/closed/indestructible/riveted/uranium,
	/obj/structure/window/fulltile,
	/obj/structure/window/reinforced/fulltile,
	/obj/structure/window/reinforced/tinted/fulltile,
	/obj/structure/window/plasma/fulltile,
	/obj/structure/window/plasma/reinforced/fulltile,
	/obj/machinery/door,
	/obj/machinery/door/airlock/,
	/obj/machinery/door/airlock/mining,
	/obj/machinery/door/airlock/mining/glass,
	/obj/machinery/door/airlock/medical,
	/obj/machinery/door/airlock/medical/glass,
	/obj/machinery/door/airlock/public,
	/obj/machinery/door/airlock/public/glass,
	/obj/machinery/door/airlock/research,
	/obj/machinery/door/airlock/research/glass,
	/obj/machinery/door/airlock/maintenance,
	/obj/machinery/door/airlock/maintenance/glass,
	/obj/machinery/door/airlock/command/,
	/obj/machinery/door/airlock/command/glass,
	/obj/machinery/door/airlock/engineering,
	/obj/machinery/door/airlock/engineering/glass,
	/obj/machinery/door/airlock/engineering/abandoned,
	/obj/machinery/door/airlock/security,
	/obj/machinery/door/airlock/security/glass,
	/obj/machinery/door/airlock/maintenance/abandoned,
	/obj/machinery/door/poddoor/shutters/preopen,
	/obj/machinery/door/poddoor/shutters,
	/obj/machinery/door/window/eastright,
	/obj/machinery/door/window/eastleft,
	/obj/machinery/door/window/northleft,
	/obj/machinery/door/window/northright,
	/obj/machinery/door/airlock/external,
	/obj/machinery/door/airlock,
	/obj/machinery/door/airlock/hatch,
	/obj/machinery/door/airlock/engineering/glass/critical,
	/obj/machinery/door/airlock/atmos,
	/obj/machinery/door/airlock/highsecurity,
	/obj/machinery/door/airlock/centcom)

/turf/closed/indestructible/fakeglass/Initialize()
	. = ..()
	icon_state = null //set the icon state to null, so our base state isn't visible
	underlays += mutable_appearance('icons/obj/structures.dmi', "grille") //add a grille underlay
	underlays += mutable_appearance('icons/turf/floors.dmi', "plating") //add the plating underlay, below the grille

/turf/closed/indestructible/fakedoor
	name = "CentCom Access"
	icon = 'icons/obj/doors/airlocks/centcom/centcom.dmi'
	icon_state = "fake_door"

/turf/closed/indestructible/rock
	name = "dense rock"
	desc = "An extremely densely-packed rock, most mining tools or explosives would never get through this."
	icon = 'icons/turf/mining.dmi'
	icon_state = "rock"

/turf/closed/indestructible/rock/snow
	name = "mountainside"
	desc = "An extremely densely-packed rock, sheeted over with centuries worth of ice and snow."
	icon = 'icons/turf/walls.dmi'
	icon_state = "snowrock"
	bullet_sizzle = TRUE
	bullet_bounce_sound = null

/turf/closed/indestructible/rock/snow/ice
	name = "iced rock"
	desc = "Extremely densely-packed sheets of ice and rock, forged over the years of the harsh cold."
	icon = 'icons/turf/walls.dmi'
	icon_state = "icerock"

/turf/closed/indestructible/paper
	name = "thick paper wall"
	desc = "A wall layered with impenetrable sheets of paper."
	icon = 'icons/turf/walls.dmi'
	icon_state = "paperwall"

/turf/closed/indestructible/necropolis
	name = "necropolis wall"
	desc = "A seemingly impenetrable wall."
	icon = 'icons/turf/walls.dmi'
	icon_state = "necro"
	explosion_block = 50
	baseturfs = /turf/closed/indestructible/necropolis

/turf/closed/indestructible/necropolis/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	underlay_appearance.icon = 'icons/turf/floors.dmi'
	underlay_appearance.icon_state = "necro1"
	return TRUE

/turf/closed/indestructible/riveted/boss
	name = "necropolis wall"
	desc = "A thick, seemingly indestructible stone wall."
	icon = 'icons/turf/walls/boss_wall.dmi'
	icon_state = "wall"
	canSmoothWith = list(/turf/closed/indestructible/riveted/boss, /turf/closed/indestructible/riveted/boss/see_through)
	explosion_block = 50
	baseturfs = /turf/closed/indestructible/riveted/boss

/turf/closed/indestructible/riveted/boss/see_through
	opacity = FALSE

/turf/closed/indestructible/riveted/boss/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	underlay_appearance.icon = 'icons/turf/floors.dmi'
	underlay_appearance.icon_state = "basalt"
	return TRUE

/turf/closed/indestructible/riveted/hierophant
	name = "wall"
	desc = "A wall made out of a strange metal. The squares on it pulse in a predictable pattern."
	icon = 'icons/turf/walls/hierophant_wall.dmi'
	icon_state = "wall"
