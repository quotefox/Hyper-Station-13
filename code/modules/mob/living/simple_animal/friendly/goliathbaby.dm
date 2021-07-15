/mob/living/simple_animal/babygoliath
	name = "baby Goliath"
	desc = "It's a baby goliath, like the hulking demons but much smaller and cuter."
	icon = 'icons/mob/pets.dmi'
	icon_state = "goliath_baby"
	icon_living = "goliath_baby"
	icon_dead = "goliath_baby_dead"
	speak = list("Grrr!","Grrr.","Grrr?")
	speak_emote = list("hisses", "rumbles")
	emote_hear = list("hisses.", "rumbles.")
	emote_see = list("grows tentacles below.", "shakes.")
	speak_chance = 1
	turns_per_move = 3
	blood_volume = 250
	see_in_dark = 5
	maxHealth = 15
	health = 15
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/goliath = 1)
	response_help = "pets"
	response_disarm = "gently pushes aside"
	response_harm = "stamps on"
	density = FALSE
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	gold_core_spawnable = FRIENDLY_SPAWN
	do_footstep = TRUE

//miner babie
/mob/living/simple_animal/babygoliath/Pebbles
	name = "Pebbles"
	desc = "Hatched from an egg stolen from a goliath nest, Pebbles stands guard for miners. She's probably tame."
	gender = FEMALE
	gold_core_spawnable = NO_SPAWN