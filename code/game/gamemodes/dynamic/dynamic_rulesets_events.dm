/datum/dynamic_ruleset/event
	ruletype = "Event"
	var/typepath // typepath of the event
	var/triggering
	var/earliest_start = 20 MINUTES
	var/occurances_current = 0 //Don't touch this. Skyrat Change.
	var/occurances_max = 0 //Maximum occurances for this event. Set to 0 to allow an infinite amount of this event. Skyrat change.

/datum/dynamic_ruleset/event/acceptable(population=0, threat=0)
	if(GLOB.wizardstart.len == 0)
		log_admin("Cannot accept Wizard ruleset. Couldn't find any wizard spawn points.")
		message_admins("Cannot accept Wizard ruleset. Couldn't find any wizard spawn points.")
		return FALSE
	return ..()

/datum/dynamic_ruleset/event/ready(forced = 0)
	if (!forced)
		var/job_check = 0
		if (enemy_roles.len > 0)
			for (var/mob/M in mode.current_players[CURRENT_LIVING_PLAYERS])
				if (M.stat == DEAD)
					continue // Dead players cannot count as opponents
				if (M.mind && M.mind.assigned_role && (M.mind.assigned_role in enemy_roles) && (!(M in candidates) || (M.mind.assigned_role in restricted_roles)))
					job_check++ // Checking for "enemies" (such as sec officers). To be counters, they must either not be candidates to that rule, or have a job that restricts them from it

		var/threat = round(mode.threat_level/10)
		if (job_check < required_enemies[threat])
			return FALSE
	return ..()

/datum/dynamic_ruleset/event/execute()
	var/datum/round_event/E = new typepath()
	E.current_players = get_active_player_count(alive_check = 1, afk_check = 1, human_check = 1)
	//E.control = src
	SSblackbox.record_feedback("tally", "event_ran", 1, "[E]")
	occurances_current++

	testing("[time2text(world.time, "hh:mm:ss")] [E.type]")
	deadchat_broadcast("<span class='deadsay'><b>[name]</b> has just been randomly triggered!</span>") //STOP ASSUMING IT'S BADMINS!
	log_game("Random Event triggering: [name] ([typepath])")

	return E

//////////////////////////////////////////////
//                                          //
//               PIRATES                    //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/event/pirates
	name = "Space Pirates"
	//config_tag = "pirates"
	typepath = /datum/round_event/pirates
	antag_flag = ROLE_TRAITOR
	enemy_roles = list("AI","Security Officer","Head of Security","Captain")
	required_enemies = list(2,2,1,1,0,0,0,0,0,0)
	weight = 5
	cost = 10
	earliest_start = 50 MINUTES
	blocking_rules = list(/datum/dynamic_ruleset/roundstart/nuclear,/datum/dynamic_ruleset/midround/from_ghosts/nuclear)
	requirements = list(70,60,50,50,40,40,40,30,20,15)
	//property_weights = list("story_potential" = 1, "trust" = 1, "chaos" = 1)
	high_population_requirement = 15
	occurances_max = 1
	chaos_min = 2.0

/datum/dynamic_ruleset/event/pirates/ready(forced = FALSE)
	if (!SSmapping.empty_space)
		return FALSE
	return ..()

//////////////////////////////////////////////
//                                          //
//               SPIDERS                    //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/event/spiders
	name = "Spider Infestation"
	//config_tag = "spiders"
	typepath = /datum/round_event/spider_infestation
	enemy_roles = list("AI","Security Officer","Head of Security","Captain")
	required_enemies = list(2,2,1,1,0,0,0,0,0,0)
	weight = 5
	cost = 10
	requirements = list(70,60,50,50,40,40,40,30,20,15)
	high_population_requirement = 15
	//property_weights = list("chaos" = 1, "valid" = 1)
	earliest_start = 30 MINUTES //Skyrat change.
	occurances_max = 2
	chaos_min = 1.5

