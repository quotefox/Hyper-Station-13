/datum/reagent/consumable/alienhoney 				//for players who want bee character bewbs that produce honey.
	name = "alien honey"
	description = "Sweet honey that came from a alien source. This honey doesn't possess the same healing or nutrition properties as earth-bound bee honey."
	color = "#d3a308"
	value = 3 										//plentiful, so wouldnt be worth as much.
	nutriment_factor = 5 * REAGENTS_METABOLISM
	metabolization_rate = 1 * REAGENTS_METABOLISM
	taste_description = "sweetness"

/datum/reagent/consumable/alienhoney/on_mob_life(mob/living/carbon/M) //can still be eaten/drank, but will provide no benefits like normal honey. Still good for a food sauce.
	M.reagents.add_reagent(/datum/reagent/consumable/sugar,2) //metabolisms in the system as sugar.
	..()