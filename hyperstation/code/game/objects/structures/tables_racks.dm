/obj/structure/table/wood/fancy/kinaris
	icon =	'hyperstation/icons/obj/structures.dmi'
	icon_state = "fancy_table_kinaris"
	buildstack = /obj/item/stack/tile/carpet/kinaris
	canSmoothWith = list(/obj/structure/table/wood/fancy/kinaris)

/obj/structure/table/wood/fancy/kinaris/New()
	. = ..()
	icon = 'hyperstation/icons/obj/smooth_structures/fancy_table_kinaris.dmi'
