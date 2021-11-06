//This is the SYSuit, effectively a way for micros to dominate larger partners. Adminbus only right now, but will soon be purchasable via cargo with a preference to opt into, to prevent abuse.
//It will also have a charge function in the future and further balance passing.
//SYTech, pronounced as Sigh Tech; like what am I doing with my life?
//TO DO: make things a little more optimized and put everything under it's own "SY" obj, so we can get rid of some redundancy
//HEAVY WIP, expect this to be done soon!

//The suit itself
/obj/item/clothing/under/syclothing
	name = "SYTech Nanoweave suit"
	desc = "A leading-grade suit developed by SYTech, with an internal dampening field to lessen accidents at micro scales. This one seems to be more skimpy and developed for bedroom-play, though."
	icon = 'hyperstation/icons/obj/clothing/uniforms.dmi'
	icon_state = "syclothing"
	item_state = "syclothing"
	//alternate_worn_icon = 'hyperstation/icons/mobs/uniforms.dmi'
	armor = list("melee" = 90, "bullet" = 25, "laser" = 5, "energy" = 15, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 75, "acid" = 90)
	do_not_cover_butt = TRUE
	can_adjust = FALSE

	actions_types = list(/datum/action/item_action/initialize_sysuit)

	//var/obj/whateverkinkyitemiputhere

	//The whole getup needs to be worn! Variables referenced for later
	var/obj/item/clothing/head/sycap/sy_cap
	var/obj/item/clothing/glasses/hud/toggle/syvisor/sy_visor
	var/obj/item/clothing/shoes/syshoes/sy_shoes
	var/obj/item/clothing/gloves/sygloves/sy_gloves

	var/s_initialized = 0 //Suit starts off
	var/s_coold = 0 //If the suit is on cooldown. Can be used to attach different cooldowns to abilities. Ticks down every second based on suit ntick().
	var/s_delay = 40//How fast the suit does certain things, lower is faster. Can be overridden in specific procs. Also determines adverse probability.

	var/s_busy = FALSE
	var/mob/living/carbon/affecting //???? i hate byond

/obj/item/clothing/under/syclothing/examine(mob/user)
	. = ..()
	if(s_initialized && user == affecting)
		. += "All systems operational. Currently online and functioning." //Add more data to this later

//The overcoat - removed cause i was a little too lazy to make a proper sprite for it lmao
/*
/obj/item/clothing/suit/toggle/sysuit
	name = "SYTech Nanoweave overcoat"
	desc = "An overcoat complimenting a SYTech suit. Can be worn in different ways, but is required for the function of the Nanoweave tech. This one is incredibly revealing, oddly enough."
	icon = 'hyperstation/icons/obj/clothing/suits.dmi'
	icon_state = "sysuit"
	item_state = "sysuit"
	//alternate_worn_icon = 'hyperstation/icons/mobs/suits.dmi'
	togglename = "zipper"
	body_parts_covered = CHEST|ARMS|LEGS
	cold_protection = CHEST|GROIN|LEGS|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	strip_delay = 70
	equip_delay_other = 40
	max_integrity = 250
	resistance_flags = FLAMMABLE
	armor = list("melee" = 90, "bullet" = 25, "laser" = 5, "energy" = 15, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 75, "acid" = 90)
*/


//The cap
/obj/item/clothing/head/sycap
	name = "SYTech Nanoweave cap"
	desc = "A piece of clothing for a SYTech suit, allowing for extended control and breathability at micro scales via amplified hardlight respiration. This one seems to be modeled like a dominatrix cap, however."
	icon = 'hyperstation/icons/obj/clothing/head.dmi'
	icon_state = "sycap"
	item_state = "sycap"
	alternate_worn_icon = 'hyperstation/icons/mobs/head.dmi'
	armor = list("melee" = 90, "bullet" = 25, "laser" = 5, "energy" = 15, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 75, "acid" = 90)
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	strip_delay = 60
	resistance_flags = FLAMMABLE

	var/cloaked = 0

/obj/item/clothing/head/sycap/dropped()
	src.icon_state = "sycap"
	src.cloaked=0
	..()

