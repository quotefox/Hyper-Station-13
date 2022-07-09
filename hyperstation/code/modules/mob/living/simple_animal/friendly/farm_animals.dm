/mob/living/simple_animal/
	var/happiness = 50 //how happy they are.



              /////////////
//////////////// CHICKEN /////////////////
              /////////////

/mob/living/simple_animal/chick
	icon = 'hyperstation/icons/mob/chickens.dmi'
	name = "\improper chick"
	desc = "Adorable! They make such a racket though."
	icon_state = "chick"
	icon_living = "chick"
	icon_dead = "chick_dead"
	icon_gib = "chick_gib"
	gender = FEMALE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak = list("Cherp.","Cherp?","Chirrup.","Cheep!")
	speak_emote = list("cheeps")
	emote_hear = list("cheeps.")
	emote_see = list("pecks at the ground.","flaps its tiny wings.")
	density = FALSE
	speak_chance = 2
	turns_per_move = 2
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/chicken = 1)
	response_help  = "pets"
	response_disarm = "gently pushes aside"
	response_harm   = "kicks"
	attacktext = "kicks"
	health = 3
	maxHealth = 3
	ventcrawler = VENTCRAWLER_ALWAYS
	var/amount_grown = 0
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	gold_core_spawnable = FRIENDLY_SPAWN

	do_footstep = TRUE

/mob/living/simple_animal/chick/Initialize()
	. = ..()
	pixel_x = rand(-6, 6)
	pixel_y = rand(0, 10)

/mob/living/simple_animal/chick/Life()
	. =..()
	if(!.)
		return
	if(!stat && !ckey)
		amount_grown += rand(1,2)
		if(amount_grown >= 100)
			new /mob/living/simple_animal/chicken(src.loc)
			qdel(src)

/mob/living/simple_animal/chick/holo/Life()
	..()
	amount_grown = 0

/mob/living/simple_animal/chicken
	icon = 'hyperstation/icons/mob/chickens.dmi'
	name = "\improper chicken"
	desc = "Hopefully the eggs are good this season."
	gender = FEMALE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	icon_state = "chicken_brown"
	icon_living = "chicken_brown"
	icon_dead = "chicken_brown_dead"
	speak = list("Cluck!","BWAAAAARK BWAK BWAK BWAK!","Bwaak bwak.")
	speak_emote = list("clucks","croons")
	emote_hear = list("clucks.")
	emote_see = list("pecks at the ground.","flaps its wings viciously.")
	density = FALSE
	speak_chance = 2
	turns_per_move = 3
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/chicken = 2)
	var/egg_type = /obj/item/reagent_containers/food/snacks/egg
	var/food_type = /obj/item/reagent_containers/food/snacks/grown/wheat
	response_help  = "pets"
	response_disarm = "gently pushes aside"
	response_harm   = "kicks"
	attacktext = "kicks"
	health = 15
	maxHealth = 15
	ventcrawler = VENTCRAWLER_ALWAYS
	var/eggsleft = 0
	var/eggsFertile = FALSE
	var/body_color
	var/icon_prefix = "chicken"
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_SMALL
	var/list/feedMessages = list("It clucks happily.","It clucks happily.")
	var/list/layMessage = EGG_LAYING_MESSAGES
	var/list/validColors = list("brown","black","white")
	gold_core_spawnable = FRIENDLY_SPAWN
	var/static/chicken_count = 0

	var/partner //for the sex.
	var/egglay_timer = 0
	var/obj/structure/nestbox/nest_target

	var/last_egg
	var/force_gender //for map loading


	do_footstep = TRUE

/mob/living/simple_animal/chicken/Initialize()
	. = ..()
	if((prob(30) && !force_gender) || force_gender == "male") //30% of a male. or setup if already male.
		gender = MALE
		name = "rooster"

	if(!body_color)
		body_color = pick(validColors)
	icon_state = "[icon_prefix]_[body_color]"
	icon_living = "[icon_prefix]_[body_color]"
	icon_dead = "[icon_prefix]_[body_color]_dead"
	pixel_x = rand(-6, 6)
	pixel_y = rand(0, 10)
	++chicken_count

