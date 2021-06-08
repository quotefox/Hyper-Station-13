/datum/round_event_control/crystalline_reentry
	name = "Crystalline Asteroid"
	typepath = /datum/round_event/crystalline_reentry
	min_players = 15
	max_occurrences = 5
	var/atom/special_target


/datum/round_event_control/crystalline_reentry/admin_setup()
	if(!check_rights(R_FUN))
		return

	var/aimed = alert("Aimed at current location?","Snipe", "Yes", "No")
	if(aimed == "Yes")
		special_target = get_turf(usr)

/datum/round_event/crystalline_reentry
	announceWhen = 5

/datum/round_event/crystalline_reentry/announce(fake)
	priority_announce("A crystalline asteroid has suffered a violent atmospheric entry. Brace for possible impact.", "General Alert")

/datum/round_event/crystalline_reentry/start()
	var/datum/round_event_control/crystalline_reentry/C = control
	var/startside = pick(GLOB.cardinals)
	var/z = pick(SSmapping.levels_by_trait(ZTRAIT_STATION))
	var/turf/startT = spaceDebrisStartLoc(startside, z)
	var/turf/endT = spaceDebrisFinishLoc(startside, z)
	new /obj/effect/crystalline_reentry(startT, endT, C.special_target)

/obj/effect/crystalline_reentry
	name = "dense ice asteroid"
	desc = "Oh shit."
	icon = 'icons/obj/meteor.dmi'
	icon_state = "ice"
	throwforce = 100
	move_force = INFINITY
	move_resist = INFINITY
	pull_force = INFINITY
	density = TRUE
	anchored = TRUE
	flags_1 = PREVENT_CONTENTS_EXPLOSION_1
	var/asteroidhealth = 150
	var/z_original = 0
	var/destination
	var/notify = TRUE
	var/atom/special_target
	var/dropamt = 3
	var/droptype = list(/obj/item/stack/ore/bluespace_crystal)

/obj/effect/crystalline_reentry/New(atom/start, atom/end, aimed_at)
	..()
	SSaugury.register_doom(src, 2000)
	z_original = z
	destination = end
	special_target = aimed_at
	asteroidhealth = rand(120,240)
	if(notify)
		notify_ghosts("\A [src] is inbound!",
			enter_link="<a href=?src=[REF(src)];orbit=1>(Click to orbit)</a>",
			source=src, action=NOTIFY_ORBIT)
	GLOB.poi_list += src

	var/special_target_valid = FALSE
	if(special_target)
		var/turf/T = get_turf(special_target)
		if(T.z == z_original)
			special_target_valid = TRUE
	if(special_target_valid)
		walk_towards(src, special_target, 1)
	else if(end && end.z==z_original)
		walk_towards(src, destination, 1)

/obj/effect/crystalline_reentry/Topic(href, href_list)
	if(href_list["orbit"])
		var/mob/dead/observer/ghost = usr
		if(istype(ghost))
			ghost.ManualFollow(src)

/obj/effect/crystalline_reentry/Destroy()
	GLOB.poi_list -= src
	. = ..()

/obj/effect/crystalline_reentry/Moved()
	if((z != z_original) || (loc == destination))
		qdel(src)
	if(special_target && loc == get_turf(special_target))
		complete_trajectory()
	return ..()

/obj/effect/crystalline_reentry/proc/complete_trajectory()
	//We hit what we wanted to hit, time to go
	special_target = null
	destination = get_edge_target_turf(src, dir)
	walk(src,0)
	walk_towards(src, destination, 1)

/obj/effect/crystalline_reentry/ex_act(severity, target)
	return 0

/obj/effect/crystalline_reentry/singularity_act()
	return

/obj/effect/crystalline_reentry/singularity_pull()
	return

/obj/effect/crystalline_reentry/Bump(atom/clong)
	asteroidhealth = asteroidhealth - rand(7,14)
	if(prob(10))
		playsound(src, 'sound/effects/bang.ogg', 50, 1)
		audible_message("<span class='danger'>You hear a BONK!</span>")

	if(clong && prob(25))
		x = clong.x
		y = clong.y

	if(special_target && clong == special_target)
		complete_trajectory()

	if(isturf(clong) || isobj(clong))
		if(clong.density)
			clong.ex_act(EXPLODE_HEAVY)

	else if(isliving(clong))
		penetrate(clong)
	else if(istype(clong, type))
		var/obj/effect/crystalline_reentry/other = clong
		visible_message("<span class='danger'>[src] collides with [other]!\
			</span>")
		var/datum/effect_system/smoke_spread/smoke = new
		smoke.set_up(2, get_turf(src))
		smoke.start()
		qdel(src)
		qdel(other)
	if(asteroidhealth <= 0)
		atmos_spawn_air("water_vapor=1000;TEMP=0") //brr
		make_debris()
		explosion(src.loc, 1, 2, 3, 3, 1, 0, 0, 0, 0)
		qdel(src)
	else
		atmos_spawn_air("water_vapor=100;TEMP=0") //brr

/obj/effect/crystalline_reentry/proc/penetrate(mob/living/L)
	L.visible_message("<span class='danger'>[L] is smashed by an crystalline asteroid!</span>" , "<span class='userdanger'>The crystalline asteroid smashes you!</span>" , "<span class ='danger'>You hear a BONK!</span>")
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.adjustBruteLoss(160)

/obj/effect/crystalline_reentry/proc/make_debris()
	for(var/throws = dropamt, throws > 0, throws--)
		var/thing_to_spawn = pick(droptype)
		new thing_to_spawn(get_turf(src))
