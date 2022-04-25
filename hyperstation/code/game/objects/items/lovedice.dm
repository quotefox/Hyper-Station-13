/* 
lover's dice: based off a really funny yakuza gif i saw on tumblr years ago
these give suggestions for sex acts to perform. it's stupid but fun.

sarcoph mar 2022
*/

// dice bag

/obj/item/storage/pill_bottle/lovedice
	name = "bag of love dice"
	desc = "Contains all the intimate ideas you'll ever need. A game that everyone wins!"
	icon = 'hyperstation/icons/obj/toy.dmi'
	icon_state = "lovedicebag"
	price = 1

/obj/item/storage/pill_bottle/lovedice/Initialize()
	. = ..()
	new /obj/item/dice/lover/d6_gesture(src)
	new /obj/item/dice/lover/d6_location(src)
	new /obj/item/dice/lover/d6_action(src)
	new /obj/item/dice/lover/d6_bodypart(src)


// dice

/obj/item/dice/lover
	desc = "A die with six sides to inspire some bedroom action."
	icon = 'hyperstation/icons/obj/toy.dmi'
	sides = 6

/obj/item/dice/lover/update_icon()
	return // override the dice proc for this, there is no overlay

/obj/item/dice/lover/examine(mob/user)
	. = ..() // again, no overlays
	. += "<span class='notice'>The top reads [result].</span>"


// actual dice

/obj/item/dice/lover/d6_gesture
	name = "lover's d6 (v1)"
	icon_state = "loved6_1"
	special_faces = list(
		"Let's hug",
		"Let's kiss",
		"Let's play",
		"Let's fuck", // it actually says "let's do it" on the irl ones lol
		"Let's wrestle",
		"Let's ?"
	)

/obj/item/dice/lover/d6_location
	name = "lover's d6 (v2)"
	icon_state = "loved6_2"
	special_faces = list(
		"On a chair",
		"On the bed",
		"On the floor",
		"In the closet",
		"In the bathtub",
		"In the ?"
	)

/obj/item/dice/lover/d6_action
	name = "lover's d6 (v3)"
	icon_state = "loved6_3"
	special_faces = list(
		"Caress my",
		"Kiss my",
		"Grab my",
		"Rub my",
		"Tickle my",
		"Surprise!"
	)

/obj/item/dice/lover/d6_bodypart
	name = "lover's d6 (v4)"
	icon_state = "loved6_4"
	special_faces = list(
		"Back",
		"Chest",
		"Face",
		"Ass",
		"Genitals",
		"Surprise!"
	)