//////////////////////////////////////////////
//                                          //
//              CLOGGED VENTS               //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/event/ventclog
	name = "Clogged Vents"
	//config_tag = "ventclog"
	typepath = /datum/round_event/vent_clog
	enemy_roles = list("Chemist","Medical Doctor","Chief Medical Officer")
	required_enemies = list(1,1,1,0,0,0,0,0,0,0)
	cost = 2
	weight = 4
	repeatable_weight_decrease = 3
	requirements = list(10,10,10,5,5,5,5,5,5,5) // yes, can happen on fake-extended
	high_population_requirement = 5
	repeatable = TRUE
	//property_weights = list("chaos" = 1, "extended" = 2)
	occurances_max = 2
	chaos_min = 1.5

/datum/dynamic_ruleset/event/ventclog/ready()
	if(mode.threat_level > 30 && mode.threat >= 5 && prob(20))
		name = "Clogged Vents: Threatening"
		cost = 10
		required_enemies = list(3,3,3,2,2,2,1,1,1,1)
		typepath = /datum/round_event/vent_clog/threatening
	else if(mode.threat_level > 15 && mode.threat > 15 && prob(30))
		name = "Clogged Vents: Catastrophic"
		cost = 15
		required_enemies = list(2,2,1,1,1,1,0,0,0,0)
		typepath = /datum/round_event/vent_clog/catastrophic
	else
		cost = 5
		name = "Clogged Vents: Normal"
		required_enemies = list(1,1,1,0,0,0,0,0,0,0)
		typepath = /datum/round_event/vent_clog
	return ..()

//////////////////////////////////////////////
//                                          //
//               ION STORM                  //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/event/ion_storm
	name = "Ion Storm"
	//config_tag = "ion_storm"
	typepath = /datum/round_event/ion_storm
	enemy_roles = list("Research Director","Captain","Chief Engineer")
	required_enemies = list(1,1,0,0,0,0,0,0,0,0)
	weight = 4
	// no repeatable weight decrease. too variable to be unfun multiple times in one round
	cost = 1
	requirements = list(5,5,5,5,5,5,5,5,5,5)
	high_population_requirement = 5
	repeatable = TRUE
	//property_weights = list("story_potential" = 1, "extended" = 1)
	//always_max_weight = TRUE
	occurances_max = 3
	chaos_min = 1.0

//////////////////////////////////////////////
//                                          //
//                METEORS                   //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/event/meteor_wave
	name = "Meteor Wave"
	//config_tag = "meteor_wave"
	typepath = /datum/round_event/meteor_wave
	enemy_roles = list("Chief Engineer","Station Engineer","Atmospheric Technician","Captain","Cyborg")
	required_enemies = list(2,2,2,2,2,2,2,2,2,2)
	cost = 15
	weight = 3
	earliest_start = 45 MINUTES
	repeatable_weight_decrease = 2
	requirements = list(60,50,40,30,30,30,30,30,30,30)
	high_population_requirement = 30
	//property_weights = list("extended" = -2)
	occurances_max = 2
	chaos_min = 1.5

/datum/dynamic_ruleset/event/meteor_wave/ready()
	if(world.time-SSticker.round_start_time > 35 MINUTES && mode.threat_level > 40 && mode.threat >= 25 && prob(30))
		name = "Meteor Wave: Threatening"
		cost = 25
		typepath = /datum/round_event/meteor_wave/threatening
	else if(world.time-SSticker.round_start_time > 45 MINUTES && mode.threat_level > 50 && mode.threat >= 40 && prob(30))
		name = "Meteor Wave: Catastrophic"
		cost = 40
		typepath = /datum/round_event/meteor_wave/catastrophic
		required_enemies = list(3,3,3,3,3,3,3,3,3,3)
	else
		name = "Meteor Wave: Normal"
		cost = 15
		typepath = /datum/round_event/meteor_wave
	return ..()

