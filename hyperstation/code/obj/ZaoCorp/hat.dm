/obj/item/clothing/head/zao
	name = "zao police cap"
	desc = "Zao Corps standard issue police force headwear, designed with the overcoat to help with the cold weather. The headwear also features a holographic projector, allowing itself to blend in with the user to create a better face to face interaction with civilians."
	icon = 'hyperstation/icons/obj/clothing/head.dmi'
	icon_state = "zaohat"
	item_state = "helmet"
	item_color = "zaohat"
	alternate_worn_icon = 'hyperstation/icons/mobs/head.dmi'
	armor = list("melee" = 40, "bullet" = 40, "laser" = 10,"energy" = 20, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 20, "acid" = 60)
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	strip_delay = 60
	resistance_flags = FLAMMABLE

	var/cloaked = 0

/obj/item/clothing/head/zao/dropped()
	src.icon_state = "zaohat"
	src.cloaked=0
	..()

/obj/item/clothing/head/zao/verb/cloakcap()
	set category = "Object"
	set name = "Cloak hat"

	cloak(usr)


/obj/item/clothing/head/zao/AltClick(mob/user)
	. = ..()
	if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	cloak(user)
	return TRUE


/obj/item/clothing/head/zao/proc/cloak(mob/user)
	if(!user.incapacitated())
		src.cloaked = !src.cloaked
		if(src.cloaked)
			icon_state = "zaohat_active"
			to_chat(user, "<span class='notice'>You toggle the hat\'s cloaking.</span>")
		else
			icon_state = "zaohat"
			to_chat(user, "<span class='notice'>You reveal the hat again.</span>")
		usr.update_inv_head()	//so our mob-overlays update

/obj/item/clothing/head/zao/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-click the hat to toggle it\'s cloaking [cloaked ? "off" : "on"].</span>"