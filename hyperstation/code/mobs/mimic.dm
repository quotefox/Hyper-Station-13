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
	move_to_delay = 1
	speed = 0
	see_in_dark = 8
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	pass_flags = PASSTABLE
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/xeno = 2)
	response_help  = "prods"
	response_disarm = "pushes aside"
	response_harm   = "smacks"
	melee_damage_lower = 8
	melee_damage_upper = 12
	attacktext = "glomps"
	attack_sound = 'sound/effects/blobattack.ogg'
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	ventcrawler = VENTCRAWLER_ALWAYS
	blood_volume = 0
	faction = list("mimic")
	gold_core_spawnable = NO_SPAWN
	vision_range = 2
	aggro_vision_range = 9
	wander = TRUE
	minbodytemp = 250 //weak to cold
	maxbodytemp = 1500
	pressure_resistance = 1200
	sight = SEE_MOBS
	var/stealthed = TRUE
	var/knockdown_people = 1
	var/playerTransformCD = 50
	var/playerTfTime
	var/static/mimic_blacklisted_transform_items = typecacheof(list(
	/obj/item/projectile,
	/obj/item/radio/intercom,
	/mob/living/simple_animal/bot))
	var/playstyle_string = "<span class='boldannounce'>You are a mimic</span></b>, a tricky creature that can take the form of \
							almost any item nearby by shift-clicking it. While morphed, you move slowly and do less damage. \
							Finally, you can restore yourself to your original form while morphed by shift-clicking yourself. \
							Attacking carbon lifeforms will heal you at the cost of destructuring their DNA. \
							You can also change your form to that of simple animals, but be wary that anyone examining you can \
							find out.</b>"

/mob/living/simple_animal/hostile/hs13mimic/Initialize()
	. = ..()
	trytftorandomobject() // When initialized, make sure they take the form of something.

/mob/living/simple_animal/hostile/hs13mimic/Login()
	. = ..()
	SEND_SOUND(src, sound('sound/ambience/antag/ling_aler.ogg'))
	to_chat(src, src.playstyle_string)

/mob/living/simple_animal/hostile/hs13mimic/attack_hand(mob/living/carbon/human/M)
	. = ..()
	if(stealthed && stat == CONSCIOUS)
		if(M.a_intent == INTENT_HELP)//They're trying to pick us up! We tricked them boys! *plays runescape sea shanty*
			target = M
			guaranteedknockdown(M)
		trigger() // Bring our friends if any!

/mob/living/simple_animal/hostile/hs13mimic/AttackingTarget()
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		if(.)
			if(stealthed && knockdown_people) //Guaranteed knockdown if we get the first hit while disguised. Typically, only players can do this since NPC mimics transform first before attacking.
				restore()
				C.Knockdown(40)
				C.visible_message("<span class='danger'>\The [src] knocks down \the [C]!</span>", \
					"<span class='userdanger'>\The [src] knocks you down!</span>")
			else if(knockdown_people && prob(15))
				C.Knockdown(40)
				C.visible_message("<span class='danger'>\The [src] knocks down \the [C]!</span>", \
						"<span class='userdanger'>\The [src] knocks you down!</span>")
			if(C.nutrition >= 15)
				C.nutrition -= (rand(7,15)) //They lose 7-15 nutrition
				adjustBruteLoss(-3) //We heal 3 damage
			C.adjustCloneLoss(rand(2,4)) //They also take a bit of cellular damage.
	if(isanimal(target))
		var/mob/living/simple_animal/A = target
		if(.)
			if(stealthed)
				restore()
			if(A.stat == CONSCIOUS)
				adjustBruteLoss(-3) //We heal 3 damage

/mob/living/simple_animal/hostile/hs13mimic/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	trigger()
	. = ..()

/mob/living/simple_animal/hostile/hs13mimic/FindTarget()
	. = ..()
	if(.)
		trigger() //We have a target! Trigger!
	else if(!target && !stealthed) //Has no target, isn't stealthed, let's search for an object to transform
		trytftorandomobject()