//////////////////////////////////////////////
//                                          //
//               ANOMALIES                  //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/event/anomaly_bluespace
	name = "Anomaly: Bluespace"
	//config_tag = "anomaly_bluespace"
	typepath = /datum/round_event/anomaly/anomaly_bluespace
	enemy_roles = list("Chief Engineer","Station Engineer","Atmospheric Technician","Research Director","Scientist","Captain")
	required_enemies = list(1,1,1,0,0,0,0,0,0,0)
	weight = 2
	earliest_start = 20 MINUTES
	repeatable_weight_decrease = 1
	cost = 3
	requirements = list(5,5,5,5,5,5,5,5,5,5)
	high_population_requirement = 5
	repeatable = TRUE
	//property_weights = list("extended" = 1)
	occurances_max = 3
	chaos_min = 1.5

/datum/dynamic_ruleset/event/anomaly_flux
	name = "Anomaly: Hyper-Energetic Flux"
	//config_tag = "anomaly_flux"
	typepath = /datum/round_event/anomaly/anomaly_flux
	enemy_roles = list("Chief Engineer","Station Engineer","Atmospheric Technician","Research Director","Scientist","Captain")
	required_enemies = list(1,1,1,0,0,0,0,0,0,0)
	weight = 2
	earliest_start = 20 MINUTES
	repeatable_weight_decrease = 1
	cost = 5
	requirements = list(5,5,5,5,5,5,5,5,5,5)
	high_population_requirement = 10
	repeatable = TRUE
	//property_weights = list("extended" = 1)
	occurances_max = 2
	chaos_min = 1.5

/datum/dynamic_ruleset/event/anomaly_gravitational
	name = "Anomaly: Gravitational"
	//config_tag = "anomaly_gravitational"
	typepath = /datum/round_event/anomaly/anomaly_grav
	weight = 2
	repeatable_weight_decrease = 1
	cost = 3
	requirements = list(5,5,5,5,5,5,5,5,5,5)
	high_population_requirement = 5
	repeatable = TRUE
	//property_weights = list("extended" = 1)
	occurances_max = 3
	chaos_min = 0.5

/datum/dynamic_ruleset/event/anomaly_pyroclastic
	name = "Anomaly: Pyroclastic"
	//config_tag = "anomaly_pyroclastic"
	typepath = /datum/round_event/anomaly/anomaly_pyro
	weight = 2
	earliest_start = 20 MINUTES
	repeatable_weight_decrease = 1
	cost = 5
	enemy_roles = list("Chief Engineer","Station Engineer","Atmospheric Technician","Research Director","Scientist","Captain","Cyborg")
	required_enemies = list(1,1,1,1,1,1,1,1,1,1)
	requirements = list(10,10,10,10,10,10,10,10,10,10)
	high_population_requirement = 10
	repeatable = TRUE
	//property_weights = list("extended" = 1)
	occurances_max = 2
	chaos_min = 1.5

/datum/dynamic_ruleset/event/anomaly_vortex
	name = "Anomaly: Vortex"
	//config_tag = "anomaly_vortex"
	typepath = /datum/round_event/anomaly/anomaly_vortex
	weight = 2
	earliest_start = 30 MINUTES
	repeatable_weight_decrease = 1
	cost = 5
	enemy_roles = list("Chief Engineer","Station Engineer","Atmospheric Technician","Research Director","Scientist","Captain","Cyborg")
	required_enemies = list(1,1,1,1,1,1,1,1,1,1)
	requirements = list(10,10,10,10,10,10,10,10,10,10)
	high_population_requirement = 10
	repeatable = TRUE
	//property_weights = list("extended" = 1)
	occurances_max = 2
	chaos_min = 2.0

