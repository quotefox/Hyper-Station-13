//Jay Sparrow
/datum/game_mode
	var/list/datum/mind/lewd = list()

#define ROLE_LEWD_TRAITOR			"lewd traitor"

/datum/mind/
	var/sexed = FALSE //General flag for completion check

//TODO - Move this somewhere else
GLOBAL_LIST_INIT(hyper_special_roles, list(
	ROLE_LEWD_TRAITOR = /datum/game_mode/traitor/lewd
))


/datum/game_mode/traitor/lewd
	name = "lewd traitor"
	config_tag = "lewd traitor"
	antag_flag = ROLE_LEWD_TRAITOR
	false_report_weight = 20 //Reports of traitors are pretty common.
	restricted_jobs = list("Cyborg")
	protected_jobs = list()	//Anyone can be lewd op. Even heads.
	required_players = 0
	required_enemies = 0

	announce_span = "danger"
	announce_text = "There are lewd agents on the station!\n\
	<span class='danger'>Traitors</span>: Accomplish your objectives.\n\
	<span class='notice'>Crew</span>: Do not let the traitors succeed!"

	//var/list/datum/mind/lewd
	traitors_possible = 10 //hard limit on traitors if scaling is turned off //Let it be high for now. Testing phase.
	num_modifier = 0 // Used for gamemodes, that are a child of traitor, that need more than the usual.
	antag_datum = /datum/antagonist/traitor/lewd //what type of antag to create

/datum/antagonist/traitor/lewd
	name = "Lewd Traitor"
	roundend_category = "traitors"
	antagpanel_category = "Traitor"
	job_rank = ROLE_LEWD_TRAITOR
	//antag_moodlet = /datum/mood_event/focused //No special moodlet yet
	special_role = ROLE_LEWD_TRAITOR
	employer = "An interested voyeur"
	give_objectives = TRUE
	should_give_codewords = FALSE
	should_equip = TRUE
	traitor_kind = TRAITOR_HUMAN //Set on initial assignment
	can_hijack = HIJACK_NEUTRAL

	//Custom uplink list - aaaaaaaaaaaaaa
	var/list/lewd_uplink_list = list()
	var/list/lewd_uplink_list_raw = list(
		/datum/uplink_item/bundles_TC/random,
		/datum/uplink_item/bundles_TC/telecrystal,
		/datum/uplink_item/bundles_TC/telecrystal/five,
		/datum/uplink_item/bundles_TC/telecrystal/twenty,
		/datum/uplink_item/dangerous/foamsmg,
		/datum/uplink_item/dangerous/foammachinegun,
		/datum/uplink_item/dangerous/foampistol,
		/datum/uplink_item/dangerous/phantomthief,
		/datum/uplink_item/stealthy_weapons/dart_pistol,
		/datum/uplink_item/stealthy_weapons/crossbow,
		/datum/uplink_item/stealthy_weapons/sleepy_pen,
		/datum/uplink_item/stealthy_weapons/suppressor,
		/datum/uplink_item/stealthy_weapons/soap,
		/datum/uplink_item/stealthy_weapons/soap_clusterbang,
		/datum/uplink_item/ammo/pistolzzz,
		/datum/uplink_item/ammo/shotgun/stun,
		/datum/uplink_item/ammo/toydarts,
		/datum/uplink_item/stealthy_tools/ai_detector,
		/datum/uplink_item/stealthy_tools/chameleon,
		/datum/uplink_item/stealthy_tools/chameleon_proj,
		/datum/uplink_item/stealthy_tools/emplight,
		/datum/uplink_item/stealthy_tools/syndigaloshes,
		/datum/uplink_item/stealthy_tools/jammer,
		/datum/uplink_item/stealthy_tools/smugglersatchel,
		/datum/uplink_item/device_tools/emag,
		/datum/uplink_item/device_tools/emagrecharge,
		/datum/uplink_item/device_tools/binary,
		/datum/uplink_item/device_tools/compressionkit,
		/datum/uplink_item/device_tools/briefcase_launchpad,
		/datum/uplink_item/device_tools/camera_bug,
		/datum/uplink_item/device_tools/military_belt,
		/datum/uplink_item/device_tools/frame,
		/datum/uplink_item/device_tools/toolbox,
		/datum/uplink_item/device_tools/medkit,
		/datum/uplink_item/device_tools/surgerybag,
		/datum/uplink_item/device_tools/encryptionkey,
		/datum/uplink_item/device_tools/thermal,
		/datum/uplink_item/implants/radio,
		/datum/uplink_item/implants/reviver,
		/datum/uplink_item/implants/stealthimplant,
		/datum/uplink_item/implants/thermals,
		/datum/uplink_item/implants/uplink,
		/datum/uplink_item/implants/xray,
		/datum/uplink_item/role_restricted/goldenbox,
		/datum/uplink_item/role_restricted/chemical_gun,
		/datum/uplink_item/badass/syndiecash,
		/datum/uplink_item/badass/phantomthief,
		/datum/uplink_item/badass/syndiecards,
		/datum/uplink_item/badass/syndiecigs)