/mob/living/simple_animal/hostile/hs13mimic/death(gibbed)
	restore() //We died. Restore form.
	. = ..()

/mob/living/simple_animal/hostile/hs13mimic/med_hud_set_health()
	if(stealthed)
		var/image/holder = hud_list[HEALTH_HUD]
		holder.icon_state = null
		return //we hide medical hud while morphed
	..()

/mob/living/simple_animal/hostile/hs13mimic/med_hud_set_status()
	if(stealthed)
		var/image/holder = hud_list[STATUS_HUD]
		holder.icon_state = null
		return //we hide medical hud while morphed
	..()

/mob/living/simple_animal/hostile/hs13mimic/proc/mimicTransformList() //The list of default things to transform needs to be bigger, consider this in the future.
	var/transformitem = rand(1,100)
	medhudupdate()
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

/mob/living/simple_animal/hostile/hs13mimic/proc/guaranteedknockdown(mob/living/carbon/human/M)
	M.Knockdown(40)
	M.visible_message("<span class='danger'>\The [src] knocks down \the [M]!</span>", \
	"<span class='userdanger'>\The [src] tricks you, knocking you down!</span>")

/mob/living/simple_animal/hostile/hs13mimic/proc/medhudupdate()
	med_hud_set_health()
	med_hud_set_status()

/mob/living/simple_animal/hostile/hs13mimic/proc/restore()
	//back to normal mimic sprite
	stealthed = FALSE
	medhudupdate()
	name = initial(name)
	icon = 'hyperstation/icons/mobs/mimic.dmi'
	icon_state = "mimic"
	desc = initial(desc)
	speed = initial(speed)
	wander = TRUE
	vision_range = 9

/mob/living/simple_animal/hostile/hs13mimic/proc/trigger()
	if(stealthed && stat == CONSCIOUS)
		visible_message("<span class='danger'>The [src] Reveals itself to be a Mimic!</span>")
		restore()
		playsound(loc, 'hyperstation/sound/creatures/mimictransform.ogg', 75, TRUE)
		triggerOthers(target) // Friends too!

/mob/living/simple_animal/hostile/hs13mimic/proc/triggerOthers(passtarget) //
	for(var/mob/living/simple_animal/hostile/hs13mimic/C in oview(5, src.loc))
		if(passtarget && C.target == null && !(isdead(target)))
			C.target = passtarget
		C.trigger()

/mob/living/simple_animal/hostile/hs13mimic/proc/trytftorandomobject()
	stealthed = TRUE
	medhudupdate()
	var/list/obj/item/listItems = list()
	for(var/obj/item/I in oview(9,src.loc))
		if(allowed(I))
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
		mimicTransformList() //Couldn't find any valid items, let's go for the default list then.

/mob/living/simple_animal/hostile/hs13mimic/proc/allowed(atom/movable/A)
	return !is_type_in_typecache(A, mimic_blacklisted_transform_items) && (isitem(A) || isanimal(A))

//Player control code

/mob/living/simple_animal/hostile/hs13mimic/ShiftClickOn(atom/movable/A)
	if(playerTfTime <= world.time && stat == CONSCIOUS)
		if(A == src)
			restore()
			playerTfTime = world.time + playerTransformCD
			return
		if(istype(A) && allowed(A))
			stealthed = TRUE
			SEND_SOUND(src, sound('hyperstation/sound/creatures/mimictransform.ogg',volume=50))
			name = A.name
			icon = A.icon
			icon_state = A.icon_state
			desc = A.desc
			speed = 5
			playerTfTime = world.time + playerTransformCD
			if(isanimal(A))
				var/mob/living/simple_animal/animal = A
				icon_state = animal.icon_living
				desc += "<span class='warning'> But something about it seems wrong...</span>"

	else
		to_chat(src, "<span class='warning'>You need to wait a little longer before you can shift into something else!</span>")
		..()

