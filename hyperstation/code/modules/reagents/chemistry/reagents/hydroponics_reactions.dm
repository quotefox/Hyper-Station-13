/*
 * If you ever decide to add more reactions, please remember to keep these
 * in alphabetical order, according to reagent names and not their datums.
 * It could be hard to find reactions when code diving.
 * Due note, unlike before this change, that subtypes will apply to the tray the same as their parents
 * -DT
 */

#define DEFAULT_ACT_MUTAGEN switch(rand(100)){\
				if(91 to 100){\
					T.adjustHealth(-10);\
					to_chat(user, "<span class='warning'>The plant shrivels and burns.</span>");}\
				if(81 to 90)\
					T.mutatespecie();\
				if(66 to 80)\
					T.hardmutate();\
				if(41 to 65)\
					T.mutate();\
				if(21 to 41)\
					to_chat(user, "<span class='notice'>The plants don't seem to react...</span>");\
				if(11 to 20)\
					T.mutateweed();\
				if(1 to 10)\
					T.mutatepest(user);\
				else\
					to_chat(user, "<span class='notice'>Nothing happens...</span>");}

//Ammonia
/datum/reagent/ammonia/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	T.adjustHealth(round(volume * 0.5))
	T.adjustNutri(round(volume * 1))
	if(..())
		T.myseed.adjust_yield(round(volume * 0.01))
	return 1

//Ash
/datum/reagent/ash/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	// Ash is used IRL in gardening, as a fertilizer enhancer and weed killer
	T.adjustHealth(round(volume * 0.25))
	T.adjustNutri(round(volume * 0.5))
	T.adjustWeeds(-round(volume / 10))
	return 1

//Beer
/datum/reagent/consumable/ethanol/beer/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	// Beer is a chemical composition of alcohol and various other things. It's a shitty nutrient but hey, it's still one. Also alcohol is bad, mmmkay?
	T.adjustHealth(-round(volume * 0.05))
	T.adjustNutri(round(volume * 0.25))
	T.adjustWater(round(volume * 0.7))
	return 1

//Blood
/datum/reagent/blood/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	T.adjustNutri(round(volume * 0.6))
	T.adjustHealth(-round(volume))
	T.adjustPests(rand(2,4))	//they HUNGER
	return 1

//Charcoal
/datum/reagent/medicine/charcoal/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	T.adjustToxic(-round(volume * 2))	//Antitoxin binds shit pretty well. So the tox goes significantly down
	return 1

//Chlorine
/datum/reagent/chlorine/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	T.adjustHealth(-round(volume * 1))
	T.adjustToxic(round(volume * 1.5))
	T.adjustWater(-round(volume * 0.5))
	T.adjustWeeds(-rand(1,volume * 0.125))
	return 1

//Diethylamine
/datum/reagent/diethylamine/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	//Corrosive to pests, but not to plants
	if(..())
		T.myseed.adjust_yield(round(volume * 0.02))
	T.adjustHealth(round(volume))
	T.adjustNutri(round(volume * 2))
	T.adjustPests(-rand(1,round(volume / 30)))
	return 1

//Earthsblood
/datum/reagent/medicine/earthsblood/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	T.self_sufficiency_progress += volume
	if(T.self_sufficiency_progress >= T.self_sufficiency_req)
		T.become_self_sufficient()
	else
		to_chat(user, "<span class='notice'>[T] warms as it might on a spring day under a genuine Sun.</span>")
	return 1

//Enduro-Grow
/datum/reagent/plantnutriment/endurogrow/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	if(!..())
		return -1
	T.myseed.adjust_potency(-round(volume / 10))
	T.myseed.adjust_yield(-round(volume / 30))
	T.myseed.adjust_endurance(round(volume / 30))
	return 1

//E-Z Nutrient
/datum/reagent/plantnutriment/eznutriment/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	T.yieldmod = 1
	T.mutmod = 1
	return ..()

//Flourine
/datum/reagent/fluorine/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	// Fluorine one of the most corrosive and deadly gasses
	T.adjustHealth(-round(volume * 2))
	T.adjustToxic(round(volume * 2.5))
	T.adjustWater(-round(volume * 0.5))
	T.adjustWeeds(-rand(1, volume * 0.25))
	return 1

//Fluorosulfuric acid
/datum/reagent/toxin/acid/fluacid/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	T.adjustHealth(-round(volume * 2))
	T.adjustToxic(round(volume * 3))
	T.adjustWeeds(-rand(1,volume * 0.5))
	return 1

//Holy Water
/datum/reagent/water/holywater/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	//Mostly the same as water, it also heals the plant a little with the power of the spirits~
	T.adjustWater(round(volume))
	T.adjustHealth(round(volume * 0.1))
	return 1

//Left-4-Zed
/datum/reagent/plantnutriment/left4zednutriment/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	T.yieldmod = 0
	T.mutmod = 2
	return ..()

//Liquid Earthquake
/datum/reagent/plantnutriment/liquidearthquake/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	if(!..())
		return -1
	T.myseed.adjust_weed_chance(round(volume / 10))
	T.myseed.adjust_weed_rate(round(volume / 30))
	T.myseed.adjust_production(-round(volume / 30))
	return 1