//////////////////////////////////////////////
//                                          //
//            LONE  OPERATIVE               //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/event/operative
	name = "Lone Operative"
	typepath = /datum/round_event/ghost_role/operative
	weight = 0 //This is changed in nuclearbomb.dm
	occurances_max = 1
	requirements = list(20,20,20,20,20,20,20,20,20,20) //SECURE THAT DISK
	cost = 50

/datum/dynamic_ruleset/event/operative/ready()
	var/datum/round_event_control/operative/loneop = locate(/datum/round_event_control/operative) in SSevents.control
	if(istype(loneop))
		weight = loneop.weight //Get the weight whenever it's called.

//////////////////////////////////////////////
//                                          //
//        WOW THAT'S A LOT OF EVENTS        //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/event/brand_intelligence
	name = "Brand Intelligence"
	//config_tag = "brand_intelligence"
	typepath = /datum/round_event/brand_intelligence
	weight = 1
	earliest_start = 30 MINUTES
	repeatable_weight_decrease = 1
	cost = 10
	enemy_roles = list("Chief Engineer","Station Engineer","Atmospheric Technician","Research Director","Scientist","Captain","Cyborg")
	required_enemies = list(1,1,1,1,0,0,0,0,0,0)
	requirements = list(50,40,30,25,20,15,10,10,10,10)
	high_population_requirement = 10
	repeatable = TRUE
	//property_weights = list("extended" = -1, "chaos" = 1)
	occurances_max = 1
	chaos_min = 2.0

/datum/dynamic_ruleset/event/carp_migration
	name = "Carp Migration"
	//config_tag = "carp_migration"
	typepath = /datum/round_event/carp_migration
	weight = 7
	repeatable_weight_decrease = 3
	cost = 4
	requirements = list(101,20,15,10,10,10,10,10,10,10)
	high_population_requirement = 10
	earliest_start = 10 MINUTES
	repeatable = TRUE
	//property_weights = list("extended" = 1)
	occurances_max = 3
	chaos_min = 0.5

/datum/dynamic_ruleset/event/communications_blackout
	name = "Communications Blackout"
	//config_tag = "communications_blackout"
	typepath = /datum/round_event/communications_blackout
	cost = 4
	weight = 10
	repeatable_weight_decrease = 2
	enemy_roles = list("Chief Engineer","Station Engineer")
	required_enemies = list(1,1,1,0,0,0,0,0,0,0)
	requirements = list(5,5,5,10,10,10,10,15,15,15)
	high_population_requirement = 5
	repeatable = TRUE
	//property_weights = list("extended" = 1, "chaos" = 1)
	occurances_max = 5

/datum/dynamic_ruleset/event/processor_overload
	name = "Processor Overload"
	//config_tag = "processor_overload"
	typepath = /datum/round_event/processor_overload
	cost = 4
	weight = 2
	repeatable_weight_decrease = 3
	enemy_roles = list("Chief Engineer","Station Engineer")
	required_enemies = list(1,1,1,1,1,1,1,1,1,1)
	requirements = list(101,101,10,10,10,15,15,15,15,15)
	high_population_requirement = 5
	repeatable = TRUE
	//property_weights = list("extended" = 1, "chaos" = 1)
	//always_max_weight = TRUE
	occurances_max = 2

/datum/dynamic_ruleset/event/space_dust
	name = "Minor Space Dust"
	//config_tag = "space_dust"
	typepath = /datum/round_event/space_dust
	cost = 2
	weight = 10
	repeatable_weight_decrease = 2
	enemy_roles = list("Chief Engineer","Station Engineer")
	required_enemies = list(1,1,1,0,0,0,0,0,0,0)
	requirements = list(5,5,5,5,5,5,5,5,5,5)
	high_population_requirement = 5
	repeatable = TRUE
	earliest_start = 0 MINUTES
	//property_weights = list("extended" = 1)
	//always_max_weight = TRUE
	occurances_max = 0

