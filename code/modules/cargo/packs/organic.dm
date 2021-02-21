
//Reminders-
// If you add something to this list, please group it by type and sort it alphabetically instead of just jamming it in like an animal
// cost = 700- Minimum cost, or infinite points are possible.
//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Organic /////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/organic
	group = "Food & Hydroponics"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/organic/hydroponics/beekeeping_suits
	name = "Beekeeper Suit Crate"
	desc = "Bee business booming? Better be benevolent and boost botany by bestowing bi-Beekeeper-suits! Contains two beekeeper suits and matching headwear."
	cost = 1300
	contains = list(/obj/item/clothing/head/beekeeper_head,
					/obj/item/clothing/suit/beekeeper_suit,
					/obj/item/clothing/head/beekeeper_head,
					/obj/item/clothing/suit/beekeeper_suit)
	crate_name = "beekeeper suits"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/organic/hydroponics/beekeeping_fullkit
	name = "Beekeeping Starter Crate"
	desc = "BEES BEES BEES. Contains three honey frames, a beekeeper suit and helmet, flyswatter, bee house, and, of course, a pure-bred Kinaris-Standardized Queen Bee!"
	cost = 1800
	contains = list(/obj/structure/beebox/unwrenched,
					/obj/item/honey_frame,
					/obj/item/honey_frame,
					/obj/item/honey_frame,
					/obj/item/queen_bee/bought,
					/obj/item/clothing/head/beekeeper_head,
					/obj/item/clothing/suit/beekeeper_suit,
					/obj/item/melee/flyswatter)
	crate_name = "beekeeping starter crate"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/organic/candy/randomised
	name = "Candy Crate"
	desc = "For people that have a insatiable sweet tooth! Has ten candies to be eaten up.."
	cost = 2500
	var/num_contained = 10 //number of items picked to be contained in a randomised crate
	contains = list(/obj/item/reagent_containers/food/snacks/candy,
					/obj/item/reagent_containers/food/snacks/lollipop,
					/obj/item/reagent_containers/food/snacks/gumball,
					/obj/item/reagent_containers/food/snacks/chocolateegg,
					/obj/item/reagent_containers/food/snacks/donut,
					/obj/item/reagent_containers/food/snacks/cookie,
					/obj/item/reagent_containers/food/snacks/sugarcookie,
					/obj/item/reagent_containers/food/snacks/chococornet,
					/obj/item/reagent_containers/food/snacks/mint,
					/obj/item/reagent_containers/food/snacks/spiderlollipop,
					/obj/item/reagent_containers/food/snacks/chococoin,
					/obj/item/reagent_containers/food/snacks/fudgedice,
					/obj/item/reagent_containers/food/snacks/chocoorange,
					/obj/item/reagent_containers/food/snacks/honeybar,
					/obj/item/reagent_containers/food/snacks/tinychocolate,
					/obj/item/reagent_containers/food/snacks/spacetwinkie,
					/obj/item/reagent_containers/food/snacks/syndicake,
					/obj/item/reagent_containers/food/snacks/cheesiehonkers,
					/obj/item/reagent_containers/food/snacks/sugarcookie/spookyskull,
					/obj/item/reagent_containers/food/snacks/sugarcookie/spookycoffin,
					/obj/item/reagent_containers/food/snacks/candy_corn,
					/obj/item/reagent_containers/food/snacks/candiedapple,
					/obj/item/reagent_containers/food/snacks/chocolatebar,
					/obj/item/reagent_containers/food/snacks/candyheart,
					/obj/item/storage/fancy/heart_box,
					/obj/item/storage/fancy/donut_box)
	crate_name = "candy crate"

