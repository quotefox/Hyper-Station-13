#define REVENANT_SPAWN_THRESHOLD 15
#define ABDUCTOR_MAX_TEAMS 4 // blame TG for not using the defines files

//////////////////////////////////////////////
//                                          //
//            MIDROUND RULESETS             //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/midround // Can be drafted once in a while during a round
	ruletype = "Midround"
	/// If the ruleset should be restricted from ghost roles.
	var/restrict_ghost_roles = TRUE
	/// What type the ruleset is restricted to.
	var/required_type = /mob/living/carbon/human
	var/list/living_players = list()
	var/list/living_antags = list()
	var/list/dead_players = list()
	var/list/list_observers = list()
	var/list/ghost_eligible = list()
	var/controller //round event controller for the event - Required for certain events dependendant on variables within their controllers

/datum/dynamic_ruleset/midround/from_ghosts
	weight = 0
	/// Whether the ruleset should call generate_ruleset_body or not.
	var/makeBody = TRUE

/datum/dynamic_ruleset/midround/trim_candidates()
	// Unlike the previous two types, these rulesets are not meant for /mob/dead/new_player
	// And since I want those rulesets to be as flexible as possible, I'm not gonna put much here,
	//
	// All you need to know is that here, the candidates list contains 4 lists itself, indexed with the following defines:
	// Candidates = list(CURRENT_LIVING_PLAYERS, CURRENT_LIVING_ANTAGS, CURRENT_DEAD_PLAYERS, CURRENT_OBSERVERS)
	// So for example you can get the list of all current dead players with var/list/dead_players = candidates[CURRENT_DEAD_PLAYERS]
	// Make sure to properly typecheck the mobs in those lists, as the dead_players list could contain ghosts, or dead players still in their bodies.
	// We're still gonna trim the obvious (mobs without clients, jobbanned players, etc)
	living_players = trim_list(mode.current_players[CURRENT_LIVING_PLAYERS])
	living_antags = trim_list(mode.current_players[CURRENT_LIVING_ANTAGS])
	list_observers = trim_list(mode.current_players[CURRENT_OBSERVERS])
	ghost_eligible = trim_list(get_all_ghost_role_eligible())

/datum/dynamic_ruleset/midround/proc/trim_list(list/L = list())
	var/list/trimmed_list = L.Copy()
	var/antag_name = initial(antag_flag)
	for(var/mob/living/M in trimmed_list)
		if (!istype(M, required_type))
			trimmed_list.Remove(M)
			continue
		if (!M.client) // Are they connected?
			trimmed_list.Remove(M)
			continue
		if(!mode.check_age(M.client, minimum_required_age))
			trimmed_list.Remove(M)
			continue
		if (!(antag_name in M.client.prefs.be_special) || jobban_isbanned(M.ckey, list(antag_name, ROLE_SYNDICATE)))//are they willing and not antag-banned?
			trimmed_list.Remove(M)
			continue
		if (M.mind)
			if (restrict_ghost_roles && M.mind.assigned_role in GLOB.exp_specialmap[EXP_TYPE_SPECIAL]) // Are they playing a ghost role?
				trimmed_list.Remove(M)
				continue
			if (M.mind.assigned_role in restricted_roles || HAS_TRAIT(M, TRAIT_MINDSHIELD)) // Does their job allow it or are they mindshielded?
				trimmed_list.Remove(M)
				continue
			if ((exclusive_roles.len > 0) && !(M.mind.assigned_role in exclusive_roles)) // Is the rule exclusive to their job?
				trimmed_list.Remove(M)
				continue
	return trimmed_list

/datum/dynamic_ruleset/midround/from_ghosts/trim_list(list/L = list())
	var/list/trimmed_list = L.Copy()
	for(var/mob/M in trimmed_list)
		if (!M.client) // Are they connected?
			trimmed_list.Remove(M)
			continue
		if(!mode.check_age(M.client, minimum_required_age))
			trimmed_list.Remove(M)
			continue
		if(antag_flag_override)
			if(!(antag_flag_override in M.client.prefs.be_special) || jobban_isbanned(M.ckey, antag_flag_override))
				trimmed_list.Remove(M)
				continue
		else
			if(!(antag_flag in M.client.prefs.be_special) || jobban_isbanned(M.ckey, antag_flag))
				trimmed_list.Remove(M)
				continue
	return trimmed_list

// You can then for example prompt dead players in execute() to join as strike teams or whatever
// Or autotator someone

