//This file is empty right now, but leaves room for people to put shit here in the future for those who are lazy

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
