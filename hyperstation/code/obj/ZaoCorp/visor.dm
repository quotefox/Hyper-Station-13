/obj/item/clothing/glasses/hud/toggle/zao
	name = "zao security visor"
	desc = "A security visor from ZaoCorp designed to deploy and retract it's visor on a whim."
	icon = 'hyperstation/icons/obj/clothing/glasses.dmi'
	icon_state = "zaovisor"
	item_state = "trayson-meson"
	flash_protect = 1
	tint = 1
	flags_cover = GLASSESCOVERSEYES
	visor_flags_cover = GLASSESCOVERSEYES
	alternate_worn_icon =  'hyperstation/icons/mobs/eyes.dmi'
	hud_type = DATA_HUD_SECURITY_ADVANCED
	actions_types = list(/datum/action/item_action/switch_hud)
	glass_colour_type = /datum/client_colour/glass_colour/lightyellow

/obj/item/clothing/glasses/hud/toggle/zao/attack_self(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/wearer = user
	if (wearer.glasses != src)
		return

	if (hud_type)
		var/datum/atom_hud/H = GLOB.huds[hud_type]
		H.remove_hud_from(user)

	if (hud_type == DATA_HUD_SECURITY_ADVANCED)
		icon_state = "zaovisor_off"
		item_state = "zaovisor_off"
		hud_type = null
		flash_protect = 0
		tint = 0
		change_glass_color(user, /datum/client_colour/glass_colour/white)
	else
		hud_type = DATA_HUD_SECURITY_ADVANCED
		icon_state = "zaovisor"
		item_state = "zaovisor"
		flash_protect = 1
		tint = 1
		change_glass_color(user, /datum/client_colour/glass_colour/lightyellow)

	if (hud_type)
		var/datum/atom_hud/H = GLOB.huds[hud_type]
		H.add_hud_to(user)
	user.update_inv_glasses()