// IMPORTANT, since /datum/dynamic_ruleset/midround may accept candidates from both living, dead, and even antag players, you need to manually check whether there are enough candidates
// (see /datum/dynamic_ruleset/midround/autotraitor/ready(var/forced = FALSE) for example)
/datum/dynamic_ruleset/midround/ready(forced = FALSE)
	if (!forced)
		var/job_check = 0
		if (enemy_roles.len > 0)
			for (var/mob/M in living_players)
				if (M.stat == DEAD)
					continue // Dead players cannot count as opponents
				if (M.mind && M.mind.assigned_role && (M.mind.assigned_role in enemy_roles) && (!(M in candidates) || (M.mind.assigned_role in restricted_roles)))
					job_check++ // Checking for "enemies" (such as sec officers). To be counters, they must either not be candidates to that rule, or have a job that restricts them from it
		var/chaos = min(max(round(GLOB.dynamic_chaos_level * 2), 0), 9)
		if (job_check < required_enemies[chaos])
			return FALSE
	return TRUE

/datum/dynamic_ruleset/midround/from_ghosts/ready(forced = FALSE)
	if (required_candidates > ghost_eligible.len)
		SSblackbox.record_feedback("tally","dynamic",1,"Times rulesets rejected due to not enough ghosts")
		return FALSE
	return ..()


/datum/dynamic_ruleset/midround/from_ghosts/execute()
	message_admins("<span class='deadsay'><b>[name]</b> has just been randomly triggered!</span>") //STOP ASSUMING IT'S BADMINS!
	log_game("Midround triggering: [name]")
	var/datum/round_event/E
	//occurances_current++
	if(controller)
		var/datum/round_event_control/C = locate(controller) in SSevents.control
		E = C.runEvent()
	else
		var/application_successful = send_applications(ghost_eligible)
		return assigned.len > 0 && application_successful

	testing("[time2text(world.time, "hh:mm:ss")] [E.type]")

	return E

/// This sends a poll to ghosts if they want to be a ghost spawn from a ruleset.
/datum/dynamic_ruleset/midround/from_ghosts/proc/send_applications(list/possible_volunteers = list())
	if (possible_volunteers.len <= 0) // This shouldn't happen, as ready() should return FALSE if there is not a single valid candidate
		message_admins("Possible volunteers was 0. This shouldn't appear, because of ready(), unless you forced it!")
		return
	message_admins("Polling [possible_volunteers.len] players to apply for the [name] ruleset.")
	log_game("DYNAMIC: Polling [possible_volunteers.len] players to apply for the [name] ruleset.")

	candidates = pollGhostCandidates("The mode is looking for volunteers to become [antag_flag] for [name]", antag_flag, SSticker.mode, antag_flag, poll_time = 300)

	if(!candidates || candidates.len <= 0)
		message_admins("The ruleset [name] received no applications.")
		log_game("DYNAMIC: The ruleset [name] received no applications.")
		mode.refund_threat(cost)
		mode.threat_log += "[worldtime2text()]: Rule [name] refunded [cost] (no applications)"
		mode.executed_rules -= src
		return

	message_admins("[candidates.len] players volunteered for the ruleset [name].")
	log_game("DYNAMIC: [candidates.len] players volunteered for [name].")
	review_applications()

/// Here is where you can check if your ghost applicants are valid for the ruleset.
/// Called by send_applications().
/datum/dynamic_ruleset/midround/from_ghosts/proc/review_applications()
	for (var/i = 1, i <= required_candidates, i++)
		if(candidates.len <= 0)
			if(i == 1)
				// We have found no candidates so far and we are out of applicants.
				mode.refund_threat(cost)
				mode.threat_log += "[worldtime2text()]: Rule [name] refunded [cost] (all applications invalid)"
				mode.executed_rules -= src
			break
		var/mob/applicant = pick(candidates)
		candidates -= applicant
		if(!isobserver(applicant))
			if(applicant.stat == DEAD) // Not an observer? If they're dead, make them one.
				applicant = applicant.ghostize(FALSE)
			else // Not dead? Disregard them, pick a new applicant
				i--
				continue

		if(!applicant)
			i--
			continue

		var/mob/new_character = applicant

		if (makeBody)
			new_character = generate_ruleset_body(applicant)

		finish_setup(new_character, i)
		assigned += applicant
		notify_ghosts("[new_character] has been picked for the ruleset [name]!", source = new_character, action = NOTIFY_ORBIT)

/datum/dynamic_ruleset/midround/from_ghosts/proc/generate_ruleset_body(mob/applicant)
	var/mob/living/carbon/human/new_character = makeBody(applicant)
	new_character.dna.remove_all_mutations()
	return new_character

/datum/dynamic_ruleset/midround/from_ghosts/proc/finish_setup(mob/new_character, index)
	var/datum/antagonist/new_role = new antag_datum()
	setup_role(new_role)
	new_character.mind.add_antag_datum(new_role)
	new_character.mind.special_role = antag_flag

/datum/dynamic_ruleset/midround/from_ghosts/proc/setup_role(datum/antagonist/new_role)
	return

