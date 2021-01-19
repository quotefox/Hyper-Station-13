/obj/item/clothing/head/helmet/space/hardsuit/rd/hev
	name = "HEV Suit helmet"
	desc = "A Hazardous Environment Helmet. It fits snug over the suit and has a heads-up display for researchers. The flashlight seems broken, fitting considering this was made before the start of the milennium."
	icon_state = "hev"
	item_state = "hev"
	item_color = "rd"
	resistance_flags = ACID_PROOF | FIRE_PROOF
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	armor = list("melee" = 30, "bullet" = 10, "laser" = 10, "energy" = 5, "bomb" = 80, "bio" = 100, "rad" = 100, "fire" = 60, "acid" = 60)
	actions_types = list(/datum/action/item_action/toggle_research_scanner)

/obj/item/clothing/suit/space/hardsuit/rd/hev
	name = "HEV Suit"
	desc = "The hazard suit. It was designed to protect scientists from the blunt trauma, radiation, energy discharge that hazardous materials might produce or entail. Fits you like a glove. The automatic medical system seems broken... They're waiting for you, Gordon. In the test chamberrrrrr."
	icon_state = "hev"
	item_state = "hev"
	resistance_flags = ACID_PROOF | FIRE_PROOF
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT //Same as an emergency firesuit. Not ideal for extended exposure.
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/gun/energy/wormhole_projector,
	/obj/item/hand_tele, /obj/item/aicard)
	armor = list("melee" = 30, "bullet" = 10, "laser" = 10, "energy" = 5, "bomb" = 80, "bio" = 100, "rad" = 100, "fire" = 60, "acid" = 60)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/rd/hev
	tauric = FALSE		//Citadel Add for tauric hardsuits
	taurmode = NOT_TAURIC
	var/firstpickup = TRUE

/obj/item/clothing/suit/space/hardsuit/rd/hev/equipped(mob/user, slot)
	. = ..()
	if(!ishuman(user))
		return
	if(slot == SLOT_WEAR_SUIT)
		if(!firstpickup)
			SEND_SOUND(user, sound('hyperstation/sound/halflife/hevsuit_pickup.ogg', volume = 50))
		else
			firstpickup = FALSE
			SEND_SOUND(user, sound('hyperstation/sound/halflife/hevsuit_firstpickup.ogg', volume = 50))
			SEND_SOUND(user, sound('hyperstation/sound/halflife/anomalous_materials.ogg', volume = 50))
	return

/obj/item/clothing/suit/space/hardsuit/shielded/goldenpa
	name = "Kinaris Power Armor"
	desc = "An advanced armor with built in energy shielding, developed by Kinaris via unknown means. It belongs by only few exclusive members of the corporation."
	icon_state = "golden_pa"
	item_state = "golden_pa"
	max_charges = 4
	current_charges = 4
	recharge_delay = 15
	armor = list("melee" = 80, "bullet" = 80, "laser" = 50, "energy" = 50, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	strip_delay = 130
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	allowed = list(/obj/item/gun, /obj/item/ammo_box, /obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/melee/transforming/energy/sword/saber, /obj/item/restraints/handcuffs, /obj/item/tank/internals)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/shielded/goldenpa
	slowdown = 0
	tauric = TRUE		//Citadel Add for tauric hardsuits

/obj/item/clothing/suit/space/hardsuit/shielded/goldenpa/Initialize()
	jetpack = new /obj/item/tank/jetpack/suit(src)
	. = ..()

/obj/item/clothing/head/helmet/space/hardsuit/shielded/goldenpa
	name = "Kinaris Power Helmet"
	desc = "An advanced armor helmet with built in energy shielding, developed by Kinaris via unknown means. It belongs by only few exclusive members of the corporation."
	icon_state = "hardsuit0-goldenpa"
	item_state = "hardsuit0-goldenpa"
	item_color = "goldenpa"
	armor = list("melee" = 80, "bullet" = 80, "laser" = 50, "energy" = 50, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	strip_delay = 130
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT