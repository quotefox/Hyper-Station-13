//ported from virgo

/obj/structure/railing
	name = "railing"
	desc = "A railing to stop people from falling"

	icon = 'hyperstation/icons/obj/railings.dmi'
	var/icon_modifier = "grey_"
	icon_state = "grey_railing0"
	flags_1 = CONDUCT_1

	density = FALSE
	climbable = TRUE
	rail_climbing = TRUE
	climb_time = 15
	//var/passable = FALSE // Equivalent of density check for other structures like tables, has to be different due to different collision
	layer = 4
	anchored = TRUE
	flags_1 = ON_BORDER_1
	max_integrity = 250
	var/heat_resistance = 800
	var/health = 70
	var/maxhealth = 70
	var/decon_speed = 5
	layer = BELOW_MOB_LAYER

	resistance_flags = ACID_PROOF
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 100)
	CanAtmosPass = ATMOS_PASS_PROC
	var/real_explosion_block	//ignore this, just use explosion_block
	var/breaksound = "shatter"
	var/hitsound = 'sound/effects/Glasshit.ogg'

	var/buildstacktype = /obj/item/stack/rods
	var/buildstackamount = 1

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
		/obj/effect/immovablerod,
		/obj/effect/crystalline_reentry
		)) //Gotta make sure certain things can phase through it otherwise the railings also block them.

/obj/structure/railing/unachored
	anchored = FALSE

/obj/structure/railing/ComponentInitialize()
	. = ..()
	AddComponent(
		/datum/component/simple_rotation,
		ROTATION_ALTCLICK | ROTATION_CLOCKWISE | ROTATION_COUNTERCLOCKWISE | ROTATION_VERBS,
		null,
		CALLBACK(src, .proc/can_be_rotated),
		)

/obj/structure/railing/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && (mover.pass_flags & PASSGLASS) || is_type_in_typecache(mover, freepass))
		return 1

	if(passable)
		return 1

	if(get_dir(loc, target) != dir)
		return 1

	if(mover.throwing && !mover.floating)
		if(prob(75))
			visible_message("<span class='notice'>[mover] sails over the [src].</span>")
			return 1 //Flies right over the railing

		else
			visible_message("<span class='notice'>[mover] bounces off of the [src]'s rods!</span>")
			return 0 //Bounces off railing's bulk

	if(ismob(mover))
		var/mob/M = mover
		if(M.is_flying())
			visible_message("<span class='notice'>[mover] soars over the [src].</span>")
			return 1

	if(mover.floating)
		visible_message("<span class='notice'>[mover] floats over the [src].</span>")
		return 1

	if(get_dir(loc, target) == dir)
		return 0

/obj/structure/railing/CheckExit(atom/movable/O, turf/target)

	if(istype(O) && ((O.pass_flags & PASSGLASS) || is_type_in_typecache(O, freepass)) || CanPass(O, target) == 1)
		return 1

	if(get_dir(O.loc, target) != dir)
		return 1

	if(get_dir(O.loc, target) == dir)
		return 0

/obj/structure/railing/Initialize()
	. = ..()
	if(src.anchored)
		update_icon(1)

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

	//Ensure layering is appropriate to direction.
	switch (src.dir)
		if (NORTH)
			layer = BELOW_MOB_LAYER
		if (SOUTH)
			layer = ABOVE_MOB_LAYER
		if (EAST)
			layer = BELOW_MOB_LAYER
		if (WEST)
			layer = BELOW_MOB_LAYER

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

/obj/structure/railing/examine(mob/user)
	. = ..()
	if(health < maxhealth)
		switch(health / maxhealth)
			if(0.0 to 0.5)
				. += "<span class='warning'>It looks severely damaged!</span>"
			if(0.25 to 0.5)
				. += "<span class='warning'>It looks damaged!</span>"
			if(0.5 to 1.0)
				. += "<span class='notice'>It has a few scrapes and dents.</span>"
	if(anchored)
		. += "<span class='notice'>It's secured in place with <b>screws</b>. The [src]'s rods look like they could be <b>cut</b> through.</span>"
	else
		. += "<span class='notice'>The anchoring screws are <i>unscrewed</i>. The [src]'s rods look like they could be <b>cut</b> through.</span>"

/obj/structure/railing/take_damage(amount)
	health -= amount
	playsound(src, 'sound/effects/grillehit.ogg', 50, 1)
	if(health <= 0)
		visible_message("<span class='warning'>\The [src] breaks down!</span>")
		new /obj/item/stack/rods(get_turf(src))
		qdel(src)

/obj/structure/railing/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	switch(the_rcd.mode)
		if(RCD_DECONSTRUCT)
			return list("mode" = RCD_DECONSTRUCT, "delay" = 10, "cost" = 5)
	return FALSE

/obj/structure/railing/rcd_act(mob/user, var/obj/item/construction/rcd/the_rcd, passed_mode)
	switch(passed_mode)
		if(RCD_DECONSTRUCT)
			to_chat(user, "<span class='notice'>You deconstruct the [src].</span>")
			qdel(src)
			return TRUE
	return FALSE