//////////////////////////////////////////////
//                                          //
//           SYNDICATE TRAITORS             //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/midround/autotraitor
	name = "Syndicate Sleeper Agent"
	antag_datum = /datum/antagonist/traitor
	antag_flag = ROLE_TRAITOR
	restricted_roles = list("AI", "Cyborg", "Positronic Brain")
	protected_roles = list("Rookie", "Security Officer", "Warden", "Detective", "Head of Security", "Captain", "Head of Personnel", "Chief Engineer", "Chief Medical Officer", "Research Director", "Quartermaster")
	required_candidates = 1
	enemy_roles = list("Security Officer", "Detective", "Head of Security", "Captain")
	required_enemies = list(2,2,1,1,1,1,1,0,0,0)
	weight = 4
	cost = 10
	requirements = list(101,101,30,25,20,20,15,15,15,10)
	minimum_players = 15
	repeatable = TRUE
	high_population_requirement = 10
	flags = TRAITOR_RULESET
	chaos_min = 3.0
	chaos_max = 4.9

/datum/dynamic_ruleset/midround/autotraitor/thief
	name = "Syndicate Sleeper Agent"
	antag_datum = /datum/antagonist/traitor/thief
	antag_flag = ROLE_TRAITOR
	restricted_roles = list("AI", "Cyborg", "Positronic Brain")
	protected_roles = list("Rookie", "Security Officer", "Warden", "Detective", "Head of Security", "Captain", "Head of Personnel", "Chief Engineer", "Chief Medical Officer", "Research Director", "Quartermaster")
	required_candidates = 1
	weight = 4
	cost = 5
	requirements = list(101,30,25,20,15,10,10,5,5,5)
	minimum_players = 10
	repeatable = TRUE
	high_population_requirement = 10
	flags = TRAITOR_RULESET
	chaos_min = 2.0
	chaos_max = 3.5

/datum/dynamic_ruleset/midround/autotraitor/acceptable(population = 0, threat = 0)
	var/player_count = mode.current_players[CURRENT_LIVING_PLAYERS].len
	var/antag_count = mode.current_players[CURRENT_LIVING_ANTAGS].len
	var/max_traitors = round(player_count / 10) + 1
	if ((antag_count < max_traitors) && prob(mode.threat_level))//adding traitors if the antag population is getting low
		return ..()
	else
		return FALSE

/datum/dynamic_ruleset/midround/autotraitor/trim_candidates()
	..()
	for(var/mob/living/player in living_players)
		if(player.client == null) //Make sure the player has an attached client, otherwise, trim.
			living_players -= player
			continue
		if(issilicon(player)) // Your assigned role doesn't change when you are turned into a silicon.
			living_players -= player
			continue
		if(player.client.prefs.allow_midround_antag == 0) //Do they have midround traitor prefs enabled? If not, trim.
			living_players -= player
			continue
		if(is_centcom_level(player.z))
			living_players -= player // We don't autotator people in CentCom
			continue
		if(player.mind && (player.mind.special_role || player.mind.antag_datums?.len > 0))
			living_players -= player // We don't autotator people with roles already
			continue
		if(ishuman(player))
			var/mob/living/carbon/human/H = player
			if(HAS_TRAIT(H,TRAIT_EXEMPT_HEALTH_EVENTS))
				living_players -= player //We also don't fucking give ghost roles traitor. Yes I'm using the exempt health events trait given to ghost roles to do this, because piggyback ftw.

/datum/dynamic_ruleset/midround/autotraitor/ready(forced = FALSE)
	if (required_candidates > living_players.len)
		return FALSE
	return ..()

/datum/dynamic_ruleset/midround/autotraitor/execute()
	var/mob/M = pick(living_players)
	assigned += M
	living_players -= M
	var/datum/antagonist/traitor/newTraitor = new
	M.mind.add_antag_datum(newTraitor)
	return TRUE

/datum/dynamic_ruleset/midround/autotraitor/thief/execute()
    var/mob/M = pick(living_players)
    assigned += M
    living_players -= M
    var/datum/antagonist/traitor/thief/newTraitor = new
    M.mind.add_antag_datum(newTraitor)
    return TRUE

