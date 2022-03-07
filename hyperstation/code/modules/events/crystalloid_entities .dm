/datum/round_event_control/crystalloid_entities
	name = "Crystal Invasion"
	typepath = /datum/round_event/crystalloid_entities
	weight = 10 //decreased weight from 15 to 10
	min_players = 2 //increased min players from 2 to 5 to reduce chances of half the crew dying in a carp breach
	earliest_start = 10 MINUTES
	max_occurrences = 2


/datum/round_event/crystalloid_entities
	announceWhen	= 3
	startWhen = 50

/datum/round_event/crystalloid_entities/setup()
	startWhen = rand(40, 60)

/datum/round_event/crystalloid_entities/announce(fake)
	if(prob(70))
		priority_announce("Unknown inorganic entities have been detected near [station_name()], please stand-by.", "Lifesign Alert", 'sound/ai/crystal.ogg')
	else
		priority_announce("A report has been downloaded and printed out at all communications consoles.", "Incoming Classified Message", 'sound/ai/commandreport.ogg') // CITADEL EDIT metabreak
		for(var/obj/machinery/computer/communications/C in GLOB.machines)
			if(!(C.stat & (BROKEN|NOPOWER)) && is_station_level(C.z))
				var/obj/item/paper/P = new(C.loc)
				P.name = "Crystalloid entities"
				P.info = "Unknown inorganic entities have been detected near [station_name()], you may wish to break out arms."
				P.update_icon()


/datum/round_event/crystalloid_entities/start()
	for(var/obj/effect/landmark/carpspawn/C in GLOB.landmarks_list)
		if(prob(70)) //dont spawn them EVERYWHERE, they are tougher than carps.
			new /mob/living/simple_animal/hostile/crystal(C.loc)

