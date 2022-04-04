/turf/closed/wall/mineral/titanium/custom //For spicy custom shuttles
	name = "whoops!"
	desc = "Scream at Dahl please!"
	icon = 'hyperstation/icons/turf/walls/customshuttles.dmi'
	icon_state = "amogus"
	explosion_block = 10
	smooth = SMOOTH_FALSE

/obj/structure/window/shuttle/custom //For custom shuttle windows and parts that are small
	name = "whoops!"
	desc = "Scream at Dahl please!"
	icon = 'hyperstation/icons/turf/walls/customshuttles.dmi'
	icon_state = "amogus"
	dir = FULLTILE_WINDOW_DIR
	max_integrity = 100
	wtype = "shuttle"
	fulltile = TRUE
	flags_1 = PREVENT_CLICK_UNDER_1
	reinf = TRUE
	heat_resistance = 1600
	armor = list("melee" = 50, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 50, "bio" = 100, "rad" = 100, "fire" = 80, "acid" = 100)
	smooth = SMOOTH_FALSE
	explosion_block = 10
	anchored = TRUE

/turf/closed/wall/mineral/titanium/custom/ferry
	name = "\improper ferry wall"
	desc = "A low tech hull for Layenia flight."
	icon_state = "ferry"

/obj/structure/window/shuttle/custom/ferry
	name = "\improper ferry wall"
	desc = "A low tech hull for Layenia flight."
	icon_state = "ferry"