//Milk
/datum/reagent/consumable/milk/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	T.adjustNutri(round(volume * 0.2))
	T.adjustWater(round(volume * 0.5))
	if(..())	// Milk is good for humans, but bad for plants. The sugars canot be used by plants, and the milk fat fucks up growth.
		if(!T.myseed.get_gene(/datum/plant_gene/trait/plant_type/fungal_metabolism))	//Not shrooms though
			T.adjustHealth(-round(volume / 2))
	return 1

//Napalm
/datum/reagent/napalm/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	if(..())
		if(T.myseed.resistance_flags & FIRE_PROOF)
			return 1
	T.adjustHealth(-round(volume * 6))
	T.adjustToxic(round(volume * 7))
	T.adjustWeeds(-rand(5,9))
	return 1

//Nutriment
/datum/reagent/consumable/nutriment/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	//Compost, effectively
	T.adjustHealth(round(volume * 0.5))
	T.adjustNutri(round(volume))
	return 1

//Pest Killer
/datum/reagent/toxin/pestkiller/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	T.adjustToxic(round(volume * 0.5))
	T.adjustPests(-rand(1,volume / 5))
	return 1

//Phosphorus
/datum/reagent/phosphorus/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	// White Phosphorous + water -> phosphoric acid. That's not a good thing really.
	// Phosphoric salts are beneficial though. And even if the plant suffers, in the long run the tray gets some nutrients. The benefit isn't worth that much.
	T.adjustHealth(-round(volume * 0.75))
	T.adjustNutri(round(volume * 0.1))
	T.adjustWater(-round(volume * 0.5))
	T.adjustWeeds(-rand(1, volume * 0.1))
	return 1

//Plant-B-Gone
/datum/reagent/toxin/plantbgone/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	T.adjustHealth(-round(volume * 5))
	T.adjustToxic(round(volume * 6))
	T.adjustWeeds(-rand(4,8))
	return 1

//Plant Base
//For subtypes of /datum/reagent/plantnutriment/
/datum/reagent/plantnutriment/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	T.adjustNutri(round(volume))
	return ..()

//Radium
/datum/reagent/radium/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	if(volume >= 10)
		DEFAULT_ACT_MUTAGEN
	else if(volume >= 5)
		T.hardmutate()
	else if(volume >= 2)
		T.mutate()

	T.adjustHealth(-round(volume))
	T.adjustToxic(round(volume * 3))	// Radium is harsher (OOC: also easier to produce)
	return 1

//Robust Harvest
/datum/reagent/plantnutriment/robustharvestnutriment/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	T.yieldmod = 1.3
	T.mutmod = 0
	return ..()

//Saltpetre
/datum/reagent/saltpetre/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	// Saltpetre is used for gardening IRL. To simplify highly, it speeds up growth and strengthens plants
	T.adjustHealth(round(volume * 0.25))
	if (..())
		T.myseed.adjust_production(-round(volume/100)-prob(volume%100))
		T.myseed.adjust_potency(round(volume*0.5))
	return 1

//Soda Water
/datum/reagent/consumable/sodawater/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	// A variety of nutrients are dissolved in club soda, without sugar.
	// These nutrients include carbon, oxygen, hydrogen, phosphorous, potassium, sulfur and sodium, all of which are needed for healthy plant growth.
	T.adjustWater(round(volume) * 0.9)
	T.adjustHealth(round(volume * 0.1))
	T.adjustNutri(round(volume * 0.1))
	return 1

//Sugar
/datum/reagent/consumable/sugar/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	T.adjustWeeds(round(rand(1, volume / 5)))
	T.adjustPests(round(rand(1, volume / 5)))
	return 1

//Sulphuric Acid
/datum/reagent/toxin/acid/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	T.adjustHealth(-round(volume * 1))
	T.adjustToxic(round(volume * 1.5))
	T.adjustWeeds(-rand(1,volume * 0.25))
	return 1

//Toxin
/datum/reagent/toxin/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	T.adjustToxic(round(volume * 2))
	return 1

//Unstable Mutagen
/datum/reagent/toxin/mutagen/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	if(volume >= 5)
		DEFAULT_ACT_MUTAGEN
	else if(volume >= 2)
		T.hardmutate()
	else if(volume >= 1)
		T.mutate()
	return 1

//Uranium
/datum/reagent/uranium/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	if(volume >= 10)
		DEFAULT_ACT_MUTAGEN
	else if(volume >= 5)
		T.hardmutate()
	else if(volume >= 2)
		T.mutate()

	T.adjustHealth(-round(volume))
	T.adjustToxic(round(volume * 2))
	return 1

//Virus Food
/datum/reagent/toxin/mutagen/mutagenvirusfood/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	T.adjustNutri(round(volume * 0.5))
	T.adjustHealth(-round(volume * 0.5))
	return 1

//Water
/datum/reagent/water/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	T.adjustWater(round(volume))
	return 1

//Weed Killer
/datum/reagent/toxin/plantbgone/weedkiller/on_tray(obj/machinery/hydroponics/T, volume, mob/user)
	T.adjustToxic(round(volume / 2))
	T.adjustWeeds(-rand(1,volume / 5))
	return 1

#undef DEFAULT_ACT_MUTAGEN
