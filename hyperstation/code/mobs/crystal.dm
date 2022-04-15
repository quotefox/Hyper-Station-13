#define REGENERATION_DELAY 60  // After taking damage, how long it takes for automatic regeneration to begin for megacarps (ty robustin!)

/mob/living/simple_animal/hostile/crystal
	name = "pellucyte"
	desc = "A floating crystal with orbiting smaller crystals."
	icon = 'hyperstation/icons/mob/crystal.dmi'
	icon_state = "crystal"
	icon_living = "crystal"
	icon_dead = "crystal"
	mob_biotypes = MOB_BEAST
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
	faction = list("carp")
	movement_type = FLYING
	pressure_resistance = 500
	gold_core_spawnable = HOSTILE_SPAWN
	var/regen_cooldown = 0 //Used for how long it takes before a healing will take place default in 60 seconds
	var/regen_amount = 1 //How much is healed pre regen cooldown
	del_on_death = TRUE
	pixel_x = -8

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