/datum/dynamic_ruleset/event/major_dust
	name = "Major Space Dust"
	//config_tag = "major_dust"
	typepath = /datum/round_event/meteor_wave/major_dust
	cost = 5
	weight = 2
	repeatable_weight_decrease = 1
	enemy_roles = list("Chief Engineer","Station Engineer")
	required_enemies = list(2,2,2,2,2,2,2,2,2,2)
	requirements = list(20,15,15,10,10,10,10,10,10,10)
	high_population_requirement = 10
	repeatable = TRUE
	//property_weights = list("extended" = 1)
	occurances_max = 3

/datum/dynamic_ruleset/event/electrical_storm
	name = "Electrical Storm"
	typepath = /datum/round_event/electrical_storm
	cost = 1
	weight = 20
	repeatable_weight_decrease = 2
	enemy_roles = list("Chief Engineer","Station Engineer")
	required_enemies = list(1,1,1,0,0,0,0,0,0,0)
	requirements = list(5,5,5,5,5,5,5,5,5,5)
	high_population_requirement = 5
	repeatable = TRUE
	occurances_max = 10

/datum/dynamic_ruleset/event/heart_attack
	name = "Random Heart Attack"
	typepath = /datum/round_event/heart_attack
	cost = 15
	weight = 2
	earliest_start = 30 MINUTES
	repeatable_weight_decrease = 1
	enemy_roles = list("Medical Doctor","Chief Medical Officer")
	required_enemies = list(2,2,2,2,2,2,2,2,2,2)
	requirements = list(101,101,101,5,5,5,5,5,5,5)
	high_population_requirement = 5
	repeatable = TRUE
	occurances_max = 2

/datum/dynamic_ruleset/event/radiation_storm
	name = "Radiation Storm"
	//config_tag = "radiation_storm"
	typepath = /datum/round_event/radiation_storm
	cost = 3
	weight = 3
	enemy_roles = list("Chemist","Chief Medical Officer","Geneticist","Medical Doctor","AI","Captain")
	required_enemies = list(1,1,1,1,1,1,1,1,1,1)
	requirements = list(5,5,5,5,5,5,5,5,5,5)
	high_population_requirement = 5
	//property_weights = list("extended" = 1,"chaos" = 1)
	occurances_max = 2

/datum/dynamic_ruleset/event/portal_storm_syndicate
	name = "Portal Storm"
	//config_tag = "portal_storm"
	typepath = /datum/round_event/portal_storm/syndicate_shocktroop
	cost = 10
	weight = 1
	enemy_roles = list("Head of Security","Security Officer","AI","Captain","Shaft Miner")
	required_enemies = list(2,2,2,2,2,2,2,2,2,2)
	requirements = list(101,101,101,30,30,30,30,30,30,30)
	high_population_requirement =  30
	earliest_start = 40 MINUTES
	//property_weights = list("teamwork" = 1,"chaos" = 1, "extended" = -1)
	occurances_max = 1
	chaos_min = 1.0


/datum/dynamic_ruleset/event/wormholes
	name = "Wormholes"
	//config_tag = "wormhole"
	typepath = /datum/round_event/wormholes
	cost = 3
	weight = 4
	enemy_roles = list("AI","Medical Doctor","Station Engineer","Head of Personnel","Captain")
	required_enemies = list(2,2,2,2,2,2,2,2,2,2)
	requirements = list(5,5,5,5,5,5,5,5,5,5)
	high_population_requirement =  5
	//property_weights = list("extended" = 1)
	occurances_max = 2
	chaos_min = 1.0

/datum/dynamic_ruleset/event/swarmers
	name = "Swarmers"
	//config_tag = "swarmer"
	typepath = /datum/round_event/spawn_swarmer
	cost = 10
	weight = 1
	earliest_start = 40 MINUTES
	enemy_roles = list("AI","Security Officer","Head of Security","Captain","Station Engineer","Atmos Technician","Chief Engineer")
	required_enemies = list(4,4,4,4,3,3,3,3,3,3)
	requirements = list(101,101,101,101,50,45,40,35,30,30)
	high_population_requirement =  5
	//property_weights = list("extended" = -2)
	occurances_max = 1
	chaos_min = 2.0

