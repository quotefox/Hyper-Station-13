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

/obj/item/clothing/suit/shackles
	name = "Plastitanium Shackles"
	desc = "A set of heavy plastitanium shackles, there are chains still attatched"
	icon_state = "shackles"
	item_state = "shackles"
	icon = 'hyperstation/icons/mobs/rewards.dmi'
	alternate_worn_icon = 'hyperstation/icons/mobs/rewards.dmi'
	mutantrace_variation = NO_MUTANTRACE_VARIATION

/obj/item/clothing/suit/luwethtrench
	name = "Syndicate Commander's Coat"
	desc = "A sinister looking black and red jacket. The gold collar and shoulders denote that this belongs to a high ranking syndicate officer. A rather strange brooch is pinned to the coat, displaying a unique range of lustrous brass cracks through the deep blacks of it’s hammered finish."
	icon = 'hyperstation/icons/obj/clothing/rewards.dmi'
	alternate_worn_icon = 'hyperstation/icons/mobs/rewards.dmi'
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	icon_state = "luwethtrench"
	item_state = "luwethtrench"
	mutantrace_variation = NO_MUTANTRACE_VARIATION
	roomy = TRUE

/obj/item/clothing/gloves/ring/luweth
	name = "Luweth’s Wedding Band"
	icon = 'hyperstation/icons/obj/clothing/rewards.dmi'
	icon_state = "luweth"
	desc = "A seemingly natural yet rather rough brass ring, which shows off a unique range of lustrous brass cracks through the deep blacks of it’s hammered finish. 'Till death does us part.'"

/obj/item/dice/d20/blue
	name = "blue d20"
	desc = "Clearly the dice hate you."
	icon_state = "d20_blue"
	sides = 20
	unique = TRUE
