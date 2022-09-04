/turf/closed/wall/mineral/titanium/custom //For spicy custom shuttles
	name = "whoops!"
	desc = "Scream at Dahl please!"
	icon = 'hyperstation/icons/turf/walls/customshuttles.dmi'
	icon_state = "amogus"
	explosion_block = 10
	smooth = SMOOTH_FALSE
	canSmoothWith = null

/turf/closed/wall/mineral/titanium/custom/window
	opacity = FALSE

/turf/closed/wall/mineral/titanium/custom/AfterChange(flags, oldType)
	. = ..()
	// Manually add space underlay, in a way similar to turf_z_transparency,
	// but we actually show the old content of the same z-level, as desired for shuttles

	var/turf/underturf_path

	// Grab previous turf icon
	if(!ispath(oldType, /turf/closed/wall/mineral/titanium/custom))
		underturf_path = oldType
	else
		// Else use whatever SSmapping tells us, like transparent open tiles do
		underturf_path = SSmapping.level_trait(z, ZTRAIT_BASETURF) || /turf/open/space

	var/mutable_appearance/underlay_appearance = mutable_appearance(
		initial(underturf_path.icon),
		initial(underturf_path.icon_state),
		layer = TURF_LAYER - 0.02, plane = initial(underturf_path.plane))
	underlay_appearance.appearance_flags = RESET_ALPHA | RESET_COLOR
	underlays += underlay_appearance

/turf/closed/wall/mineral/titanium/custom/ferry
	name = "\improper ferry wall"
	desc = "A low tech hull for Layenia flight."
	icon_state = "ferry"

/turf/closed/wall/mineral/titanium/custom/window/ferry
	name = "\improper ferry wall"
	desc = "A low tech hull for Layenia flight."
	icon_state = "ferry"

/turf/closed/wall/mineral/titanium/custom/arrivals
	name = "\improper shuttle wall"
	desc = "A low tech hull for Layenia and space-flight"
	icon = 'hyperstation/icons/turf/walls/customarrivals.dmi'
	icon_state = "amogus"

/turf/closed/wall/mineral/titanium/custom/window/arrivals
	name = "\improper shuttle wall"
	desc = "A low tech hull for Layenia and space-flight"
	icon = 'hyperstation/icons/turf/walls/customarrivals.dmi'
	icon_state = "amogus"

/turf/closed/wall/mineral/titanium/custom/pod
	name = "\improper pod wall"
	desc = "A low tech hull for Layenia and space-flight"
	icon = 'hyperstation/icons/turf/walls/custompod.dmi'
	icon_state = "amogus"

/turf/closed/wall/mineral/titanium/custom/window/pod
	name = "\improper pod wall"
	desc = "A low tech hull for Layenia and space-flight"
	icon = 'hyperstation/icons/turf/walls/custompod.dmi'
	icon_state = "amogus"

/turf/closed/wall/mineral/titanium/custom/departures
	name = "\improper pod wall"
	desc = "A low tech hull for Layenia and space-flight"
	icon = 'hyperstation/icons/turf/walls/customdepartures.dmi'
	icon_state = "amogus"

/turf/closed/wall/mineral/titanium/custom/window/departures
	name = "\improper pod wall"
	desc = "A low tech hull for Layenia and space-flight"
	icon = 'hyperstation/icons/turf/walls/customdepartures.dmi'
	icon_state = "amogus"
