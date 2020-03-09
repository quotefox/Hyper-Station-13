// Pear
/obj/item/seeds/pear
	name = "pack of pear seeds"
	desc = "They're seeds that grow into pear trees. When grown."
	icon = 'hyperstation/icons/hydroponics/seeds.dmi'
	icon_state = "seed-pear"
	species = "pear"
	plantname = "Pear tree"
	product = /obj/item/reagent_containers/food/snacks/grown/pear
	lifespan = 50
	endurance = 30
	growing_icon = 'hyperstation/icons/hydroponics/growing_fruits.dmi'
	icon_dead = "pear-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list("pearjuice" = 0.1, "vitamin" = 0.04, "nutriment" = 0.02)

/obj/item/reagent_containers/food/snacks/grown/pear
	seed = /obj/item/seeds/pear
	name = "pear"
	desc = "It's a delicous fresh grown pear."
	icon_state = "pear"
	item_state = "pear"
	filling_color = "#FFFF00"
	bitesize = 5
	foodtype = FRUIT
	juice_results = list("pearjuice" = 0)
