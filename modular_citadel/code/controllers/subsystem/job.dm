/datum/controller/subsystem/job/proc/equip_loadout(mob/dead/new_player/N, mob/living/M, datum/job/job, joined_late)
	var/mob/the_mob = N
	if(!the_mob)
		the_mob = M // cause this doesn't get assigned if player is a latejoiner

	if(the_mob.client && the_mob.client.prefs && (the_mob.client.prefs.chosen_gear && the_mob.client.prefs.chosen_gear.len))
		if(!ishuman(M))//no silicons allowed
			return
		
		var/list/queued_to_equip = list()	//items the player will equip on their person
		var/list/queued_for_storage = list()	//items that will get stuffed into the player's backpack

		for(var/i in the_mob.client.prefs.chosen_gear)	//Prepare our loadouts for creation and equipping
			var/datum/gear/G = i
			G = GLOB.loadout_items[slot_to_string(initial(G.category))][initial(G.name)]
			if(!G)
				continue
			if(G.restricted_roles && G.restricted_roles.len && !(M.mind.assigned_role in G.restricted_roles))
				continue	//If the player's not supposed to equip this because they lack the job
			if(G.ckeywhitelist && G.ckeywhitelist.len && !(the_mob.client.ckey in G.ckeywhitelist))
				continue	//how the fuck
			
			if(G.category == SLOT_IN_BACKPACK || G.blacklist_join_equip)
				queued_for_storage += G
			else
				queued_to_equip += G
		
		for(var/datum/gear/G in queued_to_equip)	//Dress up the player like a doll
			var/obj/item/I = new G.path
			if(!M.equip_to_slot_if_possible(I, G.category, disable_warning = TRUE, bypass_equip_delay_self = TRUE))
				queued_for_storage += G	//If the player can't equip the item, queue it for storage
		
		job.after_spawn(the_mob, M, joined_late)
		job.equip(M, null, null, joined_late)	//Equip the job outfit

		if(iscarbon(M))		//Start storing the items into the player's backpack. They should have one from job.equip
			var/mob/living/carbon/C = M
			var/obj/item/storage/backpack/B = C.back
			if(B)
				for(var/datum/gear/G in queued_for_storage)
					var/obj/item/I = new G.path
					if(SEND_SIGNAL(B, COMSIG_TRY_STORAGE_INSERT, I, null, TRUE, TRUE))
						queued_for_storage -= G
		
		for(var/datum/gear/G in queued_for_storage)	//If there isn't a backpack, or if the backpack became full, drop items beneath the player's feet
			var/obj/item/I = new G.path
			I.forceMove(M)

/datum/controller/subsystem/job/proc/FreeRole(rank)
	if(!rank)
		return
	var/datum/job/job = GetJob(rank)
	if(!job)
		return FALSE
	job.current_positions = max(0, job.current_positions - 1)
