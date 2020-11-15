//Archie was here

/obj/item/clothing/glasses/polychromic
	name = "polychromic glasses template"
	desc = "You shouldn't be seeing this. Report it if you do."
	icon = 'hyperstation/icons/obj/clothing/glasses.dmi'
	icon_state = "polygar"
	item_color = "polygar"
	item_state = "polygar"
	alternate_worn_icon = 'hyperstation/icons/mob/eyes.dmi' //Because, as it appears, the item itself is normally not directly aware of its worn overlays, so this is about the easiest way, without adding a new var.
	hasprimary = TRUE
	primary_color = "#0c0c0c"
	vision_correction = 1

/obj/item/clothing/glasses/polychromic/worn_overlays(isinhands, icon_file)	//this is where the main magic happens. Also mandates that ALL polychromic stuff MUST USE alternate_worn_icon
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

/obj/item/clothing/glasses/polychromic/garpoly
	name = "polychromic gar glasses"
	desc = "Go beyond impossible and kick reason to the curb! Doesn't seem to have flash protection and doesn't seem sharp either. It is made out of bluespace prescription glass though."

/obj/item/clothing/glasses/polychromic/supergarpoly
	name = "polychromic giga gar glasses"
	desc = "Believe in the you who believes in yourself. Also doesn't seem to have flash protection and doesn't seem sharp either. It is made out of bluespace prescription glass though."
	icon_state = "polysupergar"
	item_color = "polysupergar"
	item_state = "polysupergar"
