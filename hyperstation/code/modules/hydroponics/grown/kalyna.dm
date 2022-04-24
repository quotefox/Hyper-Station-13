// Kalyna Berries
/obj/item/seeds/kalyna
	name = "pack of kalyna berry seeds"
	desc = "Seeds that grow into Kalyna plants. Take that Red Kalyna and rise it up."
	icon = 'hyperstation/icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-kalyna"
	species = "kalyna"
	plantname = "Kalyna Shrub Tree"
	product = /obj/item/reagent_containers/food/snacks/grown/kalyna
	lifespan = 20
	maturation = 5
	production = 5
	growthstages = 5
	yield = 4
	growing_icon = 'hyperstation/icons/obj/hydroponics/growing_fruits.dmi'
	icon_grow = "kalyna-grow"
	icon_dead = "kalyna-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/reagent_containers/food/snacks/grown/kalyna
	seed = /obj/item/seeds/kalyna
	name = "branch of kalyna"
	desc = "Red berries, attached to a branch. Just looking at it makes you feel an aura of unity."
	icon = 'hyperstation/icons/obj/hydroponics/harvest.dmi'
	icon_state = "kalynaberries"
	gender = PLURAL
	filling_color = "#FF0000"
	bitesize_mod = 2
	foodtype = FRUIT
	juice_results = list(/datum/reagent/consumable/kalynajuice = 1)
	tastes = list("sweet cranberries" = 1)
	distill_reagent = /datum/reagent/consumable/ethanol/gin

//For those of you wondering, yes, this is very much an addition in support of Ukraine. I decided to make these after a distant Ukranian relative of mine sent me Go_A's 'Kalyna' song.
//Our future as a free world could very well depend on the heroism of the people of glorious Ukraine. We owe our freedom to them.
//I know that this game should be for escapism, but there's only so much we should escape from. When people's lives are being upturned-- Or taken by a brutal invasive reigime, perhaps then it's when we should take a stand.
//And for those that oppose the freedom of the people of Ukraine, Russia, and Belarus; Prykhyl'nyk Putina, idy na khuy. And show some basic empathy for once, it's not that hard.
//Glory to Ukraine, Glory to the Heroes!
// - Arctaisia, Hyperstation developer and spriter, 23/04/2022 #StandWithUkraine