//////////////////////////////////////////
//                                      //
//                LEWD                  //
//                                      //
//////////////////////////////////////////
/* //Putting Lewd traitor on the backburner until we can buffer it a bit.
/datum/dynamic_ruleset/midround/autotraitor/lewd
	name = "Horny Traitor"
	persistent = TRUE
	antag_flag = ROLE_LEWD_TRAITOR
	antag_datum = /datum/antagonist/traitor/lewd
	//minimum_required_age = 7
	protected_roles = list("AI","Cyborg", "Positronic Brain")
	restricted_roles = list("Cyborg","AI", "Positronic Brain")
	required_candidates = 1
	weight = 2
	cost = 0
	requirements = list(101,101,101,101,101,101,101,101,101,101)
	high_population_requirement = 10
	chaos_min = 0.1
	chaos_max = 2.0
	admin_required = TRUE
	//vars for execution
	var/list/mob/living/carbon/human/lewd_candidates = list()
	var/list/mob/living/carbon/human/targets = list()
	var/numTraitors = 1

/datum/dynamic_ruleset/midround/autotraitor/lewd/acceptable(population = 0, threat = 0) //copy paste to bypass parent
	if(minimum_players > population)
		return FALSE
	if(maximum_players > 0 && population > maximum_players)
		return FALSE
	if(GLOB.dynamic_chaos_level < chaos_min || GLOB.dynamic_chaos_level > chaos_max)
		return FALSE
	if(admin_required && !GLOB.admins.len)
		return FALSE
	if (population >= GLOB.dynamic_high_pop_limit)
		return (mode.threat_level >= high_population_requirement)
	else
		pop_per_requirement = pop_per_requirement > 0 ? pop_per_requirement : mode.pop_per_requirement
		var/indice_pop = min(10,round(population/pop_per_requirement)+1)
		return (mode.threat_level >= requirements[indice_pop])

/datum/dynamic_ruleset/midround/autotraitor/lewd/trim_candidates()
	..()
	lewd_candidates = living_players
	for(var/mob/living/player in lewd_candidates)
		if(issilicon(player)) // Your assigned role doesn't change when you are turned into a silicon.
			lewd_candidates -= player
			continue
		if(is_centcom_level(player.z))
			lewd_candidates -= player // We don't autotator people in CentCom
			continue
		if(player.mind && (player.mind.special_role || player.mind.antag_datums?.len > 0))
			lewd_candidates -= player // We don't autotator people with roles already

/datum/dynamic_ruleset/midround/autotraitor/lewd/trim_list(list/L = list())
	var/list/trimmed_list = L.Copy()
	var/antag_name = initial(antag_flag)
	for(var/mob/living/M in trimmed_list)
		if (!istype(M, required_type))
			trimmed_list.Remove(M)
			continue
		if (!M.client) // Are they connected?
			trimmed_list.Remove(M)
			continue
		if(!mode.check_age(M.client, minimum_required_age))
			trimmed_list.Remove(M)
			continue
		if (!(antag_name in M.client.prefs.be_special) || jobban_isbanned(M.ckey, list(antag_name, ROLE_SYNDICATE)))//are they willing and not antag-banned?
			trimmed_list.Remove(M)
			continue
		if (M.mind)
			if (restrict_ghost_roles && M.mind.assigned_role in GLOB.exp_specialmap[EXP_TYPE_SPECIAL]) // Are they playing a ghost role?
				trimmed_list.Remove(M)
				continue
			if (M.mind.assigned_role in restricted_roles) // All this work to bypass mindshield restriction
				trimmed_list.Remove(M)
				continue
			if ((exclusive_roles.len > 0) && !(M.mind.assigned_role in exclusive_roles)) // Is the rule exclusive to their job?
				trimmed_list.Remove(M)
				continue
	return trimmed_list

/datum/dynamic_ruleset/midround/autotraitor/lewd/ready()
	for(var/mob/living/target in living_players)
		if(target.client.prefs.noncon)
			targets += target

	if(lewd_candidates.len)
		numTraitors = min(lewd_candidates.len, targets.len, numTraitors)
		if(numTraitors == 0)
			to_chat(GLOB.admins, "No lewd traitors created. Are there any valid targets?")
			return 0
		return 1

	return 0

/datum/dynamic_ruleset/midround/autotraitor/lewd/execute()
	var/mob/M = pick(lewd_candidates)
	lewd_candidates -= M
	assigned += M.mind
	var/datum/antagonist/traitor/lewd/newTraitor = new
	M.mind.add_antag_datum(newTraitor)
	return TRUE
*/
//////////////////////////////////////////////
//                                          //
//         Malfunctioning AI                //
//                              		    //
//////////////////////////////////////////////

/datum/dynamic_ruleset/midround/malf
	name = "Malfunctioning AI"
	antag_datum = /datum/antagonist/traitor
	antag_flag = ROLE_MALF
	enemy_roles = list("Security Officer", "Warden", "Detective", "Head of Security", "Captain", "Scientist", "Research Director", "Chief Engineer", "Engineer", "Shaft Miner")
	exclusive_roles = list("AI")
	required_enemies = list(4,4,4,4,4,4,2,2,2,0)
	required_candidates = 1
	weight = 3
	cost = 20
	requirements = list(101,101,101,45,40,35,30,25,20,15)
	high_population_requirement = 35
	required_type = /mob/living/silicon/ai
	var/ion_announce = 33
	var/removeDontImproveChance = 10
	chaos_min = 3.0