/obj/structure/railing/attackby(obj/item/W, mob/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	add_fingerprint(user)
	if(istype(W, /obj/item/wirecutters))
		if(!shock(user, 100))
			W.play_tool_sound(src, 100)
			deconstruct()
			NeighborsCheck()
	else if((istype(W, /obj/item/screwdriver)) && (isturf(loc) || anchored))
		if(!shock(user, 90))
			W.play_tool_sound(src, 100)
			if(W.use_tool(src, user, decon_speed))
				setAnchored(!anchored)
				user.visible_message("<span class='notice'>[user] [anchored ? "fastens" : "unfastens"] [src].</span>", \
									 "<span class='notice'>You [anchored ? "fasten [src] to" : "unfasten [src] from"] the floor.</span>")
				update_icon(1)
				return

	else if(istype(W, /obj/item/shard) || !shock(user, 70))
		return ..()

/obj/structure/railing/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/grille/hulk_damage()
	return 60

/obj/structure/railing/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	if(isobj(AM))
		if(prob(50) && anchored && !broken)
			var/obj/O = AM
			if(O.throwforce != 0 && O.damtype != STAMINA)//don't want to let people spam tesla bolts, this way it will break after time
				var/turf/T = get_turf(src)
				var/obj/structure/cable/C = T.get_cable_node()
				if(C)
					playsound(src, 'sound/magic/lightningshock.ogg', 100, 1, extrarange = 5)
					tesla_zap(src, 3, C.newavail() * 0.01, TESLA_MOB_DAMAGE | TESLA_OBJ_DAMAGE | TESLA_MOB_STUN | TESLA_ALLOW_DUPLICATES) //Zap for 1/100 of the amount of power. At a million watts in the grid, it will be as powerful as a tesla revolver shot.
					C.add_delayedload(C.newavail() * 0.0375) // you can gain up to 3.5 via the 4x upgrades power is halved by the pole so thats 2x then 1X then .5X for 3.5x the 3 bounces shock.
	return ..()

/obj/structure/railing/attack_hulk(mob/living/carbon/human/user, does_attack_animation = 0)
	if(user.a_intent == INTENT_HARM)
		if(!shock(user, 70))
			..(user, 1)
		return TRUE

/obj/structure/railing/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	shock(user, 70)


/obj/structure/railing/attack_alien(mob/living/user)
	user.do_attack_animation(src)
	user.changeNext_move(CLICK_CD_MELEE)
	user.visible_message("<span class='warning'>[user] mangles [src].</span>", null, null, COMBAT_MESSAGE_RANGE)
	if(!shock(user, 70))
		take_damage(20, BRUTE, "melee", 1)

/obj/structure/railing/deconstruct(disassembled = TRUE)
	if(!loc) //if already qdel'd somehow, we do nothing
		return
	if(!(flags_1&NODECONSTRUCT_1))
		var/obj/R = new buildstacktype(drop_location(), buildstackamount)
		transfer_fingerprints_to(R)
		qdel(src)
	..()

/obj/structure/railing/Bumped(atom/movable/AM)
	if(!ismob(AM))
		return
	var/mob/M = AM
	shock(M, 70)

/obj/structure/railing/attack_animal(mob/user)
	. = ..()
	if(!shock(user, 70) && !QDELETED(src)) //Last hit still shocks but shouldn't deal damage to the rail.
		take_damage(rand(5,10), BRUTE, "melee", 1)

/obj/structure/railing/hulk_damage()
	return 60

/obj/structure/railing/attack_hulk(mob/living/carbon/human/user, does_attack_animation = 0)
	if(user.a_intent == INTENT_HARM)
		if(!shock(user, 70))
			..(user, 1)
		return TRUE

// shock user with probability prb (if all connections & power are working)
// returns 1 if shocked, 0 otherwise

/obj/structure/railing/proc/shock(mob/user, prb)
	if(!anchored)		// unanchored railings are never connected
		return FALSE
	if(!prob(prb))
		return FALSE
	if(!in_range(src, user))//To prevent TK and mech users from getting shocked
		return FALSE

	var/turf/T = get_turf(src)
	var/obj/structure/cable/C = T.get_cable_node()
	if(C)
		if(electrocute_mob(user, C, src, 1, TRUE))
			var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
			s.set_up(3, 1, src)
			s.start()
			user.visible_message("<span class='warning'>[user] gets shocked by [src]!</span>", null, null, COMBAT_MESSAGE_RANGE)
			return TRUE
		else
			return FALSE
	return FALSE

/obj/structure/railing/proc/can_be_rotated(mob/user,rotation_type)
	if(anchored)
		to_chat(user, "<span class='warning'>[src] cannot be rotated while it is fastened to the floor!</span>")
		return FALSE

	var/target_dir = turn(dir, rotation_type == ROTATION_CLOCKWISE ? -90 : 90)

	if(!valid_window_location(loc, target_dir))
		to_chat(user, "<span class='warning'>[src] cannot be rotated in that direction!</span>")
		return FALSE
	return TRUE

	add_fingerprint(user)

/obj/structure/railing/Initialize(mapload) //mobs will show under the south railing sprite, thanks Cyanosis for helping with the fix
  . = ..()
  if(!mapload)
    return
  if(!(dir & SOUTH))
    return
  layer = ABOVE_MOB_LAYER

/obj/structure/railing/handrail
	name = "handrail"
	desc = "A waist high handrail, perhaps you could climb over it."

	icon = 'hyperstation/icons/obj/railings.dmi'
	icon_modifier = "hand_"
	icon_state = "hand_railing0"
	max_integrity = 100

/obj/structure/railing/handrail/unachored
	anchored = FALSE

