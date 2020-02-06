/mob/living/simple_animal/hostile/mimic
	name = "Mimic"
	icon = 'modular_hyperstation/icons/mobs/mimic.dmi'
	icon_state = "mimic"
	icon_living = "mimic"
	icon_dead = "mimic_dead"
	gender = NEUTER
	speak_chance = 0
	turns_per_move = 5
	maxHealth = 30
	health = 30
	see_in_dark = 3
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/killertomato = 2)
	response_help  = "prods"
	response_disarm = "pushes aside"
	response_harm   = "smacks"
	melee_damage_lower = 8
	melee_damage_upper = 12
	attacktext = "slams"
	attack_sound = 'sound/weapons/punch1.ogg'
	ventcrawler = VENTCRAWLER_ALWAYS
	faction = list("plants")

	var/unstealth = FALSE


/mob/living/simple_animal/hostile/mimic/Initialize()
// When initialized, make sure they take the form of something.
	unstealth = FALSE
	Mimictransform()

/mob/living/simple_animal/hostile/mimic/proc/Mimictransform()
	if(unstealth == FALSE) //why are there switches for the SAME thing?
		icon = 'icons/obj/drinks.dmi'
		icon_state = "glass_empty"
		aggro_vision_range = 0

	else //back to normal
		icon = 'modular_hyperstation/icons/mobs/mimic.dmi'
		icon_state = "mimic"
