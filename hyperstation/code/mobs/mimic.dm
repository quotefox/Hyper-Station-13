/mob/living/simple_animal/hostile/mimic
	name = "Mimic"
	desc = "A creature with the ability to take the form of other objects."
	icon = 'hyperstation/icons/mobs/mimic.dmi'
	icon_state = "mimic"
	icon_living = "mimic"
	icon_dead = "mimic_dead"
	gender = NEUTER
	speak_chance = 0
	turns_per_move = 5
	maxHealth = 30
	health = 30
	see_in_dark = 7
	response_help = "pokes"
	response_disarm = "shoves"
	response_harm = "hits"
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/killertomato = 2)
	response_help  = "prods"
	response_disarm = "pushes aside"
	response_harm   = "smacks"
	melee_damage_lower = 8
	melee_damage_upper = 12
	move_to_delay = 9
	attacktext = "slams"
	attack_sound = 'sound/weapons/punch1.ogg'
	ventcrawler = VENTCRAWLER_ALWAYS
	faction = list("mimic")
	var/unstealth = FALSE

	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 150
	maxbodytemp = 500
	gold_core_spawnable = HOSTILE_SPAWN


/mob/living/simple_animal/hostile/mimic/Initialize()
// When initialized, make sure they take the form of something.
	unstealth = FALSE



/mob/living/simple_animal/hostile/mimic/proc/activate()
	if(!unstealth)
		visible_message("<b>[src]</b> starts to move!")
		unstealth = TRUE


/mob/living/simple_animal/hostile/mimic/LoseTarget()
	..()
	icon_state = initial(icon_state) //when lost target, return into stealth form.
	unstealth = FALSE

/mob/living/simple_animal/hostile/mimic/crate/ListTargets()
	if(unstealth)
		return ..()
	return ..(1)

	//If stealthed, do not target


/mob/living/simple_animal/hostile/mimic/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	activate()
	//if taking damage, trigger.