/datum/dynamic_ruleset/midround/malf/trim_candidates()
	..()
	candidates = candidates[CURRENT_LIVING_PLAYERS]
	for(var/mob/living/player in candidates)
		if(!isAI(player))
			candidates -= player
			continue
		if(is_centcom_level(player.z))
			candidates -= player
			continue
		if(player.mind && (player.mind.special_role || player.mind.antag_datums?.len > 0))
			candidates -= player

/datum/dynamic_ruleset/midround/malf/execute()
	if(!candidates || !candidates.len)
		return FALSE
	var/mob/living/silicon/ai/M = pick(candidates)
	candidates -= M
	assigned += M.mind
	var/datum/antagonist/traitor/AI = new
	M.mind.special_role = antag_flag
	M.mind.add_antag_datum(AI)
	if(prob(ion_announce))
		priority_announce("Ion storm detected near the station. Please check all AI-controlled equipment for errors.", "Anomaly Alert", 'sound/ai/ionstorm.ogg')
		if(prob(removeDontImproveChance))
			M.replace_random_law(generate_ion_law(), list(LAW_INHERENT, LAW_SUPPLIED, LAW_ION))
		else
			M.add_ion_law(generate_ion_law())
	return TRUE

//////////////////////////////////////////////
//                                          //
//              WIZARD (GHOST)              //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/midround/from_ghosts/wizard
	name = "Wizard"
	antag_datum = /datum/antagonist/wizard
	antag_flag = ROLE_WIZARD
	enemy_roles = list("Security Officer", "Warden", "Detective", "Head of Security", "Captain")
	required_enemies = list(2,2,1,1,1,1,1,1,1,0)
	required_candidates = 1
	weight = 1
	cost = 20
	requirements = list(101,101,60,55,50,40,30,30,20,20)
	high_population_requirement = 50
	repeatable = FALSE //WE DON'T NEED MORE THAN ONE WIZARD
	chaos_min = 4
	admin_required = TRUE

/datum/dynamic_ruleset/midround/from_ghosts/wizard/ready(forced = FALSE)
	if (required_candidates > (dead_players.len + list_observers.len))
		return FALSE
	if(GLOB.wizardstart.len == 0)
		log_admin("Cannot accept Wizard ruleset. Couldn't find any wizard spawn points.")
		message_admins("Cannot accept Wizard ruleset. Couldn't find any wizard spawn points.")
		return FALSE
	return ..()

/datum/dynamic_ruleset/midround/from_ghosts/wizard/finish_setup(mob/new_character, index)
	..()
	new_character.forceMove(pick(GLOB.wizardstart))

//////////////////////////////////////////////
//                                          //
//          NUCLEAR OPERATIVES (MIDROUND)   //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/midround/from_ghosts/nuclear
	name = "Nuclear Assault"
	antag_flag = ROLE_OPERATIVE
	antag_datum = /datum/antagonist/nukeop
	enemy_roles = list("AI", "Cyborg", "Security Officer", "Warden", "Detective","Head of Security", "Captain")
	required_enemies = list(3,3,3,3,3,2,2,2,2,1)
	required_candidates = 5
	weight = 5
	cost = 20
	requirements = list(101,100,95,85,70,60,50,40,30,20)
	high_population_requirement = 10
	var/operative_cap = list(1,1,1,2,2,3,3,4,4,5)
	var/datum/team/nuclear/nuke_team
	flags = HIGHLANDER_RULESET
	chaos_min = 4.0

/datum/dynamic_ruleset/midround/from_ghosts/nuclear/acceptable(population=0, threat=0)
	if (locate(/datum/dynamic_ruleset/roundstart/nuclear) in mode.executed_rules)
		return FALSE // Unavailable if nuke ops were already sent at roundstart
	var/indice_pop = min(10,round(living_players.len/5)+1)
	required_candidates = operative_cap[indice_pop]
	return ..()

/datum/dynamic_ruleset/midround/from_ghosts/nuclear/ready(forced = FALSE)
	if (required_candidates > (dead_players.len + list_observers.len))
		return FALSE
	return ..()

/datum/dynamic_ruleset/midround/from_ghosts/nuclear/finish_setup(mob/new_character, index)
	new_character.mind.special_role = "Nuclear Operative"
	new_character.mind.assigned_role = "Nuclear Operative"
	if (index == 1) // Our first guy is the leader
		var/datum/antagonist/nukeop/leader/new_role = new
		nuke_team = new_role.nuke_team
		new_character.mind.add_antag_datum(new_role)
	else
		return ..()

