/obj/item/clothing/suit/lambent
	name = "Lambent's coat"
	desc = "A regal-esque coat outfitted with inert nanites, waiting to be activated at a moment's notice."
	icon = 'hyperstation/icons/obj/clothing/suits.dmi'
	//alternate_worn_icon = 'hyperstation/icons/mobs/suits.dmi'
	icon_state = "lambent"
	item_state = "lambent"
	body_parts_covered = CHEST|LEGS
	cold_protection = CHEST|GROIN|LEGS|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	strip_delay = 70
	resistance_flags = LAVA_PROOF|FIRE_PROOF|UNACIDABLE
	armor = list("melee" = 50, "bullet" = 50, "laser" = 30, "energy" = 30, "bomb" = 30, "bio" = 30, "rad" = 30, "fire" = 20, "acid" = 60)
