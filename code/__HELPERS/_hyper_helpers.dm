GLOBAL_LIST_EMPTY(cosmetic_heads)
GLOBAL_LIST_EMPTY(cosmetic_chests)
GLOBAL_LIST_EMPTY(cosmetic_arms)
GLOBAL_LIST_EMPTY(cosmetic_legs)

//A list of safety tether machines for cloud chasms to refer to for emergency teleportation of fallen mobs
GLOBAL_LIST_EMPTY(safety_tethers_list)

/proc/init_cosmetic_parts(datum/cosmetic_part/type, list/global_list)
	for(var/subtype in subtypesof(type))
		var/datum/cosmetic_part/part = new subtype()
		global_list[part.id] = part
	return global_list