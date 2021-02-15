/datum/crafting_recipe/mummy
	name = "Mummification Bandages (Mask)"
	result = /obj/item/clothing/mask/mummy
	time = 10
	tools = list(/obj/item/nullrod/egyptian)
	reqs = list(/obj/item/stack/sheet/cloth = 2)
	category = CAT_CLOTHING

/datum/crafting_recipe/mummy/body
	name = "Mummification Bandages (Body)"
	result = /obj/item/clothing/under/mummy
	reqs = list(/obj/item/stack/sheet/cloth = 5)

/datum/crafting_recipe/lizardhat
	name = "Lizard Cloche Hat"
	result = /obj/item/clothing/head/lizard
	time = 10
	reqs = list(/obj/item/organ/tail/lizard = 1)
	category = CAT_CLOTHING

/datum/crafting_recipe/lizardhat_alternate
	name = "Lizard Cloche Hat"
	result = /obj/item/clothing/head/lizard
	time = 10
	reqs = list(/obj/item/stack/sheet/animalhide/lizard = 1)
	category = CAT_CLOTHING

/datum/crafting_recipe/kittyears
	name = "Kitty Ears"
	result = /obj/item/clothing/head/kitty/genuine
	time = 10
	reqs = list(/obj/item/organ/tail/cat = 1,
				/obj/item/organ/ears/cat = 1)
	category = CAT_CLOTHING

/datum/crafting_recipe/hudsunsec
	name = "Security HUDsunglasses"
	result = /obj/item/clothing/glasses/hud/security/sunglasses
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/hud/security = 1,
				  /obj/item/clothing/glasses/sunglasses = 1,
				  /obj/item/stack/cable_coil = 5)
	category = CAT_CLOTHING

/datum/crafting_recipe/hudeyesec
	name = "Security HUD eyepatch"
	result = /obj/item/clothing/glasses/hud/security/eyepatch
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/hud/security = 1,
				  /obj/item/clothing/glasses/eyepatch = 1,
				  /obj/item/stack/cable_coil = 5)
	category = CAT_CLOTHING

/datum/crafting_recipe/hudeyesecremoval
	name = "Security HUD removal (Eyepatch)"
	result = /obj/item/clothing/glasses/eyepatch
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/hud/security/eyepatch = 1)
	category = CAT_CLOTHING

/datum/crafting_recipe/hudsunsecremoval
	name = "Security HUD removal"
	result = /obj/item/clothing/glasses/sunglasses
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/hud/security/sunglasses = 1)
	category = CAT_CLOTHING

/datum/crafting_recipe/hudsunmed
	name = "Medical HUDsunglasses"
	result = /obj/item/clothing/glasses/hud/health/sunglasses
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/hud/health = 1,
				  /obj/item/clothing/glasses/sunglasses = 1,
				  /obj/item/stack/cable_coil = 5)
	category = CAT_CLOTHING

/datum/crafting_recipe/hudeyemed
	name = "Medical HUD eyepatch"
	result = /obj/item/clothing/glasses/hud/health/eyepatch
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/hud/health = 1,
				  /obj/item/clothing/glasses/eyepatch = 1,
				  /obj/item/stack/cable_coil = 5)
	category = CAT_CLOTHING

/datum/crafting_recipe/hudsunmedremoval
	name = "Medical HUD removal"
	result = /obj/item/clothing/glasses/sunglasses
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/hud/health/sunglasses = 1)
	category = CAT_CLOTHING

/datum/crafting_recipe/hudeyemedremoval
	name = "Medical HUD removal (Eyepatch)"
	result = /obj/item/clothing/glasses/eyepatch
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/hud/health/eyepatch = 1)
	category = CAT_CLOTHING

/datum/crafting_recipe/hudeyedia
	name = "Diagnostic HUD eyepatch"
	result = /obj/item/clothing/glasses/hud/diagnostic/eyepatch
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/hud/diagnostic = 1,
				  /obj/item/clothing/glasses/eyepatch = 1,
				  /obj/item/stack/cable_coil = 5)
	category = CAT_CLOTHING

/datum/crafting_recipe/hudeyediaremoval
	name = "Diagnostic HUD removal"
	result = /obj/item/clothing/glasses/eyepatch
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/hud/diagnostic/eyepatch = 1)
	category = CAT_CLOTHING

/datum/crafting_recipe/hudeyesci
	name = "Science eyepatch"
	result = /obj/item/clothing/glasses/science/eyepatch
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/science = 1,
				  /obj/item/clothing/glasses/eyepatch = 1,
				  /obj/item/stack/cable_coil = 5)
	category = CAT_CLOTHING

/datum/crafting_recipe/hudeyesciremoval
	name = "Science eyepatch removal"
	result = /obj/item/clothing/glasses/eyepatch
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/science/eyepatch = 1)
	category = CAT_CLOTHING

/datum/crafting_recipe/hudeyemeson
	name = "Meson eyepatch"
	result = /obj/item/clothing/glasses/meson/eyepatch
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/meson = 1,
				  /obj/item/clothing/glasses/eyepatch = 1,
				  /obj/item/stack/cable_coil = 5)
	category = CAT_CLOTHING

/datum/crafting_recipe/hudeyemesonremoval
	name = "Meson eyepatch removal"
	result = /obj/item/clothing/glasses/eyepatch
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/meson/eyepatch = 1)
	category = CAT_CLOTHING

/datum/crafting_recipe/hudeyenv
	name = "Night Vision eyepatch"
	result = /obj/item/clothing/glasses/night/eyepatch
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/night = 1,
				  /obj/item/clothing/glasses/eyepatch = 1,
				  /obj/item/stack/cable_coil = 5)
	category = CAT_CLOTHING

