// Used by /turf/open/chasm and subtypes to implement the "dropping" mechanic
/datum/component/chasm
	var/turf/target_turf
	var/turf/linked_turf //turf tile this chasm tile is linked to. Used to get type of turf tile to determine if safety tether applies
	var/fall_message = "GAH! Ah... where are you?"
	var/oblivion_message = "You stumble and stare into the abyss before you. It stares back, and you fall into the enveloping dark."

	var/static/list/falling_atoms = list() // Atoms currently falling into chasms
	var/static/list/forbidden_types = typecacheof(list(
		/mob/camera,
		/obj/singularity,
		/obj/docking_port,
		/obj/structure/lattice,
		/obj/structure/stone_tile,
		/obj/item/projectile,
		/obj/effect/projectile,
		/obj/effect/portal,
		/obj/effect/abstract,
		/obj/effect/hotspot,
		/obj/effect/landmark,
		/obj/effect/temp_visual,
		/obj/effect/particle_effect,
		/obj/effect/light_emitter/tendril,
		/obj/effect/collapse,
		/obj/effect/cloud_collapse,
		/obj/effect/particle_effect/ion_trails,
		/obj/effect/dummy/phased_mob,
		/obj/effect/immovablerod,
		/obj/effect/crystalline_reentry,
		/obj/effect/mapping_helpers,
		/obj/effect/baseturf_helper
		))

/datum/component/chasm/Initialize(turf/target, turf/linked)
	RegisterSignal(parent, list(COMSIG_MOVABLE_CROSSED, COMSIG_ATOM_ENTERED), .proc/Entered)
	target_turf = target
	linked_turf = linked
	START_PROCESSING(SSobj, src) // process on create, in case stuff is still there

/datum/component/chasm/proc/Entered(datum/source, atom/movable/AM)
	START_PROCESSING(SSobj, src)
	drop_stuff(AM)

/datum/component/chasm/process()
	if (!drop_stuff())
		STOP_PROCESSING(SSobj, src)

/datum/component/chasm/proc/is_safe()
	//if anything matching this typecache is found in the chasm, we don't drop things
	var/static/list/chasm_safeties_typecache = typecacheof(list(/obj/structure/lattice/catwalk, /obj/structure/lattice, /obj/structure/stone_tile))

	var/atom/parent = src.parent
	var/list/found_safeties = typecache_filter_list(parent.contents, chasm_safeties_typecache)
	for(var/obj/structure/stone_tile/S in found_safeties)
		if(S.fallen)
			LAZYREMOVE(found_safeties, S)
	return LAZYLEN(found_safeties)

/datum/component/chasm/proc/drop_stuff(AM)
	. = 0
	if (is_safe())
		return FALSE

	var/atom/parent = src.parent
	var/to_check = AM ? list(AM) : parent.contents
	for (var/thing in to_check)
		if (droppable(thing))
			. = 1
			INVOKE_ASYNC(src, .proc/drop, thing)

/datum/component/chasm/proc/droppable(atom/movable/AM)
	// avoid an infinite loop, but allow falling a large distance
	if(falling_atoms[AM] && falling_atoms[AM] > 30)
		return FALSE
	if(!isliving(AM) && !isobj(AM))
		return FALSE
	if(is_type_in_typecache(AM, forbidden_types) || AM.throwing || AM.floating)
		return FALSE
	//Flies right over the chasm
	if(ismob(AM))
		var/mob/M = AM
		if(M.buckled)		//middle statement to prevent infinite loops just in case!
			var/mob/buckled_to = M.buckled
			if((!ismob(M.buckled) || (buckled_to.buckled != M)) && !droppable(M.buckled))
				return FALSE
		if(M.is_flying())
			return FALSE
		if(ishuman(AM))
			var/mob/living/carbon/human/H = AM
			if(istype(H.belt, /obj/item/wormhole_jaunter))
				var/obj/item/wormhole_jaunter/J = H.belt
				//To freak out any bystanders
				H.visible_message("<span class='boldwarning'>[H] falls into [parent]!</span>")
				J.chasm_react(H)
				return FALSE
	return TRUE

