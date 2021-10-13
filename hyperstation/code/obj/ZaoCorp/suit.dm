/obj/item/clothing/suit/toggle/zao
	name = "zao overcoat"
	desc = "Zao Corps signature navy-blue overcoat with a golden highlight finish. Found among police forces as the suit was designed with riot control in mind, it also serves as modest winter coat insulated padding inside."
	icon = 'hyperstation/icons/obj/clothing/suits.dmi'
	icon_state = "zaocoat"
	item_state = "zaocoat"
	item_color = "zaocoat"
	alternate_worn_icon = 'hyperstation/icons/mobs/suits.dmi'
	togglename = "zipper"
	body_parts_covered = CHEST|ARMS|LEGS
	cold_protection = CHEST|GROIN|LEGS|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	strip_delay = 70
	equip_delay_other = 40
	max_integrity = 250
	resistance_flags = FLAMMABLE
	armor = list("melee" = 25, "bullet" = 25, "laser" = 5, "energy" = 15, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 30)
	// armor = list("melee" = 50, "bullet" = 50, "laser" = 10, "energy" = 30, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 20, "acid" = 60)
	allowed = list(/obj/item/ammo_box,
	/obj/item/ammo_casing,
	/obj/item/flashlight,
	/obj/item/storage/fancy/cigarettes,
	/obj/item/gun/ballistic,
	/obj/item/gun/energy,
	/obj/item/lighter,
	/obj/item/melee/baton,
	/obj/item/melee/classic_baton/telescopic,
	/obj/item/reagent_containers/spray/pepper,
	/obj/item/restraints/handcuffs,
	/obj/item/tank/internals/emergency_oxygen,
	/obj/item/tank/internals/plasmaman,
	/obj/item/toy) // Will be modifying/removing/adding more at a later date.