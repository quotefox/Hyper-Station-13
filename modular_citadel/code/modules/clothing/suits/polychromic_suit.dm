/obj/item/clothing/suit/polychromic //enables all three overlays to reduce copypasta and defines basic stuff
	name = "Kromatose Jacket"
	desc = "A polychromatic jacket"
	icon = 'modular_citadel/icons/polyclothes/item/suit.dmi'
	alternate_worn_icon = 'modular_citadel/icons/polyclothes/mob/suit.dmi'
	icon_state = "kromajacket"
	item_color = "kromajacket"
	item_state = "militaryjacket"
	hasprimary = TRUE
	hassecondary = TRUE
	hastertiary = TRUE
	primary_color = "#FFFFFF" //RGB in hexcode
	secondary_color = "#FFFFFF"
	tertiary_color = "#808080"
	mutantrace_variation = NO_MUTANTRACE_VARIATION

/obj/item/clothing/suit/polychromic/worn_overlays(isinhands, icon_file)	//this is where the main magic happens. Also mandates that ALL polychromic stuff MUST USE alternate_worn_icon
	. = ..()
	if(hasprimary | hassecondary | hastertiary)
		if(!isinhands)	//prevents the worn sprites from showing up if you're just holding them
			if(hasprimary)	//checks if overlays are enabled
				var/mutable_appearance/primary_worn = mutable_appearance(alternate_worn_icon, "[item_color]-primary")	//automagical sprite selection
				primary_worn.color = primary_color	//colors the overlay
				. += primary_worn	//adds the overlay onto the buffer list to draw on the mob sprite.
			if(hassecondary)
				var/mutable_appearance/secondary_worn = mutable_appearance(alternate_worn_icon, "[item_color]-secondary")
				secondary_worn.color = secondary_color
				. += secondary_worn
			if(hastertiary)
				var/mutable_appearance/tertiary_worn = mutable_appearance(alternate_worn_icon, "[item_color]-tertiary")
				tertiary_worn.color = tertiary_color
				. += tertiary_worn

/obj/item/clothing/suit/polychromic/kromajacket
	name = "Kromatose Military Jacket"
	desc = "A polychromatic jacket, in the military style"
	icon_state = "kromajacket"
	item_color = "kromajacket"
	item_state = "militaryjacket"
	primary_color = "#FFFFFF" //RGB in hexcode
	secondary_color = "#353535"
	tertiary_color = "#353535"
	body_parts_covered= CHEST|GROIN|ARMS
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/gun/ballistic/automatic/pistol, /obj/item/gun/ballistic/revolver, /obj/item/radio)

/obj/item/clothing/suit/polychromic/kromacrop
	name = "Kromatose Short Jacket"
	desc = "A short polychromatic jacket, in the military style"
	icon_state = "kromacrop"
	item_color = "kromacrop"
	item_state = "militaryjacket"
	primary_color = "#FFFFFF" //RGB in hexcode
	secondary_color = "#353535"
	tertiary_color = "#353535"
	body_parts_covered= CHEST|GROIN|ARMS
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/gun/ballistic/automatic/pistol, /obj/item/gun/ballistic/revolver, /obj/item/radio)
