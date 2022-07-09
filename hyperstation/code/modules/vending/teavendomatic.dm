/obj/machinery/vending/teavendomatic
	name = "\improper Tea Vend-O-Matic"
	desc = "A technological marvel, supposedly able to mix just the mixture you'd like to drink the moment you ask for one, this one is branded for tea and non-alcoholic beverages... Mostly."
	icon_state = "boozeomat"
	icon_deny = "boozeomat-deny"
	products = list(
					/obj/item/reagent_containers/food/drinks/mug/tea = 30,
					/obj/item/reagent_containers/food/drinks/bottle/wine = 5,
					/obj/item/reagent_containers/food/drinks/bottle/cognac = 5,
					/obj/item/reagent_containers/food/drinks/bottle/grappa = 5,
					/obj/item/reagent_containers/food/drinks/bottle/sake = 5,
					/obj/item/reagent_containers/food/drinks/bottle/orangejuice = 8,
					/obj/item/reagent_containers/food/drinks/bottle/tomatojuice = 8,
					/obj/item/reagent_containers/food/drinks/bottle/limejuice = 8,
					/obj/item/reagent_containers/food/drinks/bottle/grenadine = 4,
					/obj/item/reagent_containers/food/drinks/bottle/cream = 8,
					/obj/item/reagent_containers/food/drinks/soda_cans/tonic = 8,
					/obj/item/reagent_containers/food/drinks/soda_cans/cola = 8,
					/obj/item/reagent_containers/food/drinks/soda_cans/sodawater = 15,
					/obj/item/reagent_containers/food/drinks/drinkingglass = 30,
					/obj/item/reagent_containers/food/drinks/ice = 10,
					/obj/item/reagent_containers/food/drinks/drinkingglass/shotglass = 12,
					/obj/item/reagent_containers/food/drinks/flask = 3)
	contraband = list(/obj/item/reagent_containers/food/drinks/mug/tea = 12,)
	premium = list(/obj/item/reagent_containers/glass/bottle/ethanol = 4,
				   /obj/item/reagent_containers/food/drinks/bottle/champagne = 5,
				   /obj/item/reagent_containers/food/drinks/bottle/trappist = 5)
	product_slogans = "Keep a clear head and drink on.;It is a quite fine day to sit down and have a drink.;Remember to drink responsibly.;Products are assured to be GMO free."
	product_ads = "Stay Radiant.;Remember to balance your intake.;Radiikist brands are not permitted in sectors 34-A through 59-B.;Keep a level head.;Refreshments are to be taken in modicum.;Let the day's stress melt away.;Please, enjoy.;In-service since the sixth Era."
	req_access = list(ACCESS_BAR)
	//refill_canister = /obj/item/vending_refill/teavendomatic
	free = TRUE