/datum/dynamic_ruleset/event/sentient_disease
	name = "Sentient Disease"
	//config_tag = "sentient_disease"
	typepath = /datum/round_event/ghost_role/sentient_disease
	enemy_roles = list("Virologist","Chief Medical Officer","Captain","Chemist")
	required_enemies = list(2,1,1,1,0,0,0,0,0,0)
	required_candidates = 1
	weight = 4
	cost = 5
	requirements = list(30,30,20,20,15,10,10,10,10,5) // yes, it can even happen in "extended"!
	//property_weights = list("story_potential" = 1, "extended" = 1, "valid" = -2)
	high_population_requirement = 5
	occurances_max = 1
	chaos_min = 1.5

/datum/dynamic_ruleset/event/revenant
	name = "Revenant"
	//config_tag = "revenant"
	typepath = /datum/round_event/ghost_role/revenant
	enemy_roles = list("Chief Engineer","Station Engineer","Captain","Chaplain","AI")
	required_enemies = list(2,1,1,1,0,0,0,0,0,0)
	required_candidates = 1
	weight = 3
	cost = 5
	requirements = list(101,40,35,30,20,15,15,15,15,15)
	high_population_requirement = 15
	//property_weights = list("story_potential" = -2, "extended" = -1)
	occurances_max = 1 //Skyrat change.
	chaos_min = 1.5

/datum/dynamic_ruleset/event/immovable_rod
	name = "Immovable Rod"
	typepath = /datum/round_event/immovable_rod
	enemy_roles = list("Research Director","Chief Engineer","Station Engineer","Captain","Chaplain","AI")
	required_enemies = list(2,2,2,2,2,2,1,1,1,1)
	requirements = list(101,101,40,30,30,20,15,15,15,15)
	high_population_requirement = 15
	cost = 10
	occurances_max = 2
	weight = 4
	earliest_start = 30 MINUTES
	chaos_min = 1.5


//////////////////////////////////////////////
//                                          //
//              NEUTRAL EVENTS              //
//                                          //
//////////////////////////////////////////////


/datum/dynamic_ruleset/event/aurora_caelus  //A good omen. Drop chaos a little.
	name = "Aurora Caelus"
	typepath = /datum/round_event/aurora_caelus
	requirements = list(0,0,0,0,0,0,0,0,0,0)
	high_population_requirement = 0
	weight = 5
	cost = 10
	repeatable = TRUE
	occurances_max = 2

/datum/dynamic_ruleset/event/high_priority_bounty
	name = "High Priority Bounty"
	typepath = /datum/round_event/high_priority_bounty
	requirements = list(0,0,0,0,0,0,0,0,0,0)
	high_population_requirement = 0
	weight = 10
	repeatable = TRUE
	occurances_max = 3

/datum/dynamic_ruleset/event/bureaucratic_error
	name = "Bureaucratic Error"
	requirements = list(0,0,0,0,0,0,0,0,0,0)
	high_population_requirement = 0
	typepath = /datum/round_event/bureaucratic_error
	occurances_max = 1
	weight = 5

/datum/dynamic_ruleset/event/camera_failure
	name = "Camera Failure"
	typepath = /datum/round_event/camera_failure
	requirements = list(0,0,0,0,0,0,0,0,0,0)
	high_population_requirement = 0
	weight = 100
	repeatable = TRUE
	occurances_max = 20

/datum/dynamic_ruleset/event/disease_outbreak
	name = "Disease Outbreak"
	enemy_roles = list("Virologist","Chief Medical Officer","Captain","Chemist")
	required_enemies = list(2,1,1,1,0,0,0,0,0,0)
	typepath = /datum/round_event/disease_outbreak
	requirements = list(10,10,10,5,5,5,5,5,5,5)
	high_population_requirement = 5
	weight = 5
	cost = 5
	repeatable = TRUE
	occurances_max = 1

