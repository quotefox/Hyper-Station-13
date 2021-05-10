/mob/living/simple_animal/opossum
	name = "opossum"
	desc = "It's an opossum, a small scavenging marsupial."
	icon = 'icons/mob/pets.dmi'
	icon_state = "possum"
	icon_living = "possum"
	icon_dead = "possum_dead"
	speak = list("Hiss!","HISS!","Hissss?")
	speak_emote = list("hisses")
	emote_hear = list("hisses.")
	emote_see = list("runs in a circle.", "shakes.")
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

//cargo poss
/mob/living/simple_animal/opossum/Trims
	name = "Trims"
	desc = "Trims, the trash eating opossum! Don't mind the screaming from cargo."
	gender = MALE
	gold_core_spawnable = NO_SPAWN
