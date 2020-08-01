SUBSYSTEM_DEF(itemspawners)
	name = "Item Spawners"
	wait = 1 HOURS

/datum/controller/subsystem/itemspawners/fire(resumed = 0)
	log_game("Item Spawners Subsystem Firing")
	message_admins("Item Spawners Subsystem Firing.")

	restock_trash_piles()

/datum/controller/subsystem/itemspawners/proc/restock_trash_piles()
	for(var/obj/structure/trash_pile/TS in GLOB.trash_piles)
		TS.used_players = list() 
