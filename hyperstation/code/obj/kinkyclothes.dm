/obj/item/clothing/gloves/latexsleeves
	name = "latex sleeves"
	desc = "A pair of shiny latex sleeves that covers ones arms."
	icon_state = "latex"
	item_state = "latex"
	icon = 'hyperstation/icons/obj/clothing/gloves.dmi'
	alternate_worn_icon = 'hyperstation/icons/mobs/gloves.dmi'
	mutantrace_variation = NO_MUTANTRACE_VARIATION
	price = 5

/obj/item/clothing/gloves/latexsleeves/security
	name = "security sleeves"
	desc = "A pair of latex sleeves, with a band of red above the elbows denoting that the wearer is part of the security team."
	icon_state = "latexsec"
	item_state = "latexsec"
	price = 5

/obj/item/clothing/head/dominatrixcap
	name = "dominatrix cap"
	desc = "A sign of authority, over the body."
	icon_state = "dominatrix"
	item_state = "dominatrix"
	icon = 'hyperstation/icons/obj/clothing/head.dmi'
	alternate_worn_icon = 'hyperstation/icons/mobs/head.dmi'
	mutantrace_variation = NO_MUTANTRACE_VARIATION

/obj/item/clothing/shoes/highheels
	name = "high heels"
	desc = "They make the wearer appear taller, and more noisey!"
	icon_state = "highheels"
	item_state = "highheels"
	icon = 'hyperstation/icons/obj/clothing/shoes.dmi'
	alternate_worn_icon = 'hyperstation/icons/mobs/feet.dmi'


/obj/item/clothing/shoes/highheels/Initialize()
	. = ..()
	AddComponent(/datum/component/squeak, list('sound/effects/footstep/highheel1.ogg' = 1,'sound/effects/footstep/highheel2.ogg' = 1), 20)
//the classic click clack

obj/item/clothing/neck/stole
	name = "white boa"
	desc = "Fluffy neck wear to keep you warm, and attract others."
	icon = 'hyperstation/icons/obj/clothing/neck.dmi'
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "stole"
	item_state = ""	//no inhands
	price = 3

obj/item/clothing/neck/stole/black
	name = "black boa"
	desc = "Fluffy neck wear to keep you warm, and attract others."
	icon = 'hyperstation/icons/obj/clothing/neck.dmi'
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "stole"
	item_state = ""	//no inhands
	color = "#3d3d3d"
	price = 3

/obj/item/clothing/suit/fluffyhalfcrop
	name = "fluffy half-crop jacket"
	desc = "A fluffy synthetic fur half-cropped jacket, less about warmth, more about style!"
	icon_state = "fluffy"
	item_state = "fluffy"
	icon = 'hyperstation/icons/obj/clothing/suits.dmi'
	alternate_worn_icon = 'hyperstation/icons/mobs/suits.dmi'
	body_parts_covered = CHEST|LEGS|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	mutantrace_variation = NO_MUTANTRACE_VARIATION
