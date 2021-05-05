/mob/living/simple_animal/skunk
	name = "skunk"
	desc = "A skunk! Originally found stinking up Terran planets, now here to stink your station."
	icon = 'icons/mob/pets.dmi'
	icon_state = "skunk"
	icon_living = "skunk"
	icon_dead = "skunk_dead"
	speak = list("Hsss!","Eek!","Grrr?")
	speak_emote = list("screeches", "grumbles")
	emote_hear = list("screeches.", "grumbles.")
	emote_see = list("thumps.", "shakes.")
	speak_chance = 1
	turns_per_move = 3
	blood_volume = 250
	see_in_dark = 5
	maxHealth = 15
	health = 15
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 1)
	response_help = "pets"
	response_disarm = "gently pushes aside"
	response_harm = "stamps on"
	density = FALSE
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	gold_core_spawnable = FRIENDLY_SPAWN
	do_footstep = TRUE

//rnd skook boi supreme
/mob/living/simple_animal/skunk/Bandit
	name = "Bandit"
	desc = "Despite his name, he's not very good at stealing things. He was found on board after an invasion of marsupials were cleared out."
	gender = MALE
	gold_core_spawnable = NO_SPAWN

/mob/living/simple_animal/skunk/Skook
	name = "Skook"
	desc = "A skook!"
