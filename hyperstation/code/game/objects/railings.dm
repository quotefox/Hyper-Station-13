//ported from virgo

/obj/structure/railing
	name = "railing"
	desc = "A railing to stop people from falling"

	icon = 'hyperstation/icons/obj/railings.dmi'
	var/icon_modifier = "grey_"
	icon_state = "grey_railing0"
	
	density = FALSE
	layer = 4
	anchored = TRUE
	flags_1 = ON_BORDER_1
	max_integrity = 250
	var/heat_resistance = 800

	resistance_flags = ACID_PROOF
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 100)
	CanAtmosPass = ATMOS_PASS_PROC
	var/real_explosion_block	//ignore this, just use explosion_block
	var/breaksound = "shatter"
	var/hitsound = 'sound/effects/Glasshit.ogg'
	rad_insulation = RAD_VERY_LIGHT_INSULATION
	rad_flags = RAD_PROTECT_CONTENTS
	var/check = 0
	var/static/list/freepass = typecacheof(list(
		/obj/singularity,
		/obj/effect/projectile,
		/obj/effect/portal,
		/obj/effect/abstract,
		/obj/effect/hotspot,
		/obj/effect/landmark,
		/obj/effect/temp_visual,
		/obj/effect/light_emitter/tendril,
		/obj/effect/collapse,
		/obj/effect/particle_effect/ion_trails,
		/obj/effect/dummy/phased_mob,
		/obj/effect/immovablerod
		)) //Gotta make sure certain things can phase through it otherwise the railings also block them.

/obj/structure/railing/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && (mover.pass_flags & PASSGLASS) || is_type_in_typecache(mover, freepass))
		return 1
	if(get_dir(loc, target) == dir)
		return 0
	return 1

/obj/structure/railing/CheckExit(atom/movable/O, turf/target)
	if(istype(O) && (O.pass_flags & PASSGLASS) || is_type_in_typecache(O, freepass))
		return 1
	if(get_dir(O.loc, target) == dir)
		return 0
	return 1

/obj/structure/railing/Initialize()
	. = ..()
	if(src.anchored)
		update_icon(0)

/obj/structure/railing/proc/NeighborsCheck(var/UpdateNeighbors = 1)
	check = 0
	//if (!anchored) return
	var/Rturn = turn(src.dir, -90)
	var/Lturn = turn(src.dir, 90)

	for(var/obj/structure/railing/R in src.loc)
		if ((R.dir == Lturn) && R.anchored)
			check |= 32
			if (UpdateNeighbors)
				R.update_icon(0)
		if ((R.dir == Rturn) && R.anchored)
			check |= 2
			if (UpdateNeighbors)
				R.update_icon(0)

	for (var/obj/structure/railing/R in get_step(src, Lturn))
		if ((R.dir == src.dir) && R.anchored)
			check |= 16
			if (UpdateNeighbors)
				R.update_icon(0)
	for (var/obj/structure/railing/R in get_step(src, Rturn))
		if ((R.dir == src.dir) && R.anchored)
			check |= 1
			if (UpdateNeighbors)
				R.update_icon(0)

	for (var/obj/structure/railing/R in get_step(src, (Lturn + src.dir)))
		if ((R.dir == Rturn) && R.anchored)
			check |= 64
			if (UpdateNeighbors)
				R.update_icon(0)
	for (var/obj/structure/railing/R in get_step(src, (Rturn + src.dir)))
		if ((R.dir == Lturn) && R.anchored)
			check |= 4
			if (UpdateNeighbors)
				R.update_icon(0)

/obj/structure/railing/update_icon(var/UpdateNeighgors = 1)
	NeighborsCheck(UpdateNeighgors)
	overlays.Cut()
	if (!check || !anchored)//|| !anchored
		icon_state = "[icon_modifier]railing0"
	else
		icon_state = "[icon_modifier]railing1"
		if (check & 32)
			overlays += image ('hyperstation/icons/obj/railings.dmi', src, "[icon_modifier]corneroverlay")
		if ((check & 16) || !(check & 32) || (check & 64))
			overlays += image ('hyperstation/icons/obj/railings.dmi', src, "[icon_modifier]frontoverlay_l")
		if (!(check & 2) || (check & 1) || (check & 4))
			overlays += image ('hyperstation/icons/obj/railings.dmi', src, "[icon_modifier]frontoverlay_r")
			if(check & 4)
				switch (src.dir)
					if (NORTH)
						overlays += image ('hyperstation/icons/obj/railings.dmi', src, "[icon_modifier]mcorneroverlay", pixel_x = 32)
					if (SOUTH)
						overlays += image ('hyperstation/icons/obj/railings.dmi', src, "[icon_modifier]mcorneroverlay", pixel_x = -32)
					if (EAST)
						overlays += image ('hyperstation/icons/obj/railings.dmi', src, "[icon_modifier]mcorneroverlay", pixel_y = -32)
					if (WEST)
						overlays += image ('hyperstation/icons/obj/railings.dmi', src, "[icon_modifier]mcorneroverlay", pixel_y = 32)