/datum/game_mode/traitor/lewd/generate_report()
	return "Although more specific threats are commonplace, you should always remain vigilant for Syndicate agents aboard your station. Syndicate communications have implied that many \
		Nanotrasen employees are Syndicate agents with hidden memories that may be activated at a moment's notice, so it's possible that these agents might not even know their positions."

/datum/mind/proc/make_LewdTraitor()
	if(!(has_antag_datum(/datum/antagonist/traitor/lewd)))
		add_antag_datum(/datum/antagonist/traitor/lewd)

/datum/admins/proc/makeLewdtraitors()
	to_chat(GLOB.admins, "makeLewd_traitors called")
	var/datum/game_mode/traitor/lewd/temp = new

	//if(CONFIG_GET(flag/protect_roles_from_antagonist))
		//continue

	//if(CONFIG_GET(flag/protect_assistant_from_antagonist))
		//continue

	var/list/mob/living/carbon/human/candidates = list()
	var/mob/living/carbon/human/H = null
	var/list/mob/living/carbon/human/targets = list()
	//var/mob/living/carbon/human/T = null

	for(var/mob/living/carbon/human/applicant in GLOB.player_list)
		if(isReadytoRumble(applicant, ROLE_LEWD_TRAITOR))
			if(temp.age_check(applicant.client))
				if(!(applicant.job in temp.restricted_jobs))
					candidates += applicant

	for(var/mob/living/carbon/human/target in GLOB.player_list)
		if(target.client.prefs.noncon)
			if(!(target.job in temp.restricted_jobs))
				targets += target

	if(candidates.len)
		var/numTraitors = min(candidates.len, targets.len, 1) //This number affects the maximum number of traitors. We want 1 for right now.
		if(numTraitors == 0)
			to_chat(GLOB.admins, "No lewd traitors created. Are there any valid targets?")
			return 0
		for(var/i = 0, i<numTraitors, i++)
			H = pick(candidates)
			H.mind.make_LewdTraitor()
			candidates.Remove(H)


		return 1


	return 0

/datum/antagonist/traitor/lewd/proc/forge_objectives()
	//to_chat(world, "<span class='boldannounce'>TEST: lewd/forge_objectives() called</span>")
	forge_single_objective()

/*
/datum/antagonist/traitor/lewd/proc/forge_objectives()
	//to_chat(world, "<span class='boldannounce'>TEST: lewd/forge_objectives() called</span>")
	var/datum/mind/target = forge_single_objective()
	
	var/datum/objective/protect/protect_objective = new /datum/objective/protect
	protect_objective.owner = owner
	protect_objective.target = target
	protect_objective.explanation_text = "Protect [target.name]. Keep them safe."
	owner.objectives += protect_objective

	var/datum/objective/survive/survive_objective = new /datum/objective/survive
	survive_objective.owner = owner
	owner.objectives += survive_objective
*/

/datum/antagonist/traitor/lewd/forge_human_objectives()
	//to_chat(world, "<span class='boldannounce'>TEST: lewd/forge_human_objectives() called</span>")
	forge_single_objective()

/datum/antagonist/traitor/lewd/forge_single_objective()
	//to_chat(world, "<span class='boldannounce'>TEST: lewd/forge_single_objective() called</span>")
	var/datum/objective/noncon/noncon_objective = new
	noncon_objective.owner = owner
	noncon_objective.target = noncon_objective.find_target()
	add_objective(noncon_objective)
	return

