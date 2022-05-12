GLOBAL_LIST_EMPTY(cosmetic_head)
GLOBAL_LIST_EMPTY(cosmetic_chest)
GLOBAL_LIST_EMPTY(cosmetic_arms)
GLOBAL_LIST_EMPTY(cosmetic_legs)

/proc/init_cosmetic_parts(datum/cosmetic_part/type, global_list)
	global_list = list("default")
	for(var/subtype in subtypesof(type))
		var/datum/cosmetic_part/part = new subtype()
		global_list[part.name] = part