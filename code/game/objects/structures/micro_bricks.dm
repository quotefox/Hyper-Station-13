/obj/structure/micro_brick
	icon = 'icons/obj/small_world.dmi'

/obj/structure/micro_brick/road_fourway
	name = "Road fourway"
	desc = "roundabouts are better!"
	icon_state = "roadfourway"
	anchored = TRUE
	resistance_flags = FLAMMABLE
	max_integrity = 100
	integrity_failure = 30
	var/buildstacktype = /obj/item/stack/sheet/metal
	var/buildstackamount = 2

/obj/structure/micro_brick/road_threeway
	name = "Road threeway"
	desc = "Ill take the back you get the front."
	icon_state = "roadthreeway"
	anchored = TRUE
	resistance_flags = FLAMMABLE
	max_integrity = 100
	integrity_failure = 30
	var/buildstacktype = /obj/item/stack/sheet/metal
	var/buildstackamount = 2

/obj/structure/micro_brick/road_straight
	name = "Road straight"
	desc = "Is it gay if the balls touch?"
	icon_state = "roadstraight"
	anchored = TRUE
	resistance_flags = FLAMMABLE
	max_integrity = 100
	integrity_failure = 30
	var/buildstacktype = /obj/item/stack/sheet/metal
	var/buildstackamount = 2


/obj/structure/micro_brick/Road_turn
	name = "Road turn"
	desc = "Bending the Rules."
	//i cannot find a joke for this :(
	icon_state = "roadturn"
	anchored = TRUE
	resistance_flags = FLAMMABLE
	max_integrity = 100
	integrity_failure = 30
	var/buildstacktype = /obj/item/stack/sheet/metal
	var/buildstackamount = 2

/obj/structure/micro_brick/small_house
	name = "Small houses"
	desc = "Lets hope this household does their taxes!"
	icon_state = "smallhouses"
	anchored = TRUE
	resistance_flags = FLAMMABLE
	max_integrity = 100
	integrity_failure = 30
	var/buildstacktype = /obj/item/stack/sheet/metal
	var/buildstackamount = 2

/obj/structure/micro_brick/small_business
	name = "Small business"
	desc = "A place for not many 9's with how many 5's"
	icon_state = "smallbusiness"
	anchored = TRUE
	resistance_flags = FLAMMABLE
	max_integrity = 100
	integrity_failure = 30
	var/buildstacktype = /obj/item/stack/sheet/metal
	var/buildstackamount = 2

/obj/structure/micro_brick/small_warehouse
	name = "Small warehouse"
	desc = "The house has been exposed to the moon light and is now a warehouse!"
	// https://i.redd.it/4ke5819c2ib61.jpg
	icon_state = "warehouse"
	anchored = TRUE
	resistance_flags = FLAMMABLE
	max_integrity = 100
	integrity_failure = 30
	var/buildstacktype = /obj/item/stack/sheet/metal
	var/buildstackamount = 2

/obj/structure/micro_brick/small_museum
	name = "Small museum"
	desc = "A place to store old and small relics found around the station "
	icon_state = "smallmuseum"
	anchored = TRUE
	resistance_flags = FLAMMABLE
	max_integrity = 100
	integrity_failure = 30
	var/buildstacktype = /obj/item/stack/sheet/metal
	var/buildstackamount = 2

/obj/item/micro_brick/moon
	name = "Small moon"
	icon_state = "smallmoon"
	icon = 'icons/obj/small_world.dmi'
	desc = "You now have the power of the moon on your side"
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	force = 0
	total_mass = TOTAL_MASS_TINY_ITEM