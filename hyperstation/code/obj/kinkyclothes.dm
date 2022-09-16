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

/obj/item/clothing/under/latexfull
	name = "full latex jumpsuit"
	desc = "A tight fitting jumpsuit made of latex."
	icon = 'hyperstation/icons/obj/clothing/suits.dmi'
	icon_state = "latex"
	alternate_worn_icon = 'hyperstation/icons/mobs/suits.dmi'
	item_state = "r_suit"
	can_adjust = FALSE

/obj/item/clothing/under/latexhalf
	name = "latex bodysuit"
	desc = "A tight fitting outfit made of latex, that covers the wearers torso."
	icon = 'hyperstation/icons/obj/clothing/suits.dmi'
	icon_state = "latexhalf"
	alternate_worn_icon = 'hyperstation/icons/mobs/suits.dmi'
	item_state = "r_suit"
	can_adjust = FALSE
	mutantrace_variation = NO_MUTANTRACE_VARIATION
	do_not_cover_butt = TRUE

/obj/item/clothing/under/sexynursesuit
	name = "Sexy nurse outfit"
	desc = "A very revealing nurse's outfit. Not very sanitary. Does it even count as clothing?"
	icon = 'hyperstation/icons/obj/clothing/suits.dmi'
	icon_state = "sexynursesuit"
	alternate_worn_icon = 'hyperstation/icons/mobs/suits.dmi'
	item_state = "r_suit"
	can_adjust = FALSE
	mutantrace_variation = NO_MUTANTRACE_VARIATION

/obj/item/clothing/under/centcomdress
	name = "Centcom Dress Uniform"
	desc = "A stylish yet revealing dress uniform worn in extravagent black and gold, worthy of those who sit around and watch cameras all day in an office."
	icon = 'hyperstation/icons/obj/clothing/suits.dmi'
	icon_state = "ccdress"
	alternate_worn_icon = 'hyperstation/icons/mobs/suits.dmi'
	item_state = "r_suit"
	can_adjust = FALSE
	//We will never know why CC can make their skimpy outfits tough as nails
	body_parts_covered = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	cold_protection = CHEST|GROIN|ARMS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	heat_protection = CHEST|GROIN|ARMS
	armor = list("melee" = 60, "bullet" = 80, "laser" = 80, "energy" = 90, "bomb" = 50, "bio" = 100, "rad" = 50, "fire" = 50, "acid" = 50)

/obj/item/clothing/under/centcomdressvk
	name = "Virginkiller Centcom Dress Uniform"
	desc = "This black and gold beauty does not help paperwork get done, it seems."
	icon = 'hyperstation/icons/obj/clothing/suits.dmi'
	icon_state = "ccdressvk"
	alternate_worn_icon = 'hyperstation/icons/mobs/suits.dmi'
	item_state = "r_suit"
	can_adjust = FALSE
	//We will never know why CC can make their skimpy outfits tough as nails
	body_parts_covered = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	cold_protection = CHEST|GROIN|ARMS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	heat_protection = CHEST|GROIN|ARMS
	armor = list("melee" = 60, "bullet" = 80, "laser" = 80, "energy" = 90, "bomb" = 50, "bio" = 100, "rad" = 50, "fire" = 50, "acid" = 50)

/obj/item/clothing/under/raccveralls
	name = "form fitting overalls"
	desc = "A tight form fitting pair of overalls."
	icon = 'hyperstation/icons/obj/clothing/uniforms.dmi'
	icon_state = "raccveralls"
	alternate_worn_icon = 'hyperstation/icons/mobs/uniforms.dmi'
	item_state = "raccveralls"
	can_adjust = FALSE

/obj/item/clothing/under/officesexy
	name = "Revealing office uniform"
	desc = "A sexy office uniform, that has a low cropped front to show off some chest, or bra. And a tall dress that covers the stomach, complete with a set of buttons."
	icon = 'hyperstation/icons/obj/clothing/uniforms.dmi'
	icon_state = "office_revealing"
	alternate_worn_icon = 'hyperstation/icons/mobs/uniforms.dmi'
	item_state = "office_revealing"
	can_adjust = FALSE
	mutantrace_variation = NO_MUTANTRACE_VARIATION

