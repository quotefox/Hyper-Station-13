/datum/round_event_control/portal_storm_syndicate
	name = "Portal Storm: Syndicate Shocktroops"
	typepath = /datum/round_event/portal_storm/syndicate_shocktroop
	weight = 2
	min_players = 25
	earliest_start = 50 MINUTES

/datum/round_event/portal_storm/syndicate_shocktroop
	boss_types = list(/mob/living/simple_animal/hostile/syndicate/melee/space/stormtrooper = 2)
	hostile_types = list(/mob/living/simple_animal/hostile/syndicate/melee/space = 8,\
						/mob/living/simple_animal/hostile/syndicate/ranged/space = 2)

/datum/round_event_control/portal_storm_narsie
	name = "Portal Storm: Constructs"
	typepath = /datum/round_event/portal_storm/portal_storm_narsie
	weight = 0
	max_occurrences = 0

/datum/round_event/portal_storm/portal_storm_narsie
	boss_types = list(/mob/living/simple_animal/hostile/construct/builder = 6)
	hostile_types = list(/mob/living/simple_animal/hostile/construct/armored/hostile = 8,\
						/mob/living/simple_animal/hostile/construct/wraith/hostile = 6)

/datum/round_event_control/portal_storm_mesa
	name = "Portal Storm: Mesa"
	typepath = /datum/round_event/portal_storm/portal_storm_mesa
	weight = 0
	max_occurrences = 0

/datum/round_event/portal_storm/portal_storm_mesa
	boss_types = list(/mob/living/simple_animal/hostile/jungle/leaper = 4, \
						/mob/living/simple_animal/hostile/jungle/mega_arachnid = 6, \
						/mob/living/simple_animal/hostile/asteroid/hivelord = 5)
	hostile_types = list(/mob/living/carbon/alien/larva = 2, \
						/mob/living/simple_animal/hostile/netherworld = 8, \
						/mob/living/simple_animal/hostile/asteroid/fugu = 7, \
						/mob/living/simple_animal/hostile/asteroid/basilisk = 8, \
						/mob/living/simple_animal/hostile/asteroid/gutlunch = 7, \
						/mob/living/simple_animal/hostile/statue = 6, \
						/mob/living/simple_animal/hostile/zombie = 12, \
						/mob/living/simple_animal/hostile/netherworld/migo = 10, \
						/mob/living/simple_animal/hostile/netherworld/blankbody = 6
						)

/datum/round_event/portal_storm
	startWhen = 7
	endWhen = 999
	announceWhen = 1

	var/list/boss_spawn = list()
	var/list/boss_types = list() //only configure this if you have hostiles
	var/number_of_bosses
	var/next_boss_spawn
	var/list/hostiles_spawn = list()
	var/list/hostile_types = list()
	var/number_of_hostiles
	var/mutable_appearance/storm

/datum/round_event/portal_storm/portal_storm_mesa/setup()
	. = ..()
	storm = mutable_appearance('hyperstation/icons/obj/stationobjs.dmi', "fart_hole", FLY_LAYER)//Why do I do these things??
	for(var/mob/M in GLOB.player_list)
		SEND_SOUND(M, 'sound/music/half-life07.ogg')

/datum/round_event/portal_storm/setup()
	storm = mutable_appearance('icons/obj/tesla_engine/energy_ball.dmi', "energy_ball_fast", FLY_LAYER)
	storm.color = "#00FF00"

	number_of_bosses = 0
	for(var/boss in boss_types)
		number_of_bosses += boss_types[boss]

	number_of_hostiles = 0
	for(var/hostile in hostile_types)
		number_of_hostiles += hostile_types[hostile]

	while(number_of_bosses > boss_spawn.len)
		boss_spawn += get_safe_random_station_turf()

	while(number_of_hostiles > hostiles_spawn.len)
		hostiles_spawn += get_safe_random_station_turf()

	next_boss_spawn = startWhen + CEILING(2 * number_of_hostiles / number_of_bosses, 1)

/datum/round_event/portal_storm/announce(fake)
	set waitfor = 0
	sound_to_playing_players('sound/magic/lightning_chargeup.ogg')
	sleep(80)
	priority_announce("Massive bluespace anomaly detected en route to [station_name()]. Brace for impact.")
	sleep(20)
	sound_to_playing_players('sound/magic/lightningbolt.ogg')

/datum/round_event/portal_storm/tick()
	spawn_effects(get_random_station_turf())

	if(spawn_hostile())
		var/type = safepick(hostile_types)
		hostile_types[type] = hostile_types[type] - 1
		spawn_mob(type, hostiles_spawn)
		if(!hostile_types[type])
			hostile_types -= type

	if(spawn_boss())
		var/type = safepick(boss_types)
		boss_types[type] = boss_types[type] - 1
		spawn_mob(type, boss_spawn)
		if(!boss_types[type])
			boss_types -= type

	time_to_end()

/datum/round_event/portal_storm/proc/spawn_mob(type, spawn_list)
	if(!type)
		return
	var/turf/T = pick_n_take(spawn_list)
	if(!T)
		return
	new type(T)
	spawn_effects(T)

/datum/round_event/portal_storm/proc/spawn_effects(turf/T)
	if(!T)
		log_game("Portal Storm failed to spawn effect due to an invalid location.")
		return
	T = get_step(T, SOUTHWEST) //align center of image with turf
	flick_overlay_static(storm, T, 15)
	playsound(T, 'sound/magic/lightningbolt.ogg', rand(80, 100), 1)

/datum/round_event/portal_storm/proc/spawn_hostile()
	if(!hostile_types || !hostile_types.len)
		return 0
	return ISMULTIPLE(activeFor, 2)

/datum/round_event/portal_storm/proc/spawn_boss()
	if(!boss_types || !boss_types.len)
		return 0

	if(activeFor == next_boss_spawn)
		next_boss_spawn += CEILING(number_of_hostiles / number_of_bosses, 1)
		return 1

/datum/round_event/portal_storm/proc/time_to_end()
	if(!hostile_types.len && !boss_types.len)
		endWhen = activeFor

	if(!number_of_hostiles && number_of_bosses)
		endWhen = activeFor