//////////////////////////////////////////////
//                                          //
//              BLOB (GHOST)                //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/midround/from_ghosts/blob
	name = "Blob"
	antag_datum = /datum/antagonist/blob
	antag_flag = ROLE_BLOB
	enemy_roles = list("Security Officer", "Warden", "Detective", "Head of Security", "Captain", "Station Engineer")
	required_enemies = list(2,2,1,1,1,1,1,0,0,0)
	required_candidates = 1
	weight = 3
	cost = 20
	requirements = list(101,101,101,60,50,40,40,40,30,20)
	//requirements = list(0,0,0,0,0,0,0,0,0,0)
	high_population_requirement = 50
	repeatable = TRUE
	chaos_min = 4.0
	controller = /datum/round_event_control/blob

/datum/dynamic_ruleset/midround/from_ghosts/blob/generate_ruleset_body(mob/applicant)
	var/body = applicant.become_overmind()
	return body

//////////////////////////////////////////////
//                                          //
//         BLOOD CULT (MIDROUND)            //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/midround/bloodcult
	name = "Blood Cult"
	antag_flag = ROLE_CULTIST
	antag_datum = /datum/antagonist/cult
	minimum_required_age = 14
	restricted_roles = list("AI", "Cyborg")
	protected_roles = list("Rookie", "Security Officer", "Warden", "Detective", "Head of Security", "Captain", "Head of Personnel", "Chief Engineer", "Chief Medical Officer", "Research Director", "Quartermaster")
	required_candidates = 1
	weight = 5
	cost = 20
	requirements = list(101,101,101,95,70,60,60,60,50,50)
	high_population_requirement = 10
	pop_per_requirement = 5
	flags = HIGHLANDER_RULESET
	var/cultist_cap = list(2,2,2,3,3,4,4,4,4,4)
	var/datum/team/cult/main_cult
	chaos_min = 4.5

/datum/dynamic_ruleset/midround/bloodcult/ready(forced = FALSE)
	var/indice_pop = min(10,round(living_players.len/5)+1)
	required_candidates = cultist_cap[indice_pop]
	. = ..()

datum/dynamic_ruleset/midround/bloodcult/trim_candidates()
	..()
	for(var/mob/living/player in living_players)
		if(issilicon(player)) // Your assigned role doesn't change when you are turned into a silicon.
			living_players -= player
			continue
		if(is_centcom_level(player.z))
			living_players -= player // We don't autotator people in CentCom
			continue
		if(player.mind && (player.mind.special_role || player.mind.antag_datums?.len > 0))
			living_players -= player // We don't autotator people with roles already

/datum/dynamic_ruleset/midround/bloodcult/execute()
	var/mob/H = pick(living_players)
	assigned += H.mind
	living_players -= H
	main_cult = new
	for(var/datum/mind/M in assigned)
		var/datum/antagonist/cult/new_cultist = new antag_datum()
		new_cultist.cult_team = main_cult
		new_cultist.give_equipment = TRUE
		M.add_antag_datum(new_cultist)
	main_cult.setup_objectives()
	return TRUE

/datum/dynamic_ruleset/midround/bloodcult/round_result()
	..()
	if(main_cult.check_cult_victory())
		SSticker.mode_result = "win - cult win"
		SSticker.news_report = CULT_SUMMON
	else
		SSticker.mode_result = "loss - staff stopped the cult"
		SSticker.news_report = CULT_FAILURE


//////////////////////////////////////////////
//                                          //
//           XENOMORPH (GHOST)              //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/midround/from_ghosts/xenomorph
	name = "Alien Infestation"
	antag_datum = /datum/antagonist/xeno
	antag_flag = ROLE_ALIEN
	enemy_roles = list("Security Officer", "Warden", "Detective", "Head of Security", "Captain")
	required_enemies = list(2,2,1,1,1,1,1,0,0,0)
	required_candidates = 1
	weight = 3
	cost = 15
	requirements = list(101,101,101,50,40,35,30,30,30,20)
	//requirements = list(0,0,0,0,0,0,0,0,0,0)
	high_population_requirement = 50
	repeatable = TRUE
	var/list/vents = list()
	chaos_min = 3.5
	controller = /datum/round_event_control/alien_infestation

/datum/dynamic_ruleset/midround/from_ghosts/xenomorph/execute()
	// 50% chance of being incremented by one
	required_candidates += prob(50)
	for(var/obj/machinery/atmospherics/components/unary/vent_pump/temp_vent in GLOB.machines)
		if(QDELETED(temp_vent))
			continue
		if(is_station_level(temp_vent.loc.z) && !temp_vent.welded)
			var/datum/pipeline/temp_vent_parent = temp_vent.parents[1]
			if(!temp_vent_parent)
				continue // No parent vent
			// Stops Aliens getting stuck in small networks.
			// See: Security, Virology
			if(temp_vent_parent.other_atmosmch.len > 20)
				vents += temp_vent
	if(!vents.len)
		return FALSE
	. = ..()

