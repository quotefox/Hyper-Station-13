//This file is empty right now, but leaves room for people to put shit here in the future for those who are lazy

/obj/item/robot_module
	var/list/added_channels = list() //Borg radio stuffs

//service
/obj/item/robot_module/butler
	added_channels = list(RADIO_CHANNEL_SERVICE = 1)

/obj/item/robot_module/clown
	added_channels = list(RADIO_CHANNEL_SERVICE = 1)

/obj/item/robot_module/janitor
	added_channels = list(RADIO_CHANNEL_SERVICE = 1)

//engineering
/obj/item/robot_module/engineering
	added_channels = list(RADIO_CHANNEL_ENGINEERING = 1)

//medical
/obj/item/robot_module/medical
	added_channels = list(RADIO_CHANNEL_MEDICAL = 1)

//security
/obj/item/robot_module/peacekeeper
	added_channels = list(RADIO_CHANNEL_SECURITY = 1)

/obj/item/robot_module/security
	added_channels = list(RADIO_CHANNEL_SECURITY = 1)

//supply
/obj/item/robot_module/miner
	added_channels = list(RADIO_CHANNEL_SUPPLY = 1) // Probably already handled by other code when spawned with pre-set module, but whatever.

//dogborgs
/obj/item/robot_module/k9
	added_channels = list(RADIO_CHANNEL_SECURITY = 1)

/obj/item/robot_module/medihound
	added_channels = list(RADIO_CHANNEL_MEDICAL = 1)

/obj/item/robot_module/scrubpup
	added_channels = list(RADIO_CHANNEL_SERVICE = 1)

/obj/item/robot_module/borgi
	added_channels = list(RADIO_CHANNEL_SERVICE = 1)

/obj/item/robot_module/orepup
	added_channels = list(RADIO_CHANNEL_SUPPLY = 1)


//This proc gets called whenever a new robot module is being applied --Cyanosis
/obj/item/robot_module/proc/handle_sprite_action(mob/living/silicon/robot/R, is_huge = FALSE)
	ASSERT(istype(R))
	if(R.small_sprite_action)
		QDEL_NULL(R.small_sprite_action)
	if(!is_huge)	//only from the expander upgrade. The borg won't have an action if they don't have the expander upgrade
		return
	for(var/P in typesof(/datum/action/cyborg_small_sprite))
		var/datum/action/cyborg_small_sprite/action = P
		if(initial(action.designated_module) == name)
			R.small_sprite_action = new action()
			R.small_sprite_action.Grant(R)
			break
	if(!R.small_sprite_action)
		R.small_sprite_action = new()
		R.small_sprite_action.Grant(R)
