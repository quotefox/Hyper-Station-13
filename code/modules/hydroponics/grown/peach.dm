// Peach
/obj/item/seeds/peach
	name = "pack of peach seeds"
	desc = "These seeds grow into peach trees."
	icon_state = "seed-peach"
	species = "peach"
	plantname = "Peach Tree"
	product = /obj/item/reagent_containers/food/snacks/grown/peach
	lifespan = 65
	endurance = 40
	yield = 3
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_grow = "peach-grow"
	icon_dead = "peach-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/peach/boob)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/reagent_containers/food/snacks/grown/peach
	seed = /obj/item/seeds/peach
	name = "peach"
	desc = "It's fuzzy!"
	icon_state = "peach"
	filling_color = "#FF4500"
	bitesize = 25
	foodtype = FRUIT
	juice_results = list(/datum/reagent/consumable/peachjuice = 0)
	tastes = list("peach" = 1)

// Boob Peach
/obj/item/seeds/peach/boob
	name = "pack of boob peach seeds"
	desc = "These seeds grow into boob peach trees. Beloved by members of the itty bitty titty commitee"
	icon_state = "seed-boobpeach"
	species = "boobpeach"
	plantname = "Boob Peach Tree"
	product = /obj/item/reagent_containers/food/snacks/grown/peach/boob
	maturation = 10
	production = 10
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/slip)
	mutatelist = list()
	reagents_add = list(/datum/reagent/fermi/breast_enlarger = 0.2, /datum/reagent/drug/aphrodisiacplus = 0.1, /datum/reagent/consumable/milk = 0.1)

/obj/item/reagent_containers/food/snacks/grown/peach/boob
	seed = /obj/item/seeds/peach/boob
	name = "boob peach"
	desc = "It has a soft oily skin, and it seems to be secreting a thick white goo"
	icon_state = "boobpeach"
	filling_color = "#F3A463"
	distill_reagent = /datum/reagent/fermi/breast_enlarger
	wine_power = 30
