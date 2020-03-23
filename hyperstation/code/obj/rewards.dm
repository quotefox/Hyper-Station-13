/obj/item/pen/bluemarker
	name = "blue marker"
	desc = "A simple blueberry scented marker."
	icon_state = "marker_blue"
	colour = "blue"

/obj/item/pen/bluemarker/attack_self(mob/user)
	user.emote("sniff")
	to_chat(user, "<span class='notice'>Ahh~ blueberries!</span>")

/obj/item/clothing/suit/napoleonic
	name = "napoleonic uniform"
	desc = "An heirloom passed down from the Gruber family dynasty."
	icon_state = "napoleonic"
	item_state = "napoleonic"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
