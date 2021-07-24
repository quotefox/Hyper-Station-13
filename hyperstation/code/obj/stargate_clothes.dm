/obj/item/clothing/under/tunic
	name = "Tunic"
	desc = "A simples tunic."
	icon = 'hyperstation/icons/obj/clothing/suits.dmi'
	icon_state = "tunic"
	alternate_worn_icon = 'hyperstation/icons/mobs/suits.dmi'
	item_state = "r_suit"
	can_adjust = FALSE
	mutantrace_variation = NO_MUTANTRACE_VARIATION

/obj/item/khopesh
	name = "khopesh"
	desc = "An sickle-shaped sword that evolved from battle axes"
	icon_state = "khopesh"
	item_state = "khopesh"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	hitsound = 'sound/weapons/bladeslice.ogg'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 30
	throwforce = 10
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	sharpness = IS_SHARP
	max_integrity = 200
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF
	total_mass = TOTAL_MASS_MEDIEVAL_WEAPON

/obj/item/khopesh/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is falling on [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return(BRUTELOSS)