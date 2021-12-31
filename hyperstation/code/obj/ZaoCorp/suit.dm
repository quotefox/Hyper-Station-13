/obj/item/clothing/suit/toggle/zao
	name = "zao overcoat"
	desc = "Zao Corps signature navy-blue overcoat with a golden highlight finish. Found among police forces as the suit was designed with riot control in mind, it also serves as modest winter coat insulated padding inside."
	icon = 'hyperstation/icons/obj/clothing/suits.dmi'
	icon_state = "zaocoat"
	item_state = "zaocoat"
	item_color = "zaocoat"
	togglename = "zipper"
	body_parts_covered = CHEST|ARMS|LEGS
	cold_protection = CHEST|GROIN|LEGS|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	strip_delay = 70
	equip_delay_other = 40
	max_integrity = 300
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
	/obj/item/toy,
	/obj/item/twohanded/required/zao/zweihander) // Will be modifying/removing/adding more at a later date.
	actions_types = list(/datum/action/item_action/initialize_zaocorp_suit)

//Will have to add an overlay down the road for the sword appearing on back

	var/obj/item/clothing/head/zao/z_hat
	var/obj/item/clothing/glasses/hud/toggle/zao/z_eye
	var/obj/item/clothing/under/rank/security/zao/z_under
	var/obj/item/twohanded/required/zao/zweihander/z_sword

	var/z_initialized = 0//Suit starts off.
	var/z_coold = 0//If the suit is on cooldown. Can be used to attach different cooldowns to abilities. Ticks down every second based on suit ntick().
	var/z_delay = 40//How fast the suit does certain things, lower is faster. Can be overridden in specific procs. Also determines adverse probability.

	var/z_busy = FALSE
	var/mob/living/carbon/affecting //???? I guess?

/obj/item/clothing/suit/toggle/zao/examine(mob/user)
	. = ..()
	if(z_initialized && user == affecting)
		. += "All systems operational. Currently online and functioning." //Add more data to this later


//This proc prevents the suit from being taken off.
/obj/item/clothing/suit/toggle/zao/proc/lock_suit(mob/living/carbon/human/H)
	if(!istype(H))
		return FALSE
	if(!HAS_TRAIT(H, TRAIT_MINDSHIELD)) //Will turn into weapon permit down the road if I know how to, crying*
		to_chat(H, "<span class='userdanger'>ERROR</span>: 104183 UNABLE TO LOCATE MINDSHIELD\nABORTING...")
		return FALSE
	if(!istype(H.head, /obj/item/clothing/head/zao/))
		to_chat(H, "<span class='userdanger'>ERROR</span>: 100113 UNABLE TO LOCATE HEAD GEAR\nABORTING...")
		return FALSE
	if(!istype(H.glasses, /obj/item/clothing/glasses/hud/toggle/zao/))
		to_chat(H, "<span class='userdanger'>ERROR</span>: 122011 UNABLE TO LOCATE EYE GEAR\nABORTING...")
		return FALSE
	if(!istype(H.w_uniform, /obj/item/clothing/under/rank/security/zao/))
		to_chat(H, "<span class='userdanger'>ERROR</span>: 110223 UNABLE TO LOCATE UNIFORM GEAR\nABORTING...")
		return FALSE
	/*if(!istype(H.back, obj/item/twohanded/required/zao/zweihander/))
		to_chat(H, "<span class='userdanger'>ERROR</span>: 110227 UNABLE TO LOCATE SWORD\nABORTING...")
		return FALSE */ //Will worry about how to manage the sword later
	affecting = H
	ADD_TRAIT(src, TRAIT_NODROP, ZAOCORP_COAT_TRAIT) //colons make me go all |=
	ADD_TRAIT(affecting, TRAIT_ZAOCORP_NOGUNS, ZAOCORP_COAT_TRAIT)
	ADD_TRAIT(affecting, ZAOCORP_AUTHORIZATION, ZAOCORP_COAT_TRAIT)
	z_hat = H.head
	ADD_TRAIT(z_hat, TRAIT_NODROP, ZAOCORP_COAT_TRAIT)
	z_eye = H.glasses
	ADD_TRAIT(z_eye, TRAIT_NODROP, ZAOCORP_COAT_TRAIT)
	z_under = H.w_uniform
	ADD_TRAIT(z_under, TRAIT_NODROP, ZAOCORP_COAT_TRAIT)
	armor = list("melee" = 50, "bullet" = 50, "laser" = 10, "energy" = 30, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 20, "acid" = 60)
	return TRUE

//This proc allows the suit to be taken off.
/obj/item/clothing/suit/toggle/zao/proc/unlock_suit()
	armor = list("melee" = 25, "bullet" = 25, "laser" = 5, "energy" = 15, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 30)
	REMOVE_TRAIT(src, TRAIT_NODROP, ZAOCORP_COAT_TRAIT)
	REMOVE_TRAIT(affecting, TRAIT_ZAOCORP_NOGUNS, ZAOCORP_COAT_TRAIT)
	REMOVE_TRAIT(affecting, ZAOCORP_AUTHORIZATION, ZAOCORP_COAT_TRAIT)
	affecting = null
	if(z_hat)//Should be attached, might not be attached.
		REMOVE_TRAIT(z_hat, TRAIT_NODROP, ZAOCORP_COAT_TRAIT)
	if(z_eye)
		REMOVE_TRAIT(z_eye, TRAIT_NODROP, ZAOCORP_COAT_TRAIT)
	if(z_under)
		REMOVE_TRAIT(z_under, TRAIT_NODROP, ZAOCORP_COAT_TRAIT)

/obj/item/clothing/suit/toggle/zao/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/initialize_zaocorp_suit))
		toggle_on_off()
		return TRUE
	return FALSE


/obj/item/clothing/suit/toggle/zao/process()
	if(!affecting || !z_initialized)
		return PROCESS_KILL/*

	else(damaged_clothes == 1)
		unlock_suit()

	else(affecting.stat == DEAD)
		unlock_suit() */