/obj/item/clothing/under/vaultsuit
	name = "vault suit"
	desc = "A tight form fitting Vault-Tec standard issue Vault Jumpsuit! Snazzy!"
	icon = 'hyperstation/icons/obj/clothing/uniforms.dmi'
	icon_state = "vaultsuit"
	alternate_worn_icon = 'hyperstation/icons/mobs/uniforms.dmi'
	item_state = "b_suit"
	can_adjust = FALSE
	var/firstpickup = TRUE
	var/pickupsound = TRUE

/obj/item/clothing/under/vaultsuit/no_sound
	pickupsound = FALSE

/obj/item/clothing/under/vaultsuit/equipped(mob/user, slot)
	. = ..()
	if(!pickupsound)
		return
	if(!ishuman(user))
		return
	if(slot == SLOT_W_UNIFORM)
		if(!firstpickup)
			SEND_SOUND(user, sound('hyperstation/sound/effects/vaultsuit/FalloutEXPUp.ogg', volume = 50))
		else
			firstpickup = FALSE
			SEND_SOUND(user, sound('hyperstation/sound/effects/vaultsuit/FalloutLevelUp.ogg', volume = 50))
			SEND_SOUND(user, sound('hyperstation/sound/effects/vaultsuit/InkSpotsSting.ogg', volume = 60))
	return

/obj/item/clothing/suit/tunnelfox
	name = "tunnel fox jacket"
	desc = "Tunnel Foxes Rule!"
	icon = 'hyperstation/icons/obj/clothing/suits.dmi'
	icon_state = "tunnelfox"
	alternate_worn_icon = 'hyperstation/icons/mobs/suits.dmi'
	item_state = "tunnelfox"
	body_parts_covered = CHEST|ARMS
	cold_protection = CHEST|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/suit/tunnelfox_t
	name = "opened tunnel fox jacket"
	desc = "Tunnel Foxes Rule!"
	icon = 'hyperstation/icons/obj/clothing/suits.dmi'
	icon_state = "tunnelfox_t"
	alternate_worn_icon = 'hyperstation/icons/mobs/suits.dmi'
	item_state = "tunnelfox_t"
	body_parts_covered = CHEST|ARMS
	cold_protection = CHEST|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/suit/threepwoodjacket
	name = "threepwood's jacket"
	desc = "A jacket fit for a Mighty Pirate!"
	icon = 'hyperstation/icons/obj/clothing/suits.dmi'
	icon_state = "threepwoodjacket"
	alternate_worn_icon = 'hyperstation/icons/mobs/suits.dmi'
	body_parts_covered = CHEST|LEGS|GROIN|ARMS
	cold_protection = CHEST|LEGS|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	item_state = "b_suit"
	var/firstpickup = TRUE
	var/pickupsound = TRUE

/obj/item/clothing/suit/threepwoodjacket/equipped(mob/user, slot)
	. = ..()
	if(!pickupsound)
		return
	if(!ishuman(user))
		return
	if(slot == SLOT_WEAR_SUIT)
		if(!firstpickup)
			SEND_SOUND(user, sound('hyperstation/sound/effects/vaultsuit/FalloutEXPUp.ogg', volume = 00))
		else
			firstpickup = FALSE
			SEND_SOUND(user, sound('hyperstation/sound/effects/vaultsuit/bartandfink.ogg', volume = 60))
	return

/obj/item/clothing/under/threepwood
	name = "threepwood's outfit"
	desc = "An outfit fit for a Mighty Pirate!."
	icon = 'hyperstation/icons/obj/clothing/uniforms.dmi'
	icon_state = "threepwood"
	alternate_worn_icon = 'hyperstation/icons/mobs/uniforms.dmi'
	item_state = "w_suit"
	can_adjust = FALSE

/obj/item/clothing/shoes/threepwoodboots
	name = "threepwood's boots"
	desc = "A pair of boots fit for a Mighty Pirate!."
	icon = 'hyperstation/icons/obj/clothing/shoes.dmi'
	icon_state = "threepwoodboots"
	alternate_worn_icon = 'hyperstation/icons/obj/clothing/shoes.dmi'
	item_state = "threepwoodboots"
	alternate_worn_icon = 'hyperstation/icons/mobs/feet.dmi'
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/shoes