/datum/dynamic_ruleset/event/falsealarm
	name = "False Alarm"
	typepath = /datum/round_event/falsealarm
	requirements = list(0,0,0,0,0,0,0,0,0,0)
	high_population_requirement = 0
	weight = 20
	repeatable = TRUE
	occurances_max = 5

/datum/dynamic_ruleset/event/grid_check
	name = "Grid Check"
	typepath = /datum/round_event/grid_check
	requirements = list(5,5,5,5,5,5,0,0,0,0) //Can actually cause problems
	high_population_requirement = 0
	weight = 5
	repeatable = TRUE
	occurances_max = 2

/datum/dynamic_ruleset/event/mass_hallucination
	name = "Mass Hallucination"
	typepath = /datum/round_event/mass_hallucination
	requirements = list(0,0,0,0,0,0,0,0,0,0)
	high_population_requirement = 0
	weight = 4
	repeatable = TRUE
	occurances_max = 2

/datum/dynamic_ruleset/event/mice_migration
	name = "Mice Migration"
	typepath = /datum/round_event/mice_migration
	enemy_roles = list("Chief Engineer","Station Engineer","Captain","Cook","Atmospheric Technician")
	required_enemies = list(1,1,1,1,1,0,0,0,0,0)
	requirements = list(10,5,5,5,0,0,0,0,0,0)
	high_population_requirement = 0
	weight = 10
	repeatable = TRUE
	occurances_max = 3

/datum/dynamic_ruleset/event/grey_tide
	name = "Grey Tide"
	typepath = /datum/round_event/grey_tide
	enemy_roles = list("Chief Engineer","Station Engineer","Captain","Atmospheric Technician","AI","Cyborg")
	required_enemies = list(3,2,2,2,2,2,1,1,1,1)
	requirements = list(101,20,15,15,10,10,5,5,5,5)
	high_population_requirement = 0
	repeatable = TRUE
	weight = 5
	occurances_max = 2

/datum/dynamic_ruleset/event/sentience
	name = "Random Human-level Intelligence"
	typepath = /datum/round_event/ghost_role/sentience
	requirements = list(0,0,0,0,0,0,0,0,0,0)
	high_population_requirement = 0
	weight = 10

/datum/dynamic_ruleset/event/shuttle_loan
	name = "Shuttle Loan"
	typepath = /datum/round_event/shuttle_loan
	enemy_roles = list("Quartermaster","Cargo Technician")
	required_enemies = list(1,1,1,1,1,1,1,1,1,1)
	requirements = list(10,10,10,5,5,5,0,0,0,0)
	high_population_requirement = 0
	weight = 10
	repeatable = TRUE
	occurances_max = 2

/datum/dynamic_ruleset/event/spacevine
	name = "Spacevine"
	typepath = /datum/round_event/spacevine
	enemy_roles = list("Cook","Botanist","Security Officer","Captain","Station Engineer")
	required_enemies = list(2,2,2,1,1,1,1,1,1,1)
	requirements = list(101,30,25,20,15,15,10,10,10,10)
	high_population_requirement = 0
	weight = 8
	repeatable_weight_decrease = 5
	earliest_start = 20 MINUTES
	repeatable = TRUE
	occurances_max = 3

/datum/dynamic_ruleset/event/spontaneous_appendicitis
	name = "Spontaneous Appendicitis"
	typepath = /datum/round_event/spontaneous_appendicitis
	enemy_roles = list("Medical Doctor","Chief Medical Officer")
	required_enemies = list(2,2,1,1,1,1,1,1,1,1)
	requirements = list(15,10,10,5,5,5,5,5,5,5)
	high_population_requirement = 5
	weight = 12
	repeatable = TRUE
	repeatable_weight_decrease = 5
	occurances_max = 4