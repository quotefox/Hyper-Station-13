/mob/living/simple_animal/hostile/hs13mimic
	name = "Mimic"
	icon = 'hyperstation/icons/mobs/mimic.dmi'
	desc = "What the fuck is that?"
	icon_state = "mimic"
	icon_living = "mimic"
	icon_dead = "mimic_dead"
	gender = NEUTER
	speak_chance = 0
	maxHealth = 38
	health = 38
	turns_per_move = 5
	move_to_delay = 3
	speed = 0
	see_in_dark = 6
	pass_flags = PASSTABLE
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/xeno = 2)
	response_help  = "prods"
	response_disarm = "pushes aside"
	response_harm   = "smacks"
	melee_damage_lower = 8
	melee_damage_upper = 12
	attacktext = "slams"
	attack_sound = 'sound/weapons/punch1.ogg'
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	ventcrawler = VENTCRAWLER_ALWAYS
	blood_volume = 0
	faction = list("mimic")
	gold_core_spawnable = NO_SPAWN
	vision_range = 2
	aggro_vision_range = 9
	wander = TRUE
	minbodytemp = 250 //VERY weak to cold
	maxbodytemp = 1500
	pressure_resistance = 600
	var/unstealth = FALSE
	var/knockdown_people = 1

/mob/living/simple_animal/hostile/hs13mimic/Initialize()
	. = ..()
	// When initialized, make sure they take the form of something.
	unstealth = FALSE
	Mimictransform()

/mob/living/simple_animal/hostile/hs13mimic/attack_hand(mob/living/carbon/human/M)
	. = ..()
	trigger()

/mob/living/simple_animal/hostile/hs13mimic/proc/Mimictransform() //The list of default things to transform needs to be bigger, consider this in the future.
	var/transformitem = rand(1,100)
	medhudupdate()
	if(unstealth == FALSE)
		wander = FALSE
		vision_range = initial(vision_range)
		switch(transformitem)
			if(1 to 10)
				name = "drinking glass"
				icon = 'icons/obj/drinks.dmi'
				icon_state = "glass_empty"
				desc = "Your standard drinking glass."
			if(11 to 20)
				name = "insulated gloves"
				icon = 'icons/obj/clothing/gloves.dmi'
				icon_state = "yellow"
				desc = "These gloves will protect the wearer from electric shock."
			if(21 to 30)
				name = "Private Security Officer"
				desc = "A cardboard cutout of a private security officer."
				icon = 'icons/obj/cardboard_cutout.dmi'
				icon_state = "cutout_ntsec"
			if(31 to 40)
				name = "pen"
				icon = 'icons/obj/bureaucracy.dmi'
				icon_state = "pen"
				desc = "It's a black ink pen, modified for use with both paper and Nanotransen-brand Digital-Readpads™!"
			if(41 to 50)
				name = "newspaper"
				desc = "An issue of The Griffon, the newspaper circulating aboard Kin.Co Space Stations."
				icon = 'icons/obj/bureaucracy.dmi'
				icon_state = "newspaper"
			if(51 to 60)
				name = "toolbox"
				desc = "Danger. Very robust."
				icon = 'icons/obj/storage.dmi'
				icon_state = "red"
			if(61 to 70)
				name = "emergency oxygen tank"
				desc = "Used for emergencies. Contains very little oxygen, so try to conserve it until you actually need it."
				icon = 'icons/obj/tank.dmi'
				icon_state = "emergency"
			if(71 to 80)
				name = "drinking glass"
				icon = 'icons/obj/drinks.dmi'
				icon_state = "glass_empty"
				desc = "Your standard drinking glass."
			if(81 to 90)
				name = "fleshlight"
				icon = 'hyperstation/icons/obj/fleshlight.dmi'
				icon_state = "fleshlight_totallynotamimic"
				desc = "A sex toy disguised as a flashlight, used to stimulate someones penis, complete with colour changing sleeve."
			if(91 to 100)
				icon = 'modular_citadel/icons/obj/genitals/dildo.dmi'
				switch(rand(1,3)) //switch within a switch hmmmmmmmmmm
					if(1)
						icon_state = "dildo_knotted_2"
						name = "small knotted dildo"
					if(2)
						icon_state = "dildo_flared_4"
						name = "huge flared dildo"
					if(3)
						icon_state = "dildo_knotted_3"
						name = "big knotted dildo"
				desc = "Floppy!"
	else
		restore()

/mob/living/simple_animal/hostile/hs13mimic/AttackingTarget()
	. = ..()
	if(knockdown_people && . && prob(15) && iscarbon(target))
		var/mob/living/carbon/C = target
		C.Knockdown(40)
		C.visible_message("<span class='danger'>\The [src] knocks down \the [C]!</span>", \
				"<span class='userdanger'>\The [src] knocks you down!</span>")

/mob/living/simple_animal/hostile/hs13mimic/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	trigger()
	. = ..()

/mob/living/simple_animal/hostile/hs13mimic/FindTarget()
	. = ..()
	if(.)
		trigger()
	else if(!target && unstealth)
		trytftorandomobject()

/mob/living/simple_animal/hostile/hs13mimic/death(gibbed)
	restore()
	. = ..()

/mob/living/simple_animal/hostile/hs13mimic/med_hud_set_health()
	if(!unstealth)
		var/image/holder = hud_list[HEALTH_HUD]
		holder.icon_state = null
		return //we hide medical hud while morphed
	..()

/mob/living/simple_animal/hostile/hs13mimic/med_hud_set_status()
	if(!unstealth)
		var/image/holder = hud_list[STATUS_HUD]
		holder.icon_state = null
		return //we hide medical hud while morphed
	..()

/mob/living/simple_animal/hostile/hs13mimic/proc/medhudupdate()
	med_hud_set_health()
	med_hud_set_status()

/mob/living/simple_animal/hostile/hs13mimic/proc/restore()
	//back to normal mimic sprite
	medhudupdate()
	name = initial(name)
	icon = 'hyperstation/icons/mobs/mimic.dmi'
	icon_state = "mimic"
	desc = initial(desc)
	wander = TRUE
	vision_range = 9

/mob/living/simple_animal/hostile/hs13mimic/proc/trigger()
	if(unstealth == FALSE)
		unstealth = TRUE
		visible_message("<span class='danger'>The [src] Reveals itself to be a Mimic!</span>")
		Mimictransform()
		playsound(loc, 'hyperstation/sound/creatures/mimictransform.ogg', 75, TRUE)
		triggerOthers(target) // Friends too!

/mob/living/simple_animal/hostile/hs13mimic/proc/triggerOthers(passtarget) //
	for(var/mob/living/simple_animal/hostile/hs13mimic/C in oview(5, src.loc))
		if(passtarget && C.target == null)
			C.target = passtarget
		C.trigger()

/mob/living/simple_animal/hostile/hs13mimic/proc/trytftorandomobject()
	unstealth = FALSE
	medhudupdate()
	var/list/obj/item/listItems = list()
	for(var/obj/item/I in oview(9,src.loc))
		listItems += I
	if(LAZYLEN(listItems))
		var/obj/item/changedReference = pick(listItems)
		wander = FALSE
		vision_range = initial(vision_range)
		name = changedReference.name
		icon = changedReference.icon
		icon_state = changedReference.icon_state
		desc = changedReference.desc
	else
		Mimictransform()
