/*
Captain
*/
/datum/job/captain
	title = "Captain"
	flag = CAPTAIN
	department_head = list("CentCom")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "Kinaris officials and Space law"
	selection_color = "#ccccff"
	req_admin_notify = 1
	minimal_player_age = 30
	exp_requirements = 3000
	exp_type = EXP_TYPE_COMMAND
	exp_type_department = EXP_TYPE_COMMAND

	outfit = /datum/outfit/job/captain

	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()

	mind_traits = list(TRAIT_CAPTAIN_METABOLISM, TRAIT_DISK_VERIFIER)

	blacklisted_quirks = list(/datum/quirk/mute, /datum/quirk/brainproblems, /datum/quirk/insanity, /datum/quirk/monophobia/)

/datum/job/captain/get_access()
	return get_all_accesses()

/datum/job/captain/announce(mob/living/carbon/human/H, tried=FALSE)
	if(!H)
		return
	if(!H.client && !tried)		//Roundstart mobs don't have clients when announce() gets called
		SSticker.OnRoundstart(CALLBACK(src, .proc/announce, H, TRUE))	//So we try again...
		return
	if(tried && !H.client)	//We don't want to endlessly call ourselves when we don't have a client
		throw EXCEPTION("[H.nameless ? "Captain" : "Captain [H.real_name]"] ([H.x],[H.y],[H.z]) has no client.")
		return

	var/displayed_rank = H.client.prefs.alt_titles_preferences[title]
	if(!displayed_rank)	//Default to Captain
		displayed_rank = "Captain"

	minor_announce("[displayed_rank] [H.nameless ? "" : "[H.real_name] "]on deck!")
	..()

/datum/outfit/job/captain
	name = "Captain"
	jobtype = /datum/job/captain

	id = /obj/item/card/id/gold
	belt = /obj/item/pda/captain
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/heads/captain/alt
	gloves = /obj/item/clothing/gloves/color/captain
	uniform =  /obj/item/clothing/under/rank/captain
	suit = /obj/item/clothing/suit/armor/vest/capcarapace
	shoes = /obj/item/clothing/shoes/sneakers/brown
	head = /obj/item/clothing/head/caphat
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1, /obj/item/station_charter=1, /obj/item/modular_computer/tablet/preset/advanced = 1)

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain

	implants = list(/obj/item/implant/mindshield)
	accessory = /obj/item/clothing/accessory/medal/gold/captain

	chameleon_extras = list(/obj/item/gun/energy/e_gun, /obj/item/stamp/captain)

/datum/outfit/job/captain/hardsuit
	name = "Captain (Hardsuit)"

	mask = /obj/item/clothing/mask/gas/sechailer
	suit = /obj/item/clothing/suit/space/hardsuit/captain
	suit_store = /obj/item/tank/internals/oxygen

/*
Head of Personnel
*/
/datum/job/hop
	title = "Head of Personnel"
	flag = HOP
	department_head = list("Captain")
	department_flag = CIVILIAN
	head_announce = list(RADIO_CHANNEL_SERVICE)
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
	selection_color = "#ddddff"
	req_admin_notify = 1
	minimal_player_age = 20
	exp_requirements = 1500
	exp_type = EXP_TYPE_SERVICE
	exp_type_department = EXP_TYPE_SERVICE

	outfit = /datum/outfit/job/hop

	access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_COURT, ACCESS_WEAPONS,
			            ACCESS_MEDICAL, ACCESS_ENGINE, ACCESS_CHANGE_IDS, ACCESS_AI_UPLOAD, ACCESS_EVA, ACCESS_HEADS,
			            ACCESS_ALL_PERSONAL_LOCKERS, ACCESS_MAINT_TUNNELS, ACCESS_BAR, ACCESS_JANITOR, ACCESS_CONSTRUCTION, ACCESS_MORGUE,
			            ACCESS_CREMATORIUM, ACCESS_KITCHEN, ACCESS_CARGO, ACCESS_CARGO_BOT, ACCESS_MAILSORTING, ACCESS_QM, ACCESS_HYDROPONICS, ACCESS_LAWYER,
			            ACCESS_THEATRE, ACCESS_CHAPEL_OFFICE, ACCESS_LIBRARY, ACCESS_RESEARCH, ACCESS_MINING, ACCESS_VAULT, ACCESS_MINING_STATION,
			            ACCESS_HOP, ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_GATEWAY, ACCESS_MINERAL_STOREROOM, ACCESS_PSYCH)
	minimal_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_COURT, ACCESS_WEAPONS,
			            ACCESS_MEDICAL, ACCESS_ENGINE, ACCESS_CHANGE_IDS, ACCESS_AI_UPLOAD, ACCESS_EVA, ACCESS_HEADS,
			            ACCESS_ALL_PERSONAL_LOCKERS, ACCESS_MAINT_TUNNELS, ACCESS_BAR, ACCESS_JANITOR, ACCESS_CONSTRUCTION, ACCESS_MORGUE,
			            ACCESS_CREMATORIUM, ACCESS_KITCHEN, ACCESS_CARGO, ACCESS_CARGO_BOT, ACCESS_MAILSORTING, ACCESS_QM, ACCESS_HYDROPONICS, ACCESS_LAWYER,
			            ACCESS_THEATRE, ACCESS_CHAPEL_OFFICE, ACCESS_LIBRARY, ACCESS_RESEARCH, ACCESS_MINING, ACCESS_VAULT, ACCESS_MINING_STATION,
			            ACCESS_HOP, ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_GATEWAY, ACCESS_MINERAL_STOREROOM, ACCESS_PSYCH)

	blacklisted_quirks = list(/datum/quirk/mute, /datum/quirk/brainproblems, /datum/quirk/prosopagnosia, /datum/quirk/insanity)

/datum/outfit/job/hop
	name = "Head of Personnel"
	jobtype = /datum/job/hop

	id = /obj/item/card/id/silver
	belt = /obj/item/pda/heads/hop
	ears = /obj/item/radio/headset/heads/hop
	uniform = /obj/item/clothing/under/rank/head_of_personnel
	shoes = /obj/item/clothing/shoes/sneakers/brown
	head = /obj/item/clothing/head/hopcap
	backpack_contents = list(/obj/item/storage/box/ids=1,\
		/obj/item/melee/classic_baton/telescopic=1, /obj/item/modular_computer/tablet/preset/advanced = 1)

	chameleon_extras = list(/obj/item/gun/energy/e_gun, /obj/item/stamp/hop)
