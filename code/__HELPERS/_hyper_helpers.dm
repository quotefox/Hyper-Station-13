GLOBAL_LIST_EMPTY(cosmetic_heads)
GLOBAL_LIST_EMPTY(cosmetic_chests)
GLOBAL_LIST_EMPTY(cosmetic_arms)
GLOBAL_LIST_EMPTY(cosmetic_legs)

/proc/init_cosmetic_parts(datum/cosmetic_part/type, list/global_list)
	for(var/subtype in subtypesof(type))
		var/datum/cosmetic_part/part = new subtype()
		global_list[part.name] = part
	return global_list