/datum/crafting_recipe/hudeyenvremoval
	name = "Night Vision eyepatch removal"
	result = /obj/item/clothing/glasses/eyepatch
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/night/eyepatch = 1)
	category = CAT_CLOTHING

/datum/crafting_recipe/beergoggles
	name = "Beer Goggles"
	result = /obj/item/clothing/glasses/sunglasses/reagent
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/science = 1,
				  /obj/item/clothing/glasses/sunglasses = 1,
				  /obj/item/stack/cable_coil = 5)
	category = CAT_CLOTHING

/datum/crafting_recipe/beergogglesremoval
	name = "Beer Goggles removal"
	result = /obj/item/clothing/glasses/sunglasses
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/sunglasses/reagent = 1)
	category = CAT_CLOTHING

/datum/crafting_recipe/ghostsheet
	name = "Ghost Sheet"
	result = /obj/item/clothing/suit/ghost_sheet
	time = 5
	tools = list(TOOL_WIRECUTTER)
	reqs = list(/obj/item/bedsheet = 1)
	category = CAT_CLOTHING

/datum/crafting_recipe/briefcase
	name = "Hand made Briefcase"
	result = /obj/item/storage/briefcase/crafted
	time = 35
	tools = list(TOOL_WIRECUTTER)
	reqs = list(/obj/item/stack/sheet/cardboard = 1,
				/obj/item/stack/sheet/cloth = 2,
				/obj/item/stack/sheet/leather = 5)
	category = CAT_CLOTHING

/datum/crafting_recipe/medolier
	name = "Medolier"
	result =  /obj/item/storage/belt/medolier
	reqs = list(/obj/item/stack/sheet/metal = 2,
	/obj/item/stack/sheet/cloth = 3,
	/obj/item/stack/sheet/plastic = 4)
	time = 30
	category = CAT_CLOTHING

/datum/crafting_recipe/durathread_duffelbag
	name = "Durathread Dufflebag"
	result = /obj/item/storage/backpack/duffelbag/durathread
	reqs = list(/obj/item/stack/sheet/durathread = 7,
				/obj/item/stack/sheet/leather = 3)
	time = 70
	always_availible = TRUE
	category = CAT_CLOTHING

/datum/crafting_recipe/durathread_toolbelt
	name = "Durathread Toolbelt"
	result = /obj/item/storage/belt/durathread
	reqs = list(/obj/item/stack/sheet/durathread = 5,
				/obj/item/stack/sheet/leather = 2)
	time = 30
	always_availible = TRUE
	category = CAT_CLOTHING

/datum/crafting_recipe/durathread_helmet
	name = "Makeshift Durathread Helmet"
	result = /obj/item/clothing/head/helmet/durathread
	reqs = list(/obj/item/stack/sheet/durathread = 4,
				/obj/item/stack/sheet/leather = 2)
	time = 30
	always_availible = TRUE
	category = CAT_CLOTHING

/datum/crafting_recipe/durathread_vest
	name = "Makeshift Durathread Armour"
	result = /obj/item/clothing/suit/armor/vest/durathread
	reqs = list(/obj/item/stack/sheet/durathread = 6,
				/obj/item/stack/sheet/leather = 3)
	time = 50
	always_availible = TRUE
	category = CAT_CLOTHING

/datum/crafting_recipe/durathread_wintercoat
	name = "Durathread Winter Coat"
	result = /obj/item/clothing/suit/hooded/wintercoat/durathread
	reqs = list(/obj/item/stack/sheet/durathread = 12,
				/obj/item/stack/sheet/leather = 10)
	time = 70
	category = CAT_CLOTHING

/datum/crafting_recipe/wintercoat_cosmic
	name = "Cosmic Winter Coat"
	result = /obj/item/clothing/suit/hooded/wintercoat/cosmic
	reqs = list(/obj/item/clothing/suit/hooded/wintercoat = 1,
				/obj/item/clothing/suit/hooded/wintercoat/captain = 1,
				/obj/item/clothing/suit/hooded/wintercoat/hop = 1,
				/obj/item/clothing/suit/hooded/wintercoat/hos = 1,
				/obj/item/clothing/suit/hooded/wintercoat/rd = 1,
				/obj/item/clothing/suit/hooded/wintercoat/ce = 1,
				/obj/item/clothing/suit/hooded/wintercoat/cmo = 1,
				/obj/item/clothing/suit/hooded/wintercoat/qm = 1,
				/obj/item/clothing/suit/hooded/wintercoat/robotics = 1,
				/obj/item/clothing/suit/hooded/wintercoat/engineering/atmos = 1,
				/obj/item/clothing/suit/hooded/wintercoat/engineering = 1,
				/obj/item/clothing/suit/hooded/wintercoat/science = 1,
				/obj/item/clothing/suit/hooded/wintercoat/genetics = 1,
				/obj/item/clothing/suit/hooded/wintercoat/chemistry = 1,
				/obj/item/clothing/suit/hooded/wintercoat/medical = 1,
				/obj/item/clothing/suit/hooded/wintercoat/viro = 1,
				/obj/item/clothing/suit/hooded/wintercoat/janitor = 1,
				/obj/item/clothing/suit/hooded/wintercoat/security = 1,
				/obj/item/clothing/suit/hooded/wintercoat/cargo = 1,
				/obj/item/clothing/suit/hooded/wintercoat/hydro = 1,
				/obj/item/clothing/suit/hooded/wintercoat/miner = 1)
	time = 60
	always_availible = TRUE
	category = CAT_CLOTHING
