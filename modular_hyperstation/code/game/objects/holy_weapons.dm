/obj/item/nullrod/hypertool
	icon = 'icons/obj/device.dmi'
	icon_state = "hypertool"
	item_state = "hypertool"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	name = "hypertool"
	desc = "A tool so powerful even you cannot perfectly use it."
	armour_penetration = 35
	damtype = BRAIN
	attack_verb = list("pulsed", "mended", "cut")
	hitsound = 'sound/effects/sparks4.ogg'

/obj/item/nullrod/spear
	name = "ancient spear"
	desc = "An ancient spear made of brass, I mean gold, I mean bronze."
	icon_state = "ratvarian_spear"
	item_state = "ratvarian_spear"
	lefthand_file = 'icons/mob/inhands/antag/clockwork_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/clockwork_righthand.dmi'
	icon = 'icons/obj/clockwork_objects.dmi'
	slot_flags = ITEM_SLOT_BELT
	armour_penetration = 10
	sharpness = IS_SHARP_ACCURATE
	w_class = WEIGHT_CLASS_BULKY
	attack_verb = list("stabbed", "poked", "slashed", "clocked")
	hitsound = 'sound/weapons/bladeslice.ogg'