/datum/dynamic_ruleset/midround/from_ghosts/xenomorph/generate_ruleset_body(mob/applicant)
	var/obj/vent = pick_n_take(vents)
	var/mob/living/carbon/alien/larva/new_xeno = new(vent.loc)
	new_xeno.key = applicant.key
	message_admins("[ADMIN_LOOKUPFLW(new_xeno)] has been made into an alien by the midround ruleset.")
	log_game("DYNAMIC: [key_name(new_xeno)] was spawned as an alien by the midround ruleset.")
	return new_xeno

//////////////////////////////////////////////
//                                          //
//           NIGHTMARE (GHOST)              //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/midround/from_ghosts/nightmare
	name = "Nightmare"
	antag_datum = /datum/antagonist/nightmare
	controller = /datum/round_event_control/nightmare
	antag_flag = "Nightmare"
	antag_flag_override = ROLE_ALIEN
	enemy_roles = list("Security Officer", "Warden", "Detective", "Head of Security", "Captain")
	required_enemies = list(2,2,1,1,1,1,1,0,0,0)
	required_candidates = 1
	weight = 4
	cost = 10
	requirements = list(101,50,40,30,20,20,20,20,15,10)
	high_population_requirement = 50
	repeatable = FALSE
	var/list/spawn_locs = list()
	chaos_min = 3

/datum/dynamic_ruleset/midround/from_ghosts/nightmare/execute()
	for(var/X in GLOB.xeno_spawn)
		var/turf/T = X
		var/light_amount = T.get_lumcount()
		if(light_amount < SHADOW_SPECIES_LIGHT_THRESHOLD)
			spawn_locs += T
	if(!spawn_locs.len)
		return FALSE
	. = ..()

/datum/dynamic_ruleset/midround/from_ghosts/nightmare/generate_ruleset_body(mob/applicant)
	var/datum/mind/player_mind = new /datum/mind(applicant.key)
	player_mind.active = TRUE

	var/mob/living/carbon/human/S = new (pick(spawn_locs))
	player_mind.transfer_to(S)
	player_mind.assigned_role = "Nightmare"
	player_mind.special_role = "Nightmare"
	player_mind.add_antag_datum(/datum/antagonist/nightmare)
	S.set_species(/datum/species/shadow/nightmare)

	playsound(S, 'sound/magic/ethereal_exit.ogg', 50, 1, -1)
	message_admins("[ADMIN_LOOKUPFLW(S)] has been made into a Nightmare by the midround ruleset.")
	log_game("DYNAMIC: [key_name(S)] was spawned as a Nightmare by the midround ruleset.")
	return S

//////////////////////////////////////////////
//                                          //
//               ABDUCTORS                  //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/midround/from_ghosts/abductors
	name = "Abductors"
	//config_tag = "abductors"
	antag_flag = ROLE_ABDUCTOR
	// Has two antagonist flags, in fact
	enemy_roles = list("AI", "Cyborg", "Security Officer", "Warden", "Detective", "Head of Security", "Captain")
	required_enemies = list(3,3,2,2,2,2,2,2,2,0)
	required_candidates = 2
	weight = 3
	cost = 10
	requirements = list(101,101,101,101,40,30,30,30,30,30)
	blocking_rules = list(/datum/dynamic_ruleset/roundstart/nuclear,/datum/dynamic_ruleset/midround/from_ghosts/nuclear)
	high_population_requirement = 15
	var/datum/team/abductor_team/team
	//property_weights = list("extended" = -2, "valid" = 1, "trust" = -1, "chaos" = 2)
	repeatable_weight_decrease = 4
	repeatable = TRUE
	chaos_min = 4.0

/datum/dynamic_ruleset/midround/from_ghosts/abductors/ready(forced = FALSE)
	team = new /datum/team/abductor_team
	if(team.team_number > ABDUCTOR_MAX_TEAMS)
		return FALSE
	return ..()

/datum/dynamic_ruleset/midround/from_ghosts/abductors/finish_setup(mob/new_character, index)
	switch(index)
		if(1) // yeah this seems like a baffling anti-pattern but it's actually the best way to do this, shit you not
			var/mob/living/carbon/human/agent = new_character
			agent.mind.add_antag_datum(/datum/antagonist/abductor/agent, team)
			log_game("[key_name(agent)] has been selected as [team.name] abductor agent.")
		if(2)
			var/mob/living/carbon/human/scientist = new_character
			scientist.mind.add_antag_datum(/datum/antagonist/abductor/scientist, team)
			log_game("[key_name(scientist)] has been selected as [team.name] abductor scientist.")


