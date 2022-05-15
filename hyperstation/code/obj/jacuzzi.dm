/obj/structure/jacuzzi
	name = "jacuzzi"
	icon = 'hyperstation/icons/obj/jacuzzi.dmi'
	icon_state = "tub"
	desc = "A luxurious pool, but with bubbles!"
	var/filled = TRUE
	density = FALSE
	var/mutable_appearance/waterlower
	var/mutable_appearance/water
	var/mutable_appearance/top
	var/mutable_appearance/mist
	anchored = TRUE

//Dont move, it goes in walls and is shit.
///obj/structure/jacuzzi/attackby(obj/item/W, mob/user, params)
//	if(istype(W, /obj/item/wrench))
//		W.play_tool_sound(src)
//		anchored = !anchored

/obj/structure/jacuzzi/Initialize()
	. = ..()
	top = mutable_appearance('hyperstation/icons/obj/jacuzzi.dmi', "tub_top")
	top.layer = 5
	add_overlay(top)

/obj/structure/jacuzzi/attack_hand(mob/user)
	. = ..()
	filled = !filled
	if(!filled)
		cut_overlay(waterlower)
		cut_overlay(water)
		cut_overlay(mist)
	else
		waterlower = mutable_appearance('hyperstation/icons/obj/jacuzzi.dmi', "water")
		water = mutable_appearance('hyperstation/icons/obj/jacuzzi.dmi', "over_water")
		mist = mutable_appearance('hyperstation/icons/obj/jacuzzi.dmi', "mist")
		waterlower.layer = 3
		water.layer = 10
		mist.layer = 11
		mist.pixel_y = 5
		add_overlay(waterlower)
		add_overlay(water)
		add_overlay(mist)

