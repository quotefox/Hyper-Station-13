/obj/item/clothing/gloves/lambent
	name = "Lambent's sleeves"
	desc = "An elegant sleeve worn from the shoulder down. Despite missing anything on the palm and fingers, it seems to cast small hardlight protections over the hands, like a glove."
	icon_state = "lambent"
	item_state = "lambent"
	icon = 'hyperstation/icons/obj/clothing/gloves.dmi'
	alternate_worn_icon = 'hyperstation/icons/mobs/gloves.dmi'
	armor = list("melee" = 50, "bullet" = 50, "laser" = 30, "energy" = 30, "bomb" = 30, "bio" = 30, "rad" = 30, "fire" = 20, "acid" = 60)
	resistance_flags = LAVA_PROOF|FIRE_PROOF|UNACIDABLE
	transfer_prints = FALSE
	strip_delay = 40
	body_parts_covered = ARMS|HANDS
	cold_protection = ARMS|HANDS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	siemens_coefficient = 0
	permeability_coefficient = 0.05