/datum/antagonist/traitor/lewd/greet()
	to_chat(owner.current, "<span class='userlove'>You are the [owner.special_role].</span>")
	owner.announce_objectives()
	if(should_give_codewords)
		give_codewords()

/datum/antagonist/traitor/lewd/on_gain()
	//to_chat(world, "<span class='boldannounce'>TEST: lewd/on_gain() called</span>")
	if(owner.current && isAI(owner.current))
		traitor_kind = TRAITOR_AI

	SSticker.mode.traitors += owner
	owner.special_role = special_role
	if(give_objectives)
		forge_objectives()
	finalize_traitor()

/datum/antagonist/traitor/lewd/finalize_traitor()
	//to_chat(world, "<span class='boldannounce'>TEST: lewd/finalize_traitor() called</span>")
	switch(traitor_kind)
		if(TRAITOR_AI)
			add_law_zero()
			owner.current.playsound_local(get_turf(owner.current), 'sound/ambience/antag/malf.ogg', 100, FALSE, pressure_affected = FALSE)
			owner.current.grant_language(/datum/language/codespeak)
		if(TRAITOR_HUMAN)
			if(should_equip)
				equip(silent)
				for(var/obj/I in owner.current.GetAllContents())
					GET_COMPONENT_FROM(hidden_uplink, /datum/component/uplink, I)
					if(hidden_uplink)
						lewd_uplink_list = get_custom_uplink_items(lewd_uplink_list_raw, /datum/game_mode/traitor/lewd, TRUE, FALSE)
						hidden_uplink.uplink_items = lewd_uplink_list
						hidden_uplink.telecrystals = 12


			owner.current.playsound_local(get_turf(owner.current), 'sound/ambience/antag/tatoralert.ogg', 100, FALSE, pressure_affected = FALSE)
	greet()

/datum/objective/noncon
	..()
	//var/target_flag=0
	//var/mob/living/targets = list()
	
	/* //This code can't go here, for the life of me I cannot tell you why
	for(var/mob/living/carbon/human/potential_target in GLOB.player_list)
		if(potential_target.client.prefs.noncon)
			//if(!(potential_target.job in potential_target.restricted_jobs))
			targets += potential_target
	if(targets.len)
		target = pick(targets)
	else
		target = null
	*/

/datum/objective/noncon/New(var/datum/mind/_owner)
	GLOB.objectives += src // CITADEL EDIT FOR CRYOPODS
	//to_chat(world, "<span class='boldannounce'>TEST: noncon/New() called</span>")
	
	if(_owner)
		owner = _owner
	//if(text)
		//explanation_text = text



/datum/objective/noncon/find_target()
	//..()
	//to_chat(world, "<span class='boldannounce'>TEST: noncon/find_target() called</span>")
	var/list/datum/mind/targets = list()
	var/list/datum/mind/owners = get_owners()
	//var/mob/living/carbon/human/T = null
	//for(var/mob/living/carbon/human/candidate in GLOB.player_list)
	//for(var/datum/mind/possible_target in get_crewmember_minds())
	//to_chat(world, "<span class='boldannounce'>[owner.name]</span>")
	for(var/datum/mind/candidate in SSticker.minds)
		if (!(candidate in owners) && ishuman(candidate.current))
			if(candidate.current.client.prefs.noncon == 1)
				targets += candidate
	if(targets.len > 0)
		target = pick(targets)
	else
		target = null
	update_explanation_text()
	return target


/datum/objective/noncon/check_completion()
	if(!target)
		return TRUE
	else
		return target.sexed

/datum/objective/noncon/update_explanation_text()
	if(target)
		explanation_text = "Locate [target.name], and sate your lust."
	else
		explanation_text = "Free Lewd Objective"