/datum/component/chasm/proc/drop(atom/movable/AM)

	//Make sure we have an item
	if(!AM)
		return
	falling_atoms[AM] = (falling_atoms[AM] || 0) + 1
	var/turf/T = target_turf

	if(T)
		// send to the turf below
		AM.visible_message("<span class='boldwarning'>[AM] falls into [parent]!</span>", "<span class='userdanger'>[fall_message]</span>")
		T.visible_message("<span class='boldwarning'>[AM] falls from above!</span>")
		AM.forceMove(T)
		if(isliving(AM))
			var/mob/living/L = AM
			L.Knockdown(100)
			L.adjustBruteLoss(30)
		falling_atoms -= AM

	else

		//We don't want to drop the same object more than once, so we make it float for the duration of animations, etc
		AM.floating = TRUE

		// send to oblivion
		AM.visible_message("<span class='boldwarning'>[AM] falls into [parent]!</span>", "<span class='userdanger'>[oblivion_message]</span>")

		if (isliving(AM))
			var/mob/living/L = AM
			//L.notransform = TRUE
			L.Stun(200)
			if(L.client && check_rights_for(L.client, R_FUN))
				playsound(AM, pick('hyperstation/sound/misc/yodadeath.ogg', 'hyperstation/sound/misc/fallingthroughclouds.ogg', 'hyperstation/sound/misc/goofy.ogg', 'hyperstation/sound/misc/wilhelm.ogg'), 100, 0)

			else if(prob(5))
				playsound(AM, pick('hyperstation/sound/misc/yodadeath.ogg', 'hyperstation/sound/misc/fallingthroughclouds.ogg', 'hyperstation/sound/misc/goofy.ogg', 'hyperstation/sound/misc/wilhelm.ogg'), 100, 0)

		var/oldalpha = AM.alpha
		var/oldcolor = AM.color
		var/oldtransform = AM.transform

		//Animate our falling items
		animate(AM, transform = matrix(0,0,0,0,0,0), alpha = 0, color = rgb(0, 0, 0), time = 10)

		for(var/i in 1 to 5)
			//Make sure the item is still there after our sleep
			if(!AM || QDELETED(AM))
				return
			AM.pixel_y--
			sleep(2)

		//Make sure the item is still there after our sleep
		if(!AM || QDELETED(AM))
			return

		//Mob types that could be protected by a tether
		if(iscyborg(AM) || iscarbon(AM))
			var/mob/living/victim = AM

			var/tether_number = GLOB.safety_tethers_list.len

			//If safety tethers are present, get one from the global list to teleport the body to if operational
			if(tether_number > 0)
				if(tether_number == 1)

					// If teleportation fails
					if(!GLOB.safety_tethers_list[1].attempt_teleport(victim, linked_turf, oldalpha, oldcolor, oldtransform))
						finishdrop(AM)
				else

					//Just in case multiple safety tethers are present
					if(!GLOB.safety_tethers_list[rand(1,GLOB.safety_tethers_list.len)].attempt_teleport(victim, linked_turf, oldalpha, oldcolor, oldtransform))
						finishdrop(AM)
				if(isliving(AM))
					var/mob/living/L = AM
					L.notransform = FALSE
			else
				finishdrop(AM, oldalpha, oldcolor, oldtransform)
		else
			finishdrop(AM, oldalpha, oldcolor, oldtransform)


/datum/component/chasm/proc/finishdrop(atom/movable/AM, oldalpha, oldcolor, oldtransform)

	if(iscyborg(AM))
		var/mob/living/silicon/robot/S = AM
		qdel(S.mmi)

	falling_atoms -= AM
	qdel(AM)
	if(AM && !QDELETED(AM))	//It's indestructible
		var/atom/parent = src.parent
		parent.visible_message("<span class='boldwarning'>[parent] spits out [AM]!</span>")
		AM.floating = FALSE //Stop the thing floating for now
		AM.alpha = oldalpha
		AM.color = oldcolor
		AM.transform = oldtransform
		AM.throw_at(get_edge_target_turf(parent,pick(GLOB.alldirs)),rand(1, 10),rand(1, 10))