/datum/supply_pack/organic/exoticseeds
	name = "Exotic Seeds Crate"
	desc = "Any entrepreneuring botanist's dream. Contains twelve different seeds, including three replica-pod seeds and two mystery seeds!"
	cost = 1500
	contains = list(/obj/item/seeds/nettle,
					/obj/item/seeds/replicapod,
					/obj/item/seeds/replicapod,
					/obj/item/seeds/replicapod,
					/obj/item/seeds/plump,
					/obj/item/seeds/liberty,
					/obj/item/seeds/amanita,
					/obj/item/seeds/reishi,
					/obj/item/seeds/banana,
					/obj/item/seeds/eggplant/eggy,
					/obj/item/seeds/random,
					/obj/item/seeds/random)
	crate_name = "exotic seeds crate"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/organic/food
	name = "Food Crate"
	desc = "Get things cooking with this crate full of useful ingredients! Contains a two dozen eggs, three bananas, and two bags of flour and rice, two cartons of milk, soymilk, as well as salt and pepper shakers, a enzyme and sugar bottle, and three slabs of monkeymeat."
	cost = 1000
	contains = list(/obj/item/reagent_containers/food/condiment/flour,
					/obj/item/reagent_containers/food/condiment/flour,
					/obj/item/reagent_containers/food/condiment/rice,
					/obj/item/reagent_containers/food/condiment/rice,
					/obj/item/reagent_containers/food/condiment/milk,
					/obj/item/reagent_containers/food/condiment/milk,
					/obj/item/reagent_containers/food/condiment/soymilk,
					/obj/item/reagent_containers/food/condiment/saltshaker,
					/obj/item/reagent_containers/food/condiment/peppermill,
					/obj/item/storage/fancy/egg_box,
					/obj/item/storage/fancy/egg_box,
					/obj/item/reagent_containers/food/condiment/enzyme,
					/obj/item/reagent_containers/food/condiment/sugar,
					/obj/item/reagent_containers/food/snacks/meat/slab/monkey,
					/obj/item/reagent_containers/food/snacks/meat/slab/monkey,
					/obj/item/reagent_containers/food/snacks/meat/slab/monkey,
					/obj/item/reagent_containers/food/snacks/grown/banana,
					/obj/item/reagent_containers/food/snacks/grown/banana,
					/obj/item/reagent_containers/food/snacks/grown/banana)
	crate_name = "food crate"

/datum/supply_pack/organic/fiestatortilla
	name = "Fiesta Crate"
	desc = "Spice up the kitchen with this fiesta themed food order! Contains 8 tortilla based food items, as well as a sombrero, moustache, and cloak!"
	cost = 2750
	contains = list(/obj/item/clothing/head/sombrero,
					/obj/item/clothing/suit/hooded/cloak/david,
					/obj/item/clothing/mask/fakemoustache,
					/obj/item/reagent_containers/food/snacks/taco,
					/obj/item/reagent_containers/food/snacks/taco,
					/obj/item/reagent_containers/food/snacks/taco/plain,
					/obj/item/reagent_containers/food/snacks/taco/plain,
					/obj/item/reagent_containers/food/snacks/enchiladas,
					/obj/item/reagent_containers/food/snacks/enchiladas,
					/obj/item/reagent_containers/food/snacks/carneburrito,
					/obj/item/reagent_containers/food/snacks/cheesyburrito,
					/obj/item/reagent_containers/glass/bottle/capsaicin,
					/obj/item/reagent_containers/glass/bottle/capsaicin)
	crate_name = "fiesta crate"

/datum/supply_pack/organic/fruit_1
	name = "Fruit Basic Crate"
	desc = "Getting scurvy on the station? Well heres your fixing! Contains three of each - bananas, watermelons, limes, lemons, oranges and even three pineapple."
	cost = 2250
	contains = list(/obj/item/reagent_containers/food/snacks/grown/watermelon,
					/obj/item/reagent_containers/food/snacks/grown/watermelon,
					/obj/item/reagent_containers/food/snacks/grown/watermelon,
					/obj/item/reagent_containers/food/snacks/grown/pineapple,
					/obj/item/reagent_containers/food/snacks/grown/pineapple,
					/obj/item/reagent_containers/food/snacks/grown/pineapple,
					/obj/item/reagent_containers/food/snacks/grown/citrus/lime,
					/obj/item/reagent_containers/food/snacks/grown/citrus/lime,
					/obj/item/reagent_containers/food/snacks/grown/citrus/lime,
					/obj/item/reagent_containers/food/snacks/grown/citrus/orange,
					/obj/item/reagent_containers/food/snacks/grown/citrus/orange,
					/obj/item/reagent_containers/food/snacks/grown/citrus/orange,
					/obj/item/reagent_containers/food/snacks/grown/citrus/lemon,
					/obj/item/reagent_containers/food/snacks/grown/citrus/lemon,
					/obj/item/reagent_containers/food/snacks/grown/citrus/lemon,
					/obj/item/reagent_containers/food/snacks/grown/banana,
					/obj/item/reagent_containers/food/snacks/grown/banana,
					/obj/item/reagent_containers/food/snacks/grown/banana)
	crate_name = "fruit crate"

