/datum/controller/subsystem/job/proc/equip_loadout(mob/dead/new_player/N, mob/living/M)
	var/mob/the_mob = N
	if(!the_mob)
		the_mob = M // cause this doesn't get assigned if player is a latejoiner
	if(the_mob.client.prefs)
		if(!ishuman(M))//no silicons allowed
			return

		var/list/queued_to_equip = list()		//Items that will equip onto the player
		. = list()	//Items that will be stored into the player's backpack, handled by EquipRank()
		for(var/i in the_mob.client.prefs.chosen_gear)	//Prepare the player's loadout gear
			var/datum/gear/G = i
			G = GLOB.loadout_items[slot_to_string(initial(G.category))][initial(G.name)]
			if(!G)
				continue
			if(G.restricted_roles.len && !(M.mind.assigned_role in G.restricted_roles))
				continue	//If the player can't equip this because they lack the required job
			if(G.ckeywhitelist.len && !(the_mob.client.ckey in G.ckeywhitelist))
				continue	//And you may ask yourself, "Well... How did I get here?"

			if(G.category == SLOT_IN_BACKPACK || G.blacklist_join_equip)
				. += new G.path
			else
				queued_to_equip += G

		for(var/datum/gear/G in queued_to_equip)
			var/obj/item/I = new G.path
			if(!M.equip_to_slot_if_possible(I, G.category, disable_warning = TRUE, bypass_equip_delay_self = TRUE))
				. += I		//If the player's unable to equip the item, queue it for storage

/datum/controller/subsystem/job/proc/FreeRole(rank)
	if(!rank)
		return
	var/datum/job/job = GetJob(rank)
	if(!job)
		return FALSE
	job.current_positions = max(0, job.current_positions - 1)
