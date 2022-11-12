GLOBAL_LIST_INIT(roleplay_positions, list(
	//"Central Command Inspector", // CC Inspector Disabled
	"Prisoner"))

/datum/job/roleplay/
	var/info_text = "Debug Text on What the Job does."
	var/quest_info = "To be the very best, like noone ever was."
	var/failure_info = "To suck."
	department_flag = ROLEPLAY
	loadout = FALSE
/*

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
Central Command Inspector Disabled
removed spawn locations used by this datum object - /obj/effect/landmark/start/rpcentral
_Maps\map_files\generic\CentCom.dmm - Coordinate 135,88,1
_Maps\map_files\generic\CentCom.dmm - Coordinate 136,87,1
_Maps\map_files\generic\CentCom.dmm - Coordinate 137,88,1
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

//Central Command Inspector
////////////////////////////////////////////
GLOBAL_LIST_EMPTY(rpcentralspawn) //required for late game spawning

/datum/job/roleplay/rpcentral
	title = "Central Command Inspector"
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	minimal_player_age = 1
	supervisors = "central command"
	selection_color = "#ffeef0"
	info_text = "A offical from Central Command, performing a routine inspection of the station."
	quest_info = "Complete a routine check of the station, And make a write up for your bosses. The information collected should be submitted to Central Command before the end of the shift. Notify the crew ahead of time for initating."
	failure_info = "Failure to fill in the form correctly will face severe penalties from Command."
	outfit = /datum/outfit/centcom_official
	override_roundstart_spawn = /obj/effect/landmark/start/rpcentral

/datum/job/roleplay/rpcentral/override_latejoin_spawn()
	return TRUE

/datum/job/roleplay/rpcentral/after_spawn(mob/H, mob/M, latejoin)
	H.Move(pick(GLOB.rpcentralspawn))
	H.forceMove(pick(GLOB.rpcentralspawn))

/obj/effect/landmark/start/rpcentral
	name = "Central Command Inspector"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "snukeop_leader_spawn"

/obj/effect/landmark/start/rpcentral/Initialize(mapload)
	..()
	GLOB.rpcentralspawn += loc
	return INITIALIZE_HINT_QDEL
*/ // CC Inspector Disabled

//Prisoner
////////////////////////////////////////////
GLOBAL_LIST_EMPTY(prisionspawn)

/datum/job/roleplay/prisoner
	title = "Prisoner"
	faction = "Station"
	total_positions = 3
	spawn_positions = 1
	minimal_player_age = 1
	supervisors = "security"
	selection_color = "#ffeef0"
	info_text = "For one reason or another, you are a prisoner. Kinaris has chosen to temporarily hold you within Layenia Station's holding area, \
	until the end of the shift. You do not permanently reside here, but you may end up in this place from shift to shift. It is highly recommended to \
	make a unique character slot for this role. Kinaris would not neuter or otherwise remove identifying features that make you who you are; such as \
	altering your name, features, or physical appearance. As a prisoner, you still uphold a decent amount of rights."
	quest_info = "Do NOT attempt to break out, antagonize, or otherwise treat your role as anything to grief with. Should you find a scenario where you want to, AHELP."
	failure_info = ""
	outfit = /datum/outfit/prisoner

/datum/job/roleplay/prisoner/override_latejoin_spawn()
	return TRUE

/datum/job/roleplay/prisoner/after_spawn(mob/H, mob/M, latejoin)
	AnnounceArrival(H, title)
	H.Move(pick(GLOB.prisionspawn))
	H.forceMove(pick(GLOB.prisionspawn))

/obj/effect/landmark/start/prisoner
	name = "Prisoner"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "snukeop_leader_spawn"

/obj/effect/landmark/start/prisoner/Initialize(mapload)
	..()
	GLOB.prisionspawn += loc
	return INITIALIZE_HINT_QDEL