/datum/antagonist/traitor/lewd/roundend_report()
	var/list/result = list()

	var/traitorwin = TRUE

	result += printplayer(owner)

	var/TC_uses = 0
	var/uplink_true = FALSE
	var/purchases = ""
	LAZYINITLIST(GLOB.uplink_purchase_logs_by_key)
	var/datum/uplink_purchase_log/H = GLOB.uplink_purchase_logs_by_key[owner.key]
	if(H)
		TC_uses = H.total_spent
		uplink_true = TRUE
		purchases += H.generate_render(FALSE)

	var/objectives_text = ""
	if(objectives.len)//If the traitor had no objectives, don't need to process this.
		var/count = 1
		for(var/datum/objective/objective in objectives)
			if(objective.check_completion())
				objectives_text += "<br><B>Objective #[count]</B>: [objective.explanation_text] <span class='greentext'>Success!</span>"
			else
				objectives_text += "<br><B>Objective #[count]</B>: [objective.explanation_text] <span class='redtext'>Fail.</span>"
				traitorwin = FALSE
			count++

	if(uplink_true)
		var/uplink_text = "(used [TC_uses] TC) [purchases]"
		if(TC_uses==0 && traitorwin)
			var/static/icon/badass = icon('icons/badass.dmi', "badass")
			uplink_text += "<BIG>[icon2html(badass, world)]</BIG>"
		result += uplink_text

	result += objectives_text

	var/special_role_text = lowertext(name)

	if(traitorwin)
		result += "<span class='greentext'>The [special_role_text] was successful!</span>"
	else
		result += "<span class='redtext'>The [special_role_text] has failed!</span>"
		SEND_SOUND(owner.current, 'sound/ambience/ambifailure.ogg')

	return result.Join("<br>")


/proc/get_custom_uplink_items(var/list/custom_uplink_list = null, var/datum/game_mode/gamemode = null, allow_sales = TRUE, allow_restricted = TRUE)
	var/list/filtered_uplink_items = list()
	var/list/sale_items = list()

	if(!custom_uplink_list)
		for(var/path in GLOB.uplink_items)
			custom_uplink_list += new path
	for(var/path in  custom_uplink_list)
		var/datum/uplink_item/I = new path
		if(!I.item)
			continue
		if(I.include_modes.len)
			if(!gamemode && SSticker.mode && !(SSticker.mode.type in I.include_modes))
				continue
			if(gamemode && !(gamemode in I.include_modes))
				continue
		if(I.exclude_modes.len)
			if(!gamemode && SSticker.mode && (SSticker.mode.type in I.exclude_modes))
				continue
			if(gamemode && (gamemode in I.exclude_modes))
				continue
		if(I.player_minimum && I.player_minimum > GLOB.joined_player_list.len)
			continue
		if (I.restricted && !allow_restricted)
			continue

		if(!filtered_uplink_items[I.category])
			filtered_uplink_items[I.category] = list()
		filtered_uplink_items[I.category][I.name] = I
		if(I.limited_stock < 0 && !I.cant_discount && I.item && I.cost > 1)
			sale_items += I
	if(allow_sales)
		for(var/i in 1 to 2) //Smaller list, fewer discounts
			var/datum/uplink_item/I = pick_n_take(sale_items)
			var/datum/uplink_item/A = new I.type
			var/discount = A.get_discount()
			var/list/disclaimer = list("Void where prohibited.", "Not recommended for children.", "Contains small parts.", "Check local laws for legality in region.", "Do not taunt.", "Not responsible for direct, indirect, incidental or consequential damages resulting from any defect, error or failure to perform.", "Keep away from fire or flames.", "Product is provided \"as is\" without any implied or expressed warranties.", "As seen on TV.", "For recreational use only.", "Use only as directed.", "16% sales tax will be charged for orders originating within Space Nebraska.")
			A.limited_stock = 1
			I.refundable = FALSE //THIS MAN USES ONE WEIRD TRICK TO GAIN FREE TC, CODERS HATES HIM!
			A.refundable = FALSE
			if(A.cost >= 20) //Tough love for nuke ops
				discount *= 0.5
			A.cost = max(round(A.cost * discount),1)
			A.category = "Discounted Gear"
			A.name += " ([round(((initial(A.cost)-A.cost)/initial(A.cost))*100)]% off!)"
			A.desc += " Normally costs [initial(A.cost)] TC. All sales final. [pick(disclaimer)]"
			A.item = I.item

			if(!filtered_uplink_items[A.category])
				filtered_uplink_items[A.category] = list()
			filtered_uplink_items[A.category][A.name] = A
	return filtered_uplink_items

