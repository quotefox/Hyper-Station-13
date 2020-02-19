/datum/crafting_recipe/toyneb
	name = "Non-Euplastic Blade"
	reqs = list(/obj/item/light/tube = 1, /obj/item/stack/cable_coil = 1, /obj/item/stack/sheet/plastic = 4)
	result = /obj/item/toy/sword/cx
	category = CAT_MISC

/datum/crafting_recipe/potatos
	name = "Potat-OS"
	reqs = list(/obj/item/stack/cable_coil = 1, /obj/item/stack/rods = 1,  /obj/item/reagent_containers/food/snacks/grown/potato = 1, /obj/item/aicard = 1 )
	result = /obj/item/aicard/potato
	category = CAT_ROBOT

/datum/crafting_recipe/milker
	name = "Milking Machine"
	reqs = list(/obj/item/stack/cable_coil = 5, /obj/item/stack/sheet/plastic = 2, /obj/item/stack/rods = 2, /obj/item/stack/sheet/cardboard = 1, /obj/item/reagent_containers/glass/beaker = 2, /obj/item/stock_parts/manipulator = 1)
	result = /obj/item/milker
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER, TOOL_WIRECUTTER)

/datum/crafting_recipe/milker/penis
	name = "Penis Milking Machine"
	reqs = list(/obj/item/stack/cable_coil = 5, /obj/item/stack/sheet/plastic = 2, /obj/item/stack/rods = 1, /obj/item/stack/sheet/cardboard = 1, /obj/item/reagent_containers/glass/beaker/large = 1, /obj/item/stock_parts/manipulator = 1)
	result = /obj/item/milker/penis
