/datum/round_event_control/carpteam
	name = "Carp Team"
	typepath = /datum/round_event/ghost_role/carpteam
	weight = 0 //Now adminbus
	min_players = 18
	earliest_start = 45 MINUTES
	max_occurrences = 2

/datum/round_event/ghost_role/carpteam
	minimum_required = 1
	role_name = "Carp Team"
	var/maxspawnedanimals = 3
	var/animals = 1
	fakeable = FALSE

/datum/round_event/ghost_role/carpteam/announce(fake)
	var/sentience_report = ""

	var/data = pick("our sophisticated probabilistic models", "our omnipotence", "energy emissions we detected", "\[REDACTED\]")
	var/pets = pick("strange lifeforms", "\[REDACTED\]")
	var/strength = pick("human", "moderate", "\[REDACTED\]")

	sentience_report += "Based on [data], we believe that [pets] around the station has developed [strength] level intelligence, and the ability to communicate."

	priority_announce(sentience_report,"[command_name()] Medium-Priority Update")

/datum/round_event/ghost_role/carpteam/spawn_role()
	var/list/mob/dead/observer/candidates
	candidates = get_candidates(ROLE_ALIEN, null, ROLE_ALIEN)
	if (candidates.len > maxspawnedanimals)
		animals = maxspawnedanimals
	else
		animals = candidates.len
	var/list/potential = list()
	var/counter = 0
	for(var/obj/effect/landmark/carpspawn/C in GLOB.landmarks_list)
		if (counter < animals)
			var/mob/living/simple_animal/thiscarp = null
			// 1% chance for the spawned carp to be a magicarp, 15% to be a shark-type carp and if neither, regular carp.
			if(prob(1))
				thiscarp = new /mob/living/simple_animal/hostile/carp/ranged(C.loc)
			else if(prob(15))
				thiscarp = new /mob/living/simple_animal/hostile/carp/megacarp(C.loc)
			else
				thiscarp = new /mob/living/simple_animal/hostile/carp(C.loc)
			counter++
			potential += thiscarp

	if(!potential.len)
		return WAITING_FOR_SOMETHING
	if(!candidates.len)
		return NOT_ENOUGH_PLAYERS

	var/spawned_animals = 0
	while(spawned_animals < animals && candidates.len && potential.len)
		var/mob/living/simple_animal/SA = pick_n_take(potential)
		var/mob/dead/observer/SG = pick_n_take(candidates)

		spawned_animals++

		SA.key = SG.key

		SA.grant_all_languages(TRUE)

		SA.sentience_act()

		SA.maxHealth = max(SA.maxHealth, 120)
		SA.health = SA.maxHealth
		SA.del_on_death = FALSE

		spawned_mobs += SA

		to_chat(SA, "<span class='userdanger'>Hello carp!</span>")
		to_chat(SA, "<span class='warning'>My oh my, seems you're a bit more than just a space fish now, aren't you? \
			It's up to you and your team of above average IQ carps to either root these pesky stationeers out \
			or help them along their path!</span>")

	return SUCCESSFUL_SPAWN