/obj/item/clothing/head/sycap/verb/cloakcap()
	set category = "Object"
	set name = "Cloak hat"

	cloak(usr)


/obj/item/clothing/head/sycap/AltClick(mob/user)
	. = ..()
	if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	cloak(user)
	return TRUE


/obj/item/clothing/head/sycap/proc/cloak(mob/user)
	if(!user.incapacitated())
		src.cloaked = !src.cloaked
		if(src.cloaked)
			icon_state = "sycap_active"
			to_chat(user, "<span class='notice'>You toggle the hat\'s cloaking.</span>")
		else
			icon_state = "sycap"
			to_chat(user, "<span class='notice'>You reveal the hat again.</span>")
		usr.update_inv_head()	//so our mob-overlays update

/obj/item/clothing/head/sycap/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-click the hat to toggle it\'s cloaking [cloaked ? "off" : "on"].</span>"

//The visor
/obj/item/clothing/glasses/hud/toggle/syvisor
	name = "SYTech Analysis Visor"
	desc = "A high-tech visor developed for SYTech suits, for helping internal processes lead augment decisions. This one looks like a pair of darkened sunglasses."
	icon = 'hyperstation/icons/obj/clothing/glasses.dmi'
	icon_state = "syvisor"
	item_state = "trayson-meson"
	flash_protect = 1
	tint = 1
	flags_cover = GLASSESCOVERSEYES
	visor_flags_cover = GLASSESCOVERSEYES
	alternate_worn_icon =  'hyperstation/icons/mobs/eyes.dmi'
	hud_type = DATA_HUD_DIAGNOSTIC_ADVANCED
	actions_types = list(/datum/action/item_action/switch_hud)
	glass_colour_type = /datum/client_colour/glass_colour/purple
    //effectively the same thing as a Zao HUD, but required for SYTech to work. More or less for flavor.

/obj/item/clothing/glasses/hud/toggle/syvisor/attack_self(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/wearer = user
	if (wearer.glasses != src)
		return

	if (hud_type)
		var/datum/atom_hud/H = GLOB.huds[hud_type]
		H.remove_hud_from(user)

	if (hud_type == DATA_HUD_DIAGNOSTIC_ADVANCED)
		icon_state = "zaovisor_off"
		item_state = "zaovisor_off"
		hud_type = null
		flash_protect = 0
		tint = 0
		change_glass_color(user, /datum/client_colour/glass_colour/white)
	else
		hud_type = DATA_HUD_DIAGNOSTIC_ADVANCED
		icon_state = "syvisor"
		item_state = "syvisor"
		flash_protect = 1
		tint = 1
		change_glass_color(user, /datum/client_colour/glass_colour/purple)

	if (hud_type)
		var/datum/atom_hud/H = GLOB.huds[hud_type]
		H.add_hud_to(user)
	user.update_inv_glasses()


//Shoes
/obj/item/clothing/shoes/syshoes
	name = "SYTech Nanoweave platform heels"
	desc = "A complimentary piece of SYTech apparel for gravity-altering applications. It even allows you to walk up walls! This pair takes on the appearance of skimpy, thigh-high latex boots with stilletos."
	icon_state = "syshoes"
	item_state = "syshoes"
	icon = 'hyperstation/icons/obj/clothing/shoes.dmi'
	//alternate_worn_icon = 'hyperstation/icons/mobs/feet.dmi'

/obj/item/clothing/shoes/syshoes/Initialize()
	. = ..()
	AddComponent(/datum/component/squeak, list('sound/effects/footstep/highheel1.ogg' = 1,'sound/effects/footstep/highheel2.ogg' = 1), 20)

//Gloves
/obj/item/clothing/gloves/sygloves
	name = "SYTech Nanoweave sleeves"
	desc = "A pair of enhanced sleeves, developed by SYTech. These allow remote and psionic levels of manipulation to the electrical currents inside living beings, or objects. Use with caution!"
	icon_state = "sygloves"
	item_state = "sygloves"
	icon = 'hyperstation/icons/obj/clothing/gloves.dmi'
	alternate_worn_icon = 'hyperstation/icons/mobs/gloves.dmi'
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	strip_delay = 120
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	mutantrace_variation = NO_MUTANTRACE_VARIATION