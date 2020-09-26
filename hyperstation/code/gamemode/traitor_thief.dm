//Jay Sparrow
//A less murder traitor for low chaos dynamic rounds.

/datum/game_mode/traitor/thief
	name = "thief traitor"
	config_tag = "thief traitor"
	antag_flag = ROLE_TRAITOR
	false_report_weight = 20 //Reports of traitors are pretty common.
	restricted_jobs = list("AI","Cyborg")
	protected_jobs = list("Security Officer", "Warden", "Detective", "Head of Security", "Captain", "Head of Personnel", "Chief Engineer", "Chief Medical Officer", "Research Director", "Quartermaster")
	required_players = 0
	required_enemies = 0

	announce_span = "danger"
	announce_text = "There are enemy agents on the station!\n\
	<span class='danger'>Traitors</span>: Accomplish your objectives.\n\
	<span class='notice'>Crew</span>: Do not let the traitors succeed!"

	traitors_possible = 3 //hard limit on traitors if scaling is turned off //Let it be high for now. Testing phase.
	num_modifier = 0 // Used for gamemodes, that are a child of traitor, that need more than the usual.
	antag_datum = /datum/antagonist/traitor/thief //what type of antag to create

/datum/antagonist/traitor/thief
	name = "Thief Traitor"
	roundend_category = "traitors"
	antagpanel_category = "Traitor"
	job_rank = ROLE_TRAITOR
	antag_moodlet = /datum/mood_event/focused //No special moodlet yet
	special_role = ROLE_TRAITOR
	employer = "The Syndicate"
	give_objectives = TRUE
	should_give_codewords = TRUE
	should_equip = TRUE
	traitor_kind = TRAITOR_HUMAN //Set on initial assignment
	can_hijack = HIJACK_NEUTRAL


/datum/game_mode/traitor/thief/generate_report()
	return "Although more specific threats are commonplace, you should always remain vigilant for Syndicate agents aboard your station. Syndicate communications have implied that many \
		Nanotrasen employees are Syndicate agents with hidden memories that may be activated at a moment's notice, so it's possible that these agents might not even know their positions."

/datum/mind/proc/make_ThiefTraitor()
	if(!(has_antag_datum(/datum/antagonist/traitor/thief)))
		add_antag_datum(/datum/antagonist/traitor/thief)


/datum/antagonist/traitor/thief/proc/forge_objectives()
	forge_single_objective()
	forge_single_objective()
	var/datum/objective/escape/escape_objective = new
	escape_objective.owner = owner
	add_objective(escape_objective)


/datum/antagonist/traitor/thief/forge_human_objectives()
	forge_single_objective()
	forge_single_objective()
	var/datum/objective/escape/escape_objective = new
	escape_objective.owner = owner
	add_objective(escape_objective)

/datum/antagonist/traitor/thief/forge_single_objective()
	if(prob(15) && !(locate(/datum/objective/download) in owner.objectives) && !(owner.assigned_role in list("Research Director", "Scientist", "Roboticist")))
		var/datum/objective/download/download_objective = new
		download_objective.owner = owner
		download_objective.gen_amount_goal()
		add_objective(download_objective)
	else
		var/datum/objective/steal/steal_objective = new
		steal_objective.owner = owner
		steal_objective.find_target()
		add_objective(steal_objective)
	return

/datum/antagonist/traitor/thief/greet()
	to_chat(owner.current, "<span class='userlove'>You are the [owner.special_role].</span>")
	owner.announce_objectives()
	if(should_give_codewords)
		give_codewords()

/datum/antagonist/traitor/thief/on_gain()
	if(owner.current && isAI(owner.current))
		traitor_kind = TRAITOR_AI

	SSticker.mode.traitors += owner
	owner.special_role = special_role
	if(give_objectives)
		forge_objectives()
	finalize_traitor()