/mob/living/simple_animal/chicken/Destroy()
	--chicken_count
	return ..()

/mob/living/simple_animal/chicken/attackby(obj/item/O, mob/user, params)
	if(istype(O, food_type)) //feedin' dem chickens
		if(!stat && eggsleft < 2)
			var/feedmsg = "[user] feeds [O] to [name]! [pick(feedMessages)]"
			user.visible_message(feedmsg)
			qdel(O)
			eggsleft += 1
			egglay_timer = 0
		else
			to_chat(user, "<span class='warning'>[name] doesn't seem hungry!</span>")
	else
		..()


/mob/living/simple_animal/chicken/Life()
	. = ..()
	if(!.)
		return
	if (istype(get_turf(src), /turf/open/floor))
		var/turf/open/floor/turfon = get_turf(src)
		if (turfon.farm_quality > happiness)
			happiness ++
			if (prob(5))
				visible_message("[src] pecks happily at the ground.") //CLUCK CLUCK CLUCK
		else
			happiness --
	else
		happiness --

	happiness = clamp(happiness,0,100) //clamp


	if (!(gender == FEMALE)) //only females lay eggs and do the rest of the code.
		return


	//Breeding.
	if (gender == FEMALE && eggsFertile == 0 && eggsleft > 0)
		for(var/mob/living/simple_animal/chicken/C in view(2,src)) //look for a male near them, or on them.
			if(C)
				if(C.gender == MALE) //rooster
					eggsFertile = 1 //they had sex, just go with it.
					partner = C //you know who the partner is.
	//EEGGGG TIME

	//after 10mins, lay a egg regardless.
	if(world.time > (last_egg+600 SECONDS) && !eggsleft)
		if(prob(15)) //just to offset
			eggsleft ++
			last_egg = world.time


	if((!stat && eggsleft > 0) && egg_type)
		egglay_timer ++
	else
		egglay_timer = 0


	//chance to lay egg on their own.


	//look for nest!

	//We have found a nest, override movement
	if(nest_target) //if alive and we have a target.
		stop_automated_movement = 1
		walk_to(src,nest_target,0,8)
	else
		stop_automated_movement = 0
		walk_to(src,0) //reset walk_to

	if (egglay_timer > 10 && !stat) //time to lay a egg and not dead.
		if((!stat && eggsleft > 0) && egg_type)
			if (!nest_target)
				for(var/obj/structure/nestbox/N in view(3,src)) // look for a eggbox if you dont have one already
					nest_target = N
					break

		//We are at the nest we have chosen.
		if (nest_target)
			for(var/obj/structure/nestbox/B in get_turf(src))
				if((prob(25) && eggsleft > 0) && egg_type)
					visible_message("<span class='alertalien'>[src] [pick(layMessage)]</span>")
					eggsleft--
					var/obj/item/E = new egg_type(get_turf(src))
					E.pixel_x = rand(-6,6)
					E.pixel_y = rand(-6,6)
					egglay_timer = 0 //set timer
					nest_target = null //layed the egg, time to move on
					if(eggsFertile && partner)
						if(chicken_count < MAX_CHICKENS && prob(happiness))
							START_PROCESSING(SSobj, E)
							eggsFertile = 0 //youve layed your fertile egg.
							E.name = "fertile egg"
							partner = null
							last_egg = world.time
				break


/obj/item/reagent_containers/food/snacks/egg/var/amount_grown = 0
/obj/item/reagent_containers/food/snacks/egg/process()
	if(isturf(loc))
		for(var/obj/structure/nestbox/B in get_turf(src)) //can only hatch in a nestbox or incubator
			amount_grown += rand(1,2)
			if(amount_grown >= 100)
				visible_message("[src] hatches with a quiet cracking sound.")
				new /mob/living/simple_animal/chick(get_turf(src))
				STOP_PROCESSING(SSobj, src)
				qdel(src)
			break
	else
		STOP_PROCESSING(SSobj, src)


/mob/living/simple_animal/chicken/examine()
	. = ..()
	. += "this one is [gender]."
	if(happiness<20)
		. += "<span class='warning'>It looks stressed.</span>"
