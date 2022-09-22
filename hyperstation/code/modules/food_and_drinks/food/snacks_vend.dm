/obj/item/reagent_containers/food/snacks/raccsnacc
	name = "racc snacc"
	desc = "A tastey snack within a pack... Wait, this is just shredded cheese."
	icon_state = "raccsnacc"
	trash = /obj/item/trash/chips
	bitesize = 1
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	junkiness = 40 //super junky, its a raccon snack
	filling_color = "#FFD700"
	tastes = list("cheese" = 1)
	foodtype = JUNKFOOD | DAIRY
	price = 2