//////////////////////////////////////////////
//                                          //
//              SPACE NINJA                 //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/midround/from_ghosts/ninja
	name = "Space Ninja"
	//config_tag = "ninja"
	antag_flag = ROLE_NINJA
	enemy_roles = list("Security Officer", "Warden", "Head of Security", "Captain")
	required_enemies = list(3,3,2,2,2,2,1,1,1,0)
	required_candidates = 1
	weight = 4
	cost = 10
	requirements = list(101,101,101,40,35,30,25,20,20,20)
	high_population_requirement = 30
	//property_weights = list("story_potential" = 1, "extended" = -2, "valid" = 2)
	var/list/spawn_locs = list()
	var/spawn_loc
	chaos_min = 3.0

/datum/dynamic_ruleset/midround/from_ghosts/ninja/ready(forced = FALSE)
	if(!spawn_loc)
		var/list/spawn_locs = list()
		for(var/obj/effect/landmark/carpspawn/L in GLOB.landmarks_list)
			if(isturf(L.loc))
				spawn_locs += L.loc
		/* This part breaks. I guess we don't have this landmark.
		for(var/obj/effect/landmark/loneopspawn/L in GLOB.landmarks_list)
			if(isturf(L.loc))
				spawn_locs += L.loc
		*/
		if(!spawn_locs.len)
			return FALSE
		spawn_loc = pick(spawn_locs)
	if(!spawn_loc)
		return FALSE
	return ..()

/datum/dynamic_ruleset/midround/from_ghosts/ninja/generate_ruleset_body(mob/applicant)
	var/key = applicant.key

	//Prepare ninja player mind
	var/datum/mind/Mind = new /datum/mind(key)
	Mind.assigned_role = ROLE_NINJA
	Mind.special_role = ROLE_NINJA
	Mind.active = 1

	//spawn the ninja and assign the candidate
	var/mob/living/carbon/human/Ninja = create_space_ninja(spawn_loc)
	Mind.transfer_to(Ninja)
	var/datum/antagonist/ninja/ninjadatum = new
	ninjadatum.helping_station = pick(TRUE,FALSE)
	Mind.add_antag_datum(ninjadatum)

	if(Ninja.mind != Mind)			//something has gone wrong!
		stack_trace("Ninja created with incorrect mind")

	message_admins("[ADMIN_LOOKUPFLW(Ninja)] has been made into a ninja by dynamic.")
	log_game("[key_name(Ninja)] was spawned as a ninja by dynamic.")
	return Ninja

/datum/dynamic_ruleset/midround/from_ghosts/ninja/finish_setup(mob/new_character, index)
	return




#undef ABDUCTOR_MAX_TEAMS
#undef REVENANT_SPAWN_THRESHOLD


//////////////////////////////////////////////
//                                          //
//               BLOODSUCKERS               //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/midround/bloodsucker
  name = "Bloodsucker Infiltrator"
  //config_tag = "latejoin_bloodsucker"
  antag_datum = ANTAG_DATUM_BLOODSUCKER
  antag_flag = ROLE_TRAITOR
  restricted_roles = list("AI", "Cyborg")
  protected_roles = list("Rookie", "Security Officer", "Warden", "Detective", "Head of Security", "Captain", "Head of Personnel", "Chief Engineer", "Chief Medical Officer", "Research Director", "Quartermaster")
  required_candidates = 1
  enemy_roles = list("Security Officer","Head of Security","Captain","AI","Cyborg","Chaplain","Curator")
  required_enemies = list(3,2,2,2,2,2,2,2,2,2)
  weight = 3
  cost = 10
  requirements = list(101,101,101,60,55,50,45,40,35,30)
  high_population_requirement = 30
  repeatable = FALSE
  chaos_min = 4.0

datum/dynamic_ruleset/midround/bloodsucker/trim_candidates()
	..()
	for(var/mob/living/player in living_players)
		if(issilicon(player)) // Your assigned role doesn't change when you are turned into a silicon.
			living_players -= player
			continue
		if(is_centcom_level(player.z))
			living_players -= player // We don't autotator people in CentCom
			continue
		if(player.mind && (player.mind.special_role || player.mind.antag_datums?.len > 0))
			living_players -= player // We don't autotator people with roles already

/datum/dynamic_ruleset/midround/bloodsucker/ready(forced = FALSE)
	if (required_candidates > living_players.len)
		return FALSE
	return ..()

/datum/dynamic_ruleset/midround/bloodsucker/execute()
	var/mob/M = pick(living_players)
	assigned += M
	living_players -= M
	var/datum/antagonist/bloodsucker/newVamp = new
	M.mind.add_antag_datum(newVamp)
	return TRUE
