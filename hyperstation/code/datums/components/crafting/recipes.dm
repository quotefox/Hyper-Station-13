/datum/crafting_recipe/milking_machine
	name = "Milking Machine"
	reqs = list(/obj/item/stack/cable_coil = 5, /obj/item/stack/rods = 2, /obj/item/stack/sheet/cardboard = 1, /obj/item/reagent_containers/glass/beaker = 2, /obj/item/stock_parts/manipulator = 1)
	result = /obj/item/milking_machine
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	category = CAT_MISC

/datum/crafting_recipe/milking_machine/penis
	name = "Penis Milking Machine"
	reqs = list(/obj/item/stack/cable_coil = 5, /obj/item/stack/rods = 1, /obj/item/stack/sheet/cardboard = 1, /obj/item/reagent_containers/glass/beaker/large = 1, /obj/item/stock_parts/manipulator = 1)
	result = /obj/item/milking_machine/penis

//to do: put carpentry in it's own crafting tab
/datum/crafting_recipe/weak_metal
	name = "Heated Metal"
	reqs = list(/obj/item/stack/sheet/metal = 5)
	tools = list(TOOL_WELDER)
	category = CAT_CARPENTRY
	result = /obj/item/processed/metal

/datum/crafting_recipe/processed_wood
	name = "Processable Wood"
	reqs = list(/obj/item/stack/sheet/mineral/wood = 5)
	tools = list(TOOL_WIRECUTTER, TOOL_WELDER)
	category = CAT_CARPENTRY
	result = /obj/item/processed/wood/plank

/datum/crafting_recipe/stool_base
	name = "Stool Base"
	reqs = list(/obj/item/processed/wood/seat = 1, /obj/item/processed/wood/gluepeg = 4)
	category = CAT_CARPENTRY
	result = /obj/item/processed/wood/stool1

/datum/crafting_recipe/clothcushion
	name = "Cloth Cushion"
	reqs = list(/obj/item/stack/sheet/cloth = 2, /obj/item/stack/sheet/cotton = 5)
	tools = list(TOOL_WIRECUTTER)
	category = CAT_CARPENTRY
	result = /obj/item/cushion

/datum/crafting_recipe/silkcushion
	name = "Silk Cushion"
	reqs = list(/obj/item/stack/sheet/silk = 2, /obj/item/stack/sheet/cotton = 5)
	tools = list(TOOL_WIRECUTTER)
	category = CAT_CARPENTRY
	result = /obj/item/cushion/silk
