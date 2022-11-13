#define REGENERATION_DELAY 60  // After taking damage, how long it takes for automatic regeneration to begin for megacarps (ty robustin!)

//Pellucytes are the basic, weak crystals that only have 1 attack, but can heal themselves
/mob/living/simple_animal/hostile/crystal
	name = "pellucyte"
	desc = "A floating crystal with orbiting smaller crystals."
	icon = 'hyperstation/icons/mob/crystal.dmi'
	icon_state = "crystal"
	icon_living = "crystal"
	icon_dead = "crystal"
	mob_size = 4
	gender = NEUTER
	mob_biotypes = MOB_INORGANIC
	speak_chance = 0
	turns_per_move = 10
	response_help = "touches"
	response_disarm = "gently pushes aside"
	response_harm = "hits"
	emote_taunt = list("sings")
	taunt_chance = 20
	speed = 0
	maxHealth = 40
	health = 40
	spacewalk = TRUE
	harm_intent_damage = 8
	obj_damage = 50
	melee_damage_lower = 15
	melee_damage_upper = 15
	attacktext = "slams"
	attack_sound = 'sound/creatures/crystal_hit.ogg'
	speak_emote = list("sings")
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 3500
	blood_volume = 0 //It's a fucking rock
	faction = list("crystal", "weave")
	movement_type = FLYING
	pressure_resistance = 500
	gold_core_spawnable = NO_SPAWN
	var/regen_cooldown = 0 //Used for how long it takes before a healing will take place default in 60 seconds
	var/regen_amount = 1 //How much is healed pre regen cooldown
	del_on_death = TRUE
	pixel_x = -8

	//So they will only attack conscious people, leaving them in crit
	stat_attack = CONSCIOUS
	stat_exclusive = TRUE

/mob/living/simple_animal/hostile/crystal/Life()
	. = ..()
	if(regen_amount && regen_cooldown < world.time)
		heal_overall_damage(regen_amount)
	if(stat)
		return
	if(prob(15))
		playsound(src, 'sound/creatures/crystal_idle.ogg', 100)

/mob/living/simple_animal/hostile/crystal/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	. = ..()
	if(regen_amount)
		regen_cooldown = world.time + REGENERATION_DELAY


/mob/living/simple_animal/hostile/crystal/AttackingTarget()
	. = ..()
	if(. && ishuman(target))
		var/mob/living/carbon/human/H = target
		H.adjustStaminaLoss(8)

/mob/living/simple_animal/hostile/crystal/Destroy()
	playsound(src, 'sound/creatures/crystal_death.ogg', 100)
	new /obj/effect/decal/cleanable/glass(src.loc)
	return ..()

//Indecytes are slightly stronger, and will use spikes of crystals to attack enemies.
//They are smarter, will search for people in larger radiuses, and seek them out from greater distances.
/mob/living/simple_animal/hostile/crystal/large
	name = "indecyte"
	desc = "A large resonant crystal thrumming with energy."
	icon = 'hyperstation/icons/mob/crystal.dmi'
	icon_state = "indecyte"
	icon_living = "indecyte"
	icon_dead = "indecyte"
	emote_taunt = list("sings", "resonates")
	attacktext = "punctures"
	health = 310
	maxHealth = 310
	obj_damage = 50
	speed = 3
	move_to_delay = 8

	death_sound = 'sound/creatures/crystal_death.ogg'
	deathmessage = "steadily crashes into the ground, fading out of sight..."

	robust_searching = 1
	vision_range = 12 //It can see you before you can see it! (default is 9 for on-screen only)
	aggro_vision_range = 12

	//It prefers to stay at a distance while doing its attacks
	ranged = 1 
	ranged_cooldown = 30
	minimum_distance = 2


/mob/living/simple_animal/hostile/crystal/large/AttackingTarget()
	return OpenFire()

/mob/living/simple_animal/hostile/crystal/large/OpenFire()
	if(ranged_cooldown > world.time)
		return FALSE
	ranged_cooldown = world.time + ranged_cooldown_time
	for(var/i = 1 to 4)
		var/turf/T = get_step(get_turf(src), pick(1,2,4,5,6,8,9,10))
		if(T.density)
			i -= 1
			continue
		var/obj/item/projectile/crystal_slash/P = new(T)
		P.starting = T
		P.firer = src
		P.fired_from = T
		P.yo = target.y - T.y
		P.xo = target.x - T.x
		P.original = target
		P.preparePixelProjectile(target, T)
		addtimer(CALLBACK (P, .obj/item/projectile/proc/fire), 5)
	SLEEP_CHECK_DEATH(3)
	playsound(get_turf(src), 'hyperstation/sound/effects/swoosh.ogg', 50, 0, 4)
	return

/mob/living/simple_animal/hostile/crystal/large/death(gibbed)
	density = FALSE
	animate(src, alpha = 0, time = 5 SECONDS)
	QDEL_IN(src, 5 SECONDS)
	..()