/datum/supply_pack/organic/fruit_2
	name = "Fruit Delux Crate"
	desc = "Getting tired of the basic fruits and want to have something a bit more decadent! This crate is for you! Contains three of each - bunches of berries, apples, pineapples, cherries, green & red grapes, eggplants, bananas lastly ten strawberry."
	cost = 3500
	contains = list(/obj/item/reagent_containers/food/snacks/grown/berries,
					/obj/item/reagent_containers/food/snacks/grown/berries,
					/obj/item/reagent_containers/food/snacks/grown/berries,
					/obj/item/reagent_containers/food/snacks/grown/apple,
					/obj/item/reagent_containers/food/snacks/grown/apple,
					/obj/item/reagent_containers/food/snacks/grown/apple,
					/obj/item/reagent_containers/food/snacks/grown/pineapple,
					/obj/item/reagent_containers/food/snacks/grown/pineapple,
					/obj/item/reagent_containers/food/snacks/grown/pineapple,
					/obj/item/reagent_containers/food/snacks/grown/cherries,
					/obj/item/reagent_containers/food/snacks/grown/cherries,
					/obj/item/reagent_containers/food/snacks/grown/cherries,
					/obj/item/reagent_containers/food/snacks/grown/grapes,
					/obj/item/reagent_containers/food/snacks/grown/grapes,
					/obj/item/reagent_containers/food/snacks/grown/grapes,
					/obj/item/reagent_containers/food/snacks/grown/grapes/green,
					/obj/item/reagent_containers/food/snacks/grown/grapes/green,
					/obj/item/reagent_containers/food/snacks/grown/grapes/green,
					/obj/item/reagent_containers/food/snacks/grown/banana,
					/obj/item/reagent_containers/food/snacks/grown/banana,
					/obj/item/reagent_containers/food/snacks/grown/banana,
					/obj/item/reagent_containers/food/snacks/grown/eggplant,
					/obj/item/reagent_containers/food/snacks/grown/eggplant,
					/obj/item/reagent_containers/food/snacks/grown/eggplant,
					/obj/item/reagent_containers/food/snacks/grown/strawberry,
					/obj/item/reagent_containers/food/snacks/grown/strawberry,
					/obj/item/reagent_containers/food/snacks/grown/strawberry,
					/obj/item/reagent_containers/food/snacks/grown/strawberry,
					/obj/item/reagent_containers/food/snacks/grown/strawberry,
					/obj/item/reagent_containers/food/snacks/grown/strawberry,
					/obj/item/reagent_containers/food/snacks/grown/strawberry,
					/obj/item/reagent_containers/food/snacks/grown/strawberry,
					/obj/item/reagent_containers/food/snacks/grown/strawberry,
					/obj/item/reagent_containers/food/snacks/grown/strawberry)
	crate_name = "fruit crate"


