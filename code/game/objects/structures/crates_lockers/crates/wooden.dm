/obj/structure/closet/crate/wooden
	name = "wooden crate"
	desc = "Works just as well as a metal one."
	material_drop = /obj/item/stack/sheet/mineral/wood
	material_drop_amount = 6
	icon_state = "wooden"

/obj/structure/closet/crate/wooden/toy
	name = "toy box"
	desc = "It has the words \"Clown + Mime\" written underneath of it with marker."

/obj/structure/closet/crate/wooden/toy/PopulateContents()
	. = ..()
	new	/obj/item/megaphone/clown(src)
	new	/obj/item/reagent_containers/food/drinks/soda_cans/canned_laughter(src)
	new /obj/item/pneumatic_cannon/pie(src)
	new /obj/item/reagent_containers/food/snacks/pie/cream(src)
	new /obj/item/storage/crayons(src)

/obj/structure/closet/crate/shadoww
	name = "shadown wood crate"
	desc = "Works just as well as a metal one."
	material_drop = /obj/item/stack/sheet/mineral/shadoww
	material_drop_amount = 6
	icon_state = "shadoww"

/obj/structure/closet/crate/plaswood
	name = "plaswood crate"
	desc = "Works just as well as a metal one."
	material_drop = /obj/item/stack/sheet/mineral/plaswood
	material_drop_amount = 6
	icon_state = "plaswood"

/obj/structure/closet/crate/gmushroom
	name = "mushroom crate"
	desc = "Works just as well as a metal one."
	material_drop = /obj/item/stack/sheet/mineral/gmushroom
	material_drop_amount = 6
	icon_state = "gmushroom"