//Event control

/datum/round_event_control/mimic_infestation
	name = "Mimic Infestation"
	typepath = /datum/round_event/mimic_infestation
	weight = 5
	max_occurrences = 1
	min_players = 15

/datum/round_event/mimic_infestation
	announceWhen = 200
	var/static/list/mimic_station_areas_blacklist = typecacheof(/area/space, 
	/area/shuttle,
	/area/mine, 
	/area/holodeck, 
	/area/ruin, 
	/area/hallway, 
	/area/hallway/primary, 
	/area/hallway/secondary, 
	/area/hallway/secondary/entry,
	/area/engine/supermatter, 
	/area/engine/atmospherics_engine, 
	/area/engine/engineering/reactor_core, 
	/area/engine/engineering/reactor_control, 
	/area/ai_monitored/turret_protected/ai, 
	/area/layenia/cloudlayer, 
	/area/asteroid/nearstation, 
	/area/science/server, 
	/area/science/explab, 
	/area/security/processing)
	var/spawncount = 1
	fakeable = FALSE

/datum/round_event/mimic_infestation/setup()
	announceWhen = rand(announceWhen, announceWhen + 50)
	spawncount = rand(4, 7)

/datum/round_event/mimic_infestation/announce(fake)
	priority_announce("Unidentified lifesigns detected aboard [station_name()]. Secure any exterior access, including ducting and ventilation.", "Lifesign Alert", 'sound/ai/aliens.ogg')

/datum/round_event/mimic_infestation/start()
	var/list/area/stationAreas = list()
	var/list/area/eligible_areas = list()
	for(var/area/A in world) // Get the areas in the Z level
		if(A.z == SSmapping.station_start)
			stationAreas += A
	for(var/area/place in stationAreas) // first we check if it's a valid area
		if(place.outdoors)
			continue
		if(place.areasize < 16)
			continue
		if(is_type_in_typecache(place, mimic_station_areas_blacklist))
			continue
		eligible_areas += place
	for(var/area/place in eligible_areas) // now we check if there are people in that area
		var/numOfPeople
		for(var/mob/living/carbon/H in place)
			numOfPeople++
			break
		if(numOfPeople > 0)
			eligible_areas -= place

	var/validFound = FALSE
	var/list/turf/validTurfs = list()
	var/area/pickedArea
	while(!validFound || !eligible_areas.len)
		pickedArea = pick_n_take(eligible_areas)
		var/list/turf/t = get_area_turfs(pickedArea, SSmapping.station_start)
		for(var/turf/thisTurf in t) // now we check if it's a closed turf, cold turf or occupied turf and yeet it
			if(isopenturf(thisTurf))
				var/turf/open/tempGet = thisTurf
				if(tempGet.air.temperature <= T0C)
					t -= thisTurf
					continue
			if(isclosedturf(thisTurf))
				t -= thisTurf
			else
				for(var/obj/O in thisTurf)
					if(O.density && !(istype(O, /obj/structure/table)))
						t -= thisTurf
						break
		if(t.len >= spawncount) //Is the number of available turfs equal or bigger than spawncount?
			validFound = TRUE
			validTurfs = t

	if(!eligible_areas.len)
		message_admins("No eligible areas for spawning mimics.")
		return WAITING_FOR_SOMETHING

	notify_ghosts("A group of mimics has spawned in [pickedArea]!", source=pickedArea, action=NOTIFY_ATTACK, flashwindow = FALSE)
	while(spawncount > 0 && validTurfs.len)
		var/turf/pickedTurf = pick_n_take(validTurfs)
		var/spawn_type = /mob/living/simple_animal/hostile/hs13mimic
		spawn_atom_to_turf(spawn_type, pickedTurf, 1, FALSE)
		spawncount--
	return SUCCESSFUL_SPAWN
