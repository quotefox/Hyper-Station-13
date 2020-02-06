/mob/living/simple_animal/hostile/werewolf
	name = "Werewolf"
	desc = "A towering creature!"
	icon = 'hyperstation/icons/mobs/werewolf.dmi'
	icon_state = "idle"
	icon_living = "idle"
	icon_dead = "idle"
	gender = NEUTER
	speak_chance = 0
	turns_per_move = 2
	maxHealth = 30
	health = 30
	see_in_dark = 7
	response_help  = "pets"
	response_disarm = "pushes aside"
	response_harm   = "smacks"
	melee_damage_lower = 12
	melee_damage_upper = 20
	attacktext = "slams"
	attack_sound = 'sound/weapons/punch1.ogg'
	faction = list("werewolf")

	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 150
	maxbodytemp = 500