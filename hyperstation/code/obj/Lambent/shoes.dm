/obj/item/clothing/shoes/lambent
	name = "Lambent's heels"
	desc = "A sleek pair of leggings with high heels, gilded in golden strips. It seems to have an autobalancing matrix installed."
	icon_state = "lambent"
	item_state = "lambent"
	icon = 'hyperstation/icons/obj/clothing/shoes.dmi'
	alternate_worn_icon = 'hyperstation/icons/mobs/feet.dmi'
	body_parts_covered = LEGS|FEET
	cold_protection = LEGS|FEET
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	strip_delay = 70
	resistance_flags = LAVA_PROOF|FIRE_PROOF|UNACIDABLE
	armor = list("melee" = 50, "bullet" = 50, "laser" = 30, "energy" = 30, "bomb" = 30, "bio" = 30, "rad" = 30, "fire" = 20, "acid" = 60)
	clothing_flags = NOSLIP