//ALIEN-ESQUE SEEDS CRATE
/datum/supply_pack/organic/rareseeds
	name = "Galactic Seeds Crate"
	desc = "Feel the need to explore the vastness of space, condensed into a single crate! Contains at least 4 seeds from random regions of space."
	cost = 9500		//See fill proc. I know this costs a lot
	contains = list()
	crate_name = "galactic seeds crate"
	crate_desc = "A rectangular steel crate."
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/organic/rareseeds/fill(obj/structure/closet/crate/C)
	. = ..()
	var/iteration = 0
	var/common_seeds = list(
				/obj/item/seeds/wheat,
				/obj/item/seeds/wheat/oat,
				/obj/item/seeds/peas,
				/obj/item/seeds/tea,
				/obj/item/seeds/coffee,
				/obj/item/seeds/poppy,
				/obj/item/seeds/sunflower,
				/obj/item/seeds/grass,
				/obj/item/seeds/glowshroom,
				/obj/item/seeds/cotton,
				/obj/item/seeds/reishi,
				/obj/item/seeds/kudzu,	//For some sort of realism that kudzu generally grows everywhere, have it a common seed
				/obj/item/seeds/starthistle)
	var/uncommon_seeds = list(
				/obj/item/seeds/chanterelle/jupitercup,
				/obj/item/seeds/sunflower/moonflower,
				/obj/item/seeds/bee_balm,
				/obj/item/seeds/random,
				/obj/item/seeds/tea/astra,
				/obj/item/seeds/peas/laugh,
				/obj/item/seeds/galaxythistle,
				/obj/item/seeds/coconut,
				/obj/item/seeds/ambrosia/deus,
				/obj/item/seeds/aloe,
				/obj/item/seeds/cannabis/rainbow,
				/obj/item/seeds/cannabis/ultimate,
				/obj/item/seeds/angel,
				/obj/item/seeds/liberty,
				/obj/item/seeds/plump/walkingmushroom,
				/obj/item/seeds/chanterelle,
				/obj/item/seeds/glowshroom/shadowshroom)
	var/xenoarch_seeds = list(
				/obj/item/seeds/amauri,
				/obj/item/seeds/gelthi,
				/obj/item/seeds/jurlmah,
				/obj/item/seeds/nofruit,
				/obj/item/seeds/shand,
				/obj/item/seeds/surik,
				/obj/item/seeds/telriis,
				/obj/item/seeds/thaadra,
				/obj/item/seeds/vale,
				/obj/item/seeds/vaporsac)
	var/lavaland_seeds = list(
				/obj/item/seeds/lavaland/polypore,
				/obj/item/seeds/lavaland/porcini,
				/obj/item/seeds/lavaland/inocybe,
				/obj/item/seeds/lavaland/ember,
				/obj/item/seeds/lavaland/cactus)
	while((prob(68) || iteration <= 4) && iteration <= 15)
		iteration++
		var/obj/item/seeds/chosen_seed = null
		var/obj/item/seeds/cache = null
		switch(iteration)
			if(1 to 3)
				chosen_seed = pick(common_seeds)
			if(4)
				if(prob(25))
					chosen_seed = pick(lavaland_seeds)
				else
					chosen_seed = pick(common_seeds)
			if(5)
				if(prob(40))
					chosen_seed = pick(lavaland_seeds)
				else
					chosen_seed = pick(common_seeds)
			if(6)
				if(prob(70))
					chosen_seed = pick(common_seeds)
				else
					chosen_seed = pick(uncommon_seeds)
			if(7)
				if(prob(3))
					chosen_seed = pick(xenoarch_seeds)
				else if(prob(40))
					chosen_seed = pick(common_seeds)
				else
					chosen_seed = pick(uncommon_seeds)
			if(8 to 10)
				if(prob(8))
					chosen_seed = pick(xenoarch_seeds)
				else
					chosen_seed = pick(uncommon_seeds)
			if(11 to INFINITY)
				if(prob(15))
					chosen_seed = pick(xenoarch_seeds)
				else if (prob(50))
					chosen_seed = pick(uncommon_seeds)
				else
					chosen_seed = pick(lavaland_seeds)


		cache = chosen_seed

		if(istype(chosen_seed,/obj/item/seeds/starthistle)
			new chosen_seed(C)
			continue
		//Make it actually seem like it's from another galaxy with all this stuff
		if(prob(15) && !istype(chosen_seed, /obj/item/seeds/starthistle)
			chosen_seed.rarity += 1

			var/mutated = FALSE
			for(var/datum/plant_gene/G in cache.genes)
				if(locate(G) in chosen_seed.genes && prob(60))
					if(prob(50))
						chosen_seed.unset_mutability(G, PLANT_GENE_EXTRACTABLE)
						chosen_seed.rarity += 5
					else if(prob(70))
						chosen_seed.unset_mutability(G, PLANT_GENE_REMOVABLE)
						chosen_seed.rarity += 5
					else if(!istype(G, /datum/plant_gene/core))
						chosen_seed.forbiddengenes += G.type		//Has the slim chance to make this plant unable to produce anything it started out with
						chosen_seed.genes -= locate(G) in chosen_seed.genes	//Sanity check
						chosen_seed.rarity += 10

						if(prob(65))	//To make this seem even more otherworldly
							//Our own version of add_random_reagents
							var/random_amount = round(rand(0, 25), 5) * 0.01
							if(random_amount <= 0) random_amount = 0.02
							var/datum/plant_gene/reagent/R = new(get_random_reagent_id(), random_amount)

							if(R.can_add(chosen_seed))
								chosen_seed.genes += R
								chosen_seed.rarity += 5
							else
								qdel(R)
							chosen_seed.reagents_from_genes()

							if(prob(3))	//This is insanely rare, but we will use different grow sprites. Probably will fuck something up
								var/obj/item/seeds/S = pick(subtypesof(/obj/item/seeds))
								if(prob(85))
									chosen_seed.plantname = "[pick("Alien", "Supernatural", "Artificial", "Modified")] [S.plantname]"
									chosen_seed.rarity += 20*(!mutated)
								else
									chosen_seed.plantname = S.plantname
								chosen_seed.growing_icon = S.growing_icon
								chosen_seed.species = S.species
								chosen_seed.icon_grow = S.icon_grow
								chosen_seed.icon_harvest = S.icon_harvest
								chosen_seed.icon_dead = S.icon_dead
								chosen_seed.rarity += 35*(!mutated)	//woah nelly
								mutated = TRUE

						else if(prob(70))	//Add basic reagents from grounded sheets, but only small amounts
							var/A = rand(1, 5)
							var/chosen_reagent
							switch(A)
								if(1)
									chosen_reagent = /datum/reagent/toxin/plasma
								if(2)
									chosen_reagent = /datum/reagent/uranium
								if(3)
									chosen_reagent = /datum/reagent/iron
								if(4)
									chosen_reagent = /datum/reagent/gold
								if(5)
									chosen_reagent = /datum/reagent/cellulose
							var/datum/plant_gene/reagent/R = new(chosen_reagent, A*0.02)
							if(R.can_add(chosen_seed))
								chosen_seed.genes += R
								chosen_seed.rarity += 5
							else
								qdel(R)
							chosen_seed.reagents_from_genes()

		new chosen_seed(C)
	//All in a while() loop! Very efficient I know

/datum/supply_pack/organic/grill
	name = "Grilling Starter Kit"
	desc = "Hey dad I'm Hungry. Hi Hungry I'm THE NEW GRILLING STARTER KIT ONLY 5000 BUX GET NOW! Contains a cooking grill and five fuel coal sheets."
	cost = 3000
	crate_type = /obj/structure/closet/crate
	contains = list(/obj/item/stack/sheet/mineral/coal/five,
					/obj/machinery/grill/unwrenched)
	crate_name = "grilling starter kit crate"

/datum/supply_pack/organic/grillfuel
	name = "Grilling Fuel Kit"
	desc = "Contains coal and coal accessories. (Note: only ten coal sheets.)"
	cost = 1000
	crate_type = /obj/structure/closet/crate
	contains = list(/obj/item/stack/sheet/mineral/coal/ten)
	crate_name = "grilling fuel kit crate"

/datum/supply_pack/organic/cream_piee
	name = "High-yield Clown-grade Cream Pie Crate"
	desc = "Designed by Aussec's Advanced Warfare Research Division, these high-yield, Clown-grade cream pies are powered by a synergy of performance and efficiency. Guaranteed to provide maximum results."
	cost = 6000
	contains = list(/obj/item/storage/backpack/duffelbag/clown/cream_pie)
	crate_name = "party equipment crate"
	contraband = TRUE
	access = ACCESS_THEATRE
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/organic/hunting
	name = "Hunting gear"
	desc = "Even in space, we can find prey to hunt, this crate contains everthing a fine hunter needs to have a sporting time. This crate needs armory access to open. A true huntter only needs a fine bottle of cognac, a nice coat, some good o' cigars, and of cource a hunting shotgun. "
	cost = 3500
	contraband = TRUE
	contains = list(/obj/item/clothing/head/flatcap,
					/obj/item/clothing/suit/hooded/wintercoat/captain,
					/obj/item/reagent_containers/food/drinks/bottle/cognac,
					/obj/item/storage/fancy/cigarettes/cigars/havana,
					/obj/item/clothing/gloves/color/white,
					/obj/item/clothing/under/rank/curator,
					/obj/item/gun/ballistic/shotgun/lethal)
	access = ACCESS_ARMORY
	crate_name = "sporting crate"
	crate_type = /obj/structure/closet/crate/secure // Would have liked a wooden crate but access >:(

/datum/supply_pack/organic/fakemeat
	name = "Meat Crate"
	desc = "Run outta meat already? Keep the lizards content with this freezer filled with cruelty-free chemically compounded meat! Contains 4 slabs of meat product, and two slabs of *carp*."
	cost = 1700
	contains = list(/obj/item/reagent_containers/food/snacks/meat/slab/meatproduct,
					/obj/item/reagent_containers/food/snacks/meat/slab/meatproduct,
					/obj/item/reagent_containers/food/snacks/meat/slab/meatproduct,
					/obj/item/reagent_containers/food/snacks/meat/slab/meatproduct,
					/obj/item/reagent_containers/food/snacks/carpmeat/imitation,
					/obj/item/reagent_containers/food/snacks/carpmeat/imitation)
	crate_name = "meaty crate"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/organic/monkeydripmeat
	name = "*Meat* Crate"
	desc = "Need some meat? With this do-it-yourself kit you'll be swimming in it! Contains a monkey cube, an IV drip, and some cryoxadone!"
	cost = 2150
	contraband = TRUE
	contains = list(/obj/item/reagent_containers/food/snacks/monkeycube,
					/obj/item/restraints/handcuffs/cable,
					/obj/machinery/iv_drip,
					/obj/item/reagent_containers/glass/beaker/cryoxadone,
					/obj/item/reagent_containers/glass/beaker/cryoxadone)
	crate_name = "monkey meat crate"

/datum/supply_pack/organic/mixedboxes
	name = "Mixed Ingredient Boxes"
	desc = "Get overwhelmed with inspiration by ordering these boxes of surprise ingredients! Get four boxes filled with an assortment of products!"
	cost = 2300
	contains = list(/obj/item/storage/box/ingredients/wildcard,
					/obj/item/storage/box/ingredients/wildcard,
					/obj/item/storage/box/ingredients/wildcard,
					/obj/item/storage/box/ingredients/wildcard)
	crate_name = "wildcard food crate"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/organic/hydroponics
	name = "Hydroponics Crate"
	desc = "Supplies for growing a great garden! Contains two bottles of ammonia, a hatchet, cultivator, plant analyzer, as well as a pair of leather gloves and a botanist's apron."
	cost = 1750
	contains = list(/obj/item/reagent_containers/glass/bottle/ammonia,
					/obj/item/reagent_containers/glass/bottle/ammonia,
					/obj/item/hatchet,
					/obj/item/cultivator,
					/obj/item/plant_analyzer,
					/obj/item/clothing/gloves/botanic_leather,
					/obj/item/clothing/suit/apron)
	crate_name = "hydroponics crate"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/organic/hydroponics/hydrotank
	name = "Hydroponics Backpack Crate"
	desc = "Bring on the flood with this high-capacity backpack crate. Contains 500 units of life-giving H2O. Requires hydroponics access to open."
	cost = 1200
	access = ACCESS_HYDROPONICS
	contains = list(/obj/item/watertank)
	crate_name = "hydroponics backpack crate"
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/organic/cutlery
	name = "Kitchen Cutlery Deluxe Set"
	desc = "Need to slice and dice away those ''Tomatos'' well we got what you need! From a nice set of knifes, forks, plates, glasses, and a whetstone for when you got some grizzle that is a bit harder to slice then normal."
	cost = 10000
	contraband = TRUE
	contains = list(/obj/item/sharpener,
					/obj/item/kitchen/fork,
					/obj/item/kitchen/fork,
					/obj/item/kitchen/knife,
					/obj/item/kitchen/knife,
					/obj/item/kitchen/knife,
					/obj/item/kitchen/knife,
					/obj/item/kitchen/knife/butcher,
					/obj/item/kitchen/knife/butcher,
					/obj/item/kitchen/rollingpin, //Deluxe for a reason
					/obj/item/trash/plate,
					/obj/item/trash/plate,
					/obj/item/trash/plate,
					/obj/item/trash/plate,
					/obj/item/reagent_containers/food/drinks/drinkingglass,
					/obj/item/reagent_containers/food/drinks/drinkingglass,
					/obj/item/reagent_containers/food/drinks/drinkingglass,
					/obj/item/reagent_containers/food/drinks/drinkingglass/shotglass,
					/obj/item/reagent_containers/food/drinks/drinkingglass/shotglass)
	crate_name = "kitchen cutlery deluxe set"

/datum/supply_pack/organic/hydroponics/maintgarden
	name = "Maintenance Garden Crate"
	desc = "Set up your own tiny paradise with do-it-yourself botany kit. Contains sandstone for dirt plots, pest spray, ammonia, a portable seed generator, basic botanical tools, and some seeds to start off with."
	cost = 2700
	contains = list(/obj/item/storage/bag/plants/portaseeder,
					/obj/item/reagent_containers/spray/pestspray,
					/obj/item/stack/sheet/mineral/sandstone/twelve,
					/obj/item/reagent_containers/glass/bucket,
					/obj/item/reagent_containers/glass/bottle/ammonia,
					/obj/item/reagent_containers/glass/bottle/ammonia,
					/obj/item/hatchet,
					/obj/item/cultivator,
					/obj/item/plant_analyzer,
					/obj/item/clothing/gloves/botanic_leather,
					/obj/item/clothing/suit/apron,
					/obj/item/flashlight,
					/obj/item/seeds/carrot,
					/obj/item/seeds/carrot,
					/obj/item/seeds/tower,
					/obj/item/seeds/tower,
					/obj/item/seeds/watermelon,
					/obj/item/seeds/watermelon,
					/obj/item/seeds/grass,
					/obj/item/seeds/grass)
	crate_name = "maint garden crate"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/organic/mre
	name = "MRE supply kit (emergency rations)"
	desc = "The lights are out. Oxygen's running low. You've run out of food except space weevils. Don't let this be you! Order our NT branded MRE kits today! This pack contains 5 MRE packs with a randomized menu and an oxygen tank."
	cost = 2000
	contains = list(/obj/item/storage/box/mre/menu1/safe,
					/obj/item/storage/box/mre/menu1/safe,
					/obj/item/storage/box/mre/menu2/safe,
					/obj/item/storage/box/mre/menu2/safe,
					/obj/item/storage/box/mre/menu3,
					/obj/item/storage/box/mre/menu4/safe)
	crate_name = "MRE crate (emergency rations)"

/datum/supply_pack/organic/pizza
	name = "Pizza Crate"
	desc = "Best prices on this side of the galaxy. All deliveries are guaranteed to be 99% anomaly-free!"
	cost = 6000 // Best prices this side of the galaxy.
	contains = list(/obj/item/pizzabox/margherita,
					/obj/item/pizzabox/mushroom,
					/obj/item/pizzabox/meat,
					/obj/item/pizzabox/vegetable,
					/obj/item/pizzabox/pineapple)
	crate_name = "pizza crate"
	var/static/anomalous_box_provided = FALSE

/datum/supply_pack/organic/pizza/fill(obj/structure/closet/crate/C)
	. = ..()
	if(!anomalous_box_provided)
		for(var/obj/item/pizzabox/P in C)
			if(prob(1)) //1% chance for each box, so 4% total chance per order
				var/obj/item/pizzabox/infinite/fourfiveeight = new(C)
				fourfiveeight.boxtag = P.boxtag
				qdel(P)
				anomalous_box_provided = TRUE
				log_game("An anomalous pizza box was provided in a pizza crate at during cargo delivery")
				if(prob(50))
					addtimer(CALLBACK(src, .proc/anomalous_pizza_report), rand(300, 1800))
				else
					message_admins("An anomalous pizza box was silently created with no command report in a pizza crate delivery.")
				break

/datum/supply_pack/organic/pizza/proc/anomalous_pizza_report()
	print_command_report("[station_name()], our anomalous materials divison has reported a missing object that is highly likely to have been sent to your station during a routine cargo \
	delivery. Please search all crates and manifests provided with the delivery and return the object if is located. The object resembles a standard <b>\[DATA EXPUNGED\]</b> and is to be \
	considered <b>\[REDACTED\]</b> and returned at your leisure. Note that objects the anomaly produces are specifically attuned exactly to the individual opening the anomaly; regardless \
	of species, the individual will find the object edible and it will taste great according to their personal definitions, which vary significantly based on person and species.")

/datum/supply_pack/organic/potted_plants
	name = "Potted Plants Crate"
	desc = "Spruce up the station with these lovely plants! Contains a random assortment of five potted plants from Kinaris's potted plant research division. Warranty void if thrown."
	cost = 730
	contains = list(/obj/item/twohanded/required/kirbyplants/random,
					/obj/item/twohanded/required/kirbyplants/random,
					/obj/item/twohanded/required/kirbyplants/random,
					/obj/item/twohanded/required/kirbyplants/random,
					/obj/item/twohanded/required/kirbyplants/random)
	crate_name = "potted plants crate"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/organic/seeds
	name = "Seeds Crate"
	desc = "Big things have small beginnings. Contains thirteen different seeds."
	cost = 1250
	contains = list(/obj/item/seeds/chili,
					/obj/item/seeds/berry,
					/obj/item/seeds/corn,
					/obj/item/seeds/eggplant,
					/obj/item/seeds/tomato,
					/obj/item/seeds/soya,
					/obj/item/seeds/wheat,
					/obj/item/seeds/wheat/rice,
					/obj/item/seeds/carrot,
					/obj/item/seeds/sunflower,
					/obj/item/seeds/chanterelle,
					/obj/item/seeds/potato,
					/obj/item/seeds/sugarcane)
	crate_name = "seeds crate"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/organic/vday
	name = "Surplus Valentine Crate"
	desc = "Turns out we got warehouses of this love-y dove-y crap. Were sending out small barged buddle of Valentine gear. This crate has two boxes of chocolate, three poppy flowers, five candy hearts, and three cards."
	cost = 3000
	contraband = TRUE
	contains = list(/obj/item/storage/fancy/heart_box,
					/obj/item/storage/fancy/heart_box,
					/obj/item/reagent_containers/food/snacks/grown/poppy,
					/obj/item/reagent_containers/food/snacks/grown/poppy,
					/obj/item/reagent_containers/food/snacks/grown/poppy,
					/obj/item/reagent_containers/food/snacks/candyheart,
					/obj/item/reagent_containers/food/snacks/candyheart,
					/obj/item/reagent_containers/food/snacks/candyheart,
					/obj/item/reagent_containers/food/snacks/candyheart,
					/obj/item/reagent_containers/food/snacks/candyheart,
					/obj/item/valentine,
					/obj/item/valentine,
					/obj/item/valentine)
	crate_name = "valentine crate"
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/organic/strangeseeds
	name = "Strange Seeds Crate"
	desc = "After our chemical waste mysteriously disappeared we've discovered many strange and interesting species of plants, and they're yours for the taking! Contains 8 packs of strange seeds."
	cost = 4500
	contains = list(/obj/item/seeds/random,
					/obj/item/seeds/random,
					/obj/item/seeds/random,
					/obj/item/seeds/random,
					/obj/item/seeds/random,
					/obj/item/seeds/random,
					/obj/item/seeds/random,
					/obj/item/seeds/random)
	crate_name = "strange seeds crate"
	crate_type = /obj/structure/closet/crate/hydroponics
