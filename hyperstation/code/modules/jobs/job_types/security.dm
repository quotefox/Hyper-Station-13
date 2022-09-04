/*
Lambent
*/
/datum/job/lambent
	title = "Lambent"
	flag = LAMBENT
	department_head = list("CentCom")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "Central Command and Kinaris officials"
	selection_color = "#ffedcc"
	req_admin_notify = 1
	minimal_player_age = 30
	exp_requirements = 9000
	exp_type = EXP_TYPE_COMMAND
	exp_type_department = EXP_TYPE_COMMAND
	whitelist_type = "important"
	custom_spawn_text = "You are a Kinaris Lambent; a person hired directly by Kinaris who has a high interest in asset security and the protection of the station. Unlike the station, your gear is official Kinaris items, not replicated Milky-Way Engrams. As such, you should keep them safe due to the power they hold. You answer directly to Central Command and Kinaris, and security matters should not involve you for the most part, unless staffing is low or there is a problem with securing assets. Thankfully, Layenia Station is one of Kinaris's most low-tech stations with hardly anything important to secure; not even the items in the vault are noteworthy due to the falsified, low-tech Engram they're under. Just ensure peace is kept and the station is functioning in a calm manner."

	outfit = /datum/outfit/job/lambent

	access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_ARMORY, ACCESS_COURT, ACCESS_WEAPONS, ACCESS_ENTER_GENPOP, ACCESS_LEAVE_GENPOP, ACCESS_LAMBENT,
			            ACCESS_FORENSICS_LOCKERS, ACCESS_MORGUE, ACCESS_MAINT_TUNNELS, ACCESS_ALL_PERSONAL_LOCKERS, ACCESS_BARISTA, ACCESS_BARBER,
			            ACCESS_RESEARCH, ACCESS_ENGINE, ACCESS_MINING, ACCESS_MEDICAL, ACCESS_CONSTRUCTION, ACCESS_MAILSORTING,
			            ACCESS_HEADS, ACCESS_HOS, ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_GATEWAY, ACCESS_MAINT_TUNNELS, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_ARMORY, ACCESS_COURT, ACCESS_WEAPONS, ACCESS_ENTER_GENPOP, ACCESS_LEAVE_GENPOP, ACCESS_LAMBENT,
			            ACCESS_FORENSICS_LOCKERS, ACCESS_MORGUE, ACCESS_MAINT_TUNNELS, ACCESS_ALL_PERSONAL_LOCKERS, ACCESS_BARISTA, ACCESS_BARBER,
			            ACCESS_RESEARCH, ACCESS_ENGINE, ACCESS_MINING, ACCESS_MEDICAL, ACCESS_CONSTRUCTION, ACCESS_MAILSORTING,
			            ACCESS_HEADS, ACCESS_HOS, ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_GATEWAY, ACCESS_MAINT_TUNNELS, ACCESS_MINERAL_STOREROOM)

	mind_traits = list(TRAIT_CAPTAIN_METABOLISM)

	blacklisted_quirks = list(/datum/quirk/brainproblems, /datum/quirk/insanity, /datum/quirk/nonviolent)

/datum/outfit/job/lambent
	name = "Lambent"
	jobtype = /datum/job/lambent

	id = /obj/item/card/id/silver
	belt = /obj/item/pda/captain
	glasses = /obj/item/clothing/glasses/hud/toggle/zao
	ears = /obj/item/radio/headset/heads/captain/alt
	gloves = /obj/item/clothing/gloves/lambent
	uniform =  /obj/item/clothing/under/rank/lambent
	suit = /obj/item/clothing/suit/lambent
	shoes = /obj/item/clothing/shoes/lambent
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1, /obj/item/modular_computer/tablet/preset/advanced = 1)

	backpack = /obj/item/storage/backpack/lambent
	satchel = /obj/item/storage/backpack/satchel/lambent
	duffelbag = /obj/item/storage/backpack/duffelbag/lambent
	box = /obj/item/storage/box/security

	implants = list(/obj/item/implant/mindshield)
