/obj/machinery/hydroponics/proc/applyFertilizer(datum/reagents/S, mob/user)
	// Ambrosia Gaia produces earthsblood.
	if(S.has_reagent(/datum/reagent/medicine/earthsblood))
		self_sufficiency_progress += S.get_reagent_amount(/datum/reagent/medicine/earthsblood)
		if(self_sufficiency_progress >= self_sufficiency_req)
			become_self_sufficient()
		else if(!self_sustaining)
			to_chat(user, "<span class='notice'>[src] warms as it might on a spring day under a genuine Sun.</span>")

	// Requires 5 mutagen to possibly change species.// Poor man's mutagen.
	if(S.has_reagent(/datum/reagent/toxin/mutagen, 5) || S.has_reagent(/datum/reagent/radium, 10) || S.has_reagent(/datum/reagent/uranium, 10))
		switch(rand(100))
			if(91 to 100)
				adjustHealth(-10)
				to_chat(user, "<span class='warning'>The plant shrivels and burns.</span>")
			if(81 to 90)
				mutatespecie()
			if(66 to 80)
				hardmutate()
			if(41 to 65)
				mutate()
			if(21 to 41)
				to_chat(user, "<span class='notice'>The plants don't seem to react...</span>")
			if(11 to 20)
				mutateweed()
			if(1 to 10)
				mutatepest(user)
			else
				to_chat(user, "<span class='notice'>Nothing happens...</span>")

	// 2 or 1 units is enough to change the yield and other stats.// Can change the yield and other stats, but requires more than mutagen
	else if(S.has_reagent(/datum/reagent/toxin/mutagen, 2) || S.has_reagent(/datum/reagent/radium, 5) || S.has_reagent(/datum/reagent/uranium, 5))
		hardmutate()
	else if(S.has_reagent(/datum/reagent/toxin/mutagen, 1) || S.has_reagent(/datum/reagent/radium, 2) || S.has_reagent(/datum/reagent/uranium, 2))
		mutate()

	// Nutriments
	if(S.has_reagent(/datum/reagent/plantnutriment/eznutriment, 1))
		yieldmod = 1
		mutmod = 1
		adjustNutri(round(S.get_reagent_amount(/datum/reagent/plantnutriment/eznutriment) * 1))
	if(S.has_reagent(/datum/reagent/plantnutriment/left4zednutriment, 1))
		yieldmod = 0
		mutmod = 2
		adjustNutri(round(S.get_reagent_amount(/datum/reagent/plantnutriment/left4zednutriment) * 1))
	if(S.has_reagent(/datum/reagent/plantnutriment/robustharvestnutriment, 1))
		yieldmod = 1.3
		mutmod = 0
		adjustNutri(round(S.get_reagent_amount(/datum/reagent/plantnutriment/robustharvestnutriment) * 1))




/obj/machinery/hydroponics/proc/applyChemicals(datum/reagents/S, mob/user)
	if(!myseed)
		return
	myseed.on_chem_reaction(S) //In case seeds have some special interactions with special chems, currently only used by vines

	// After handling the mutating, we now handle the damage from adding crude radioactives...
	if(S.has_reagent(/datum/reagent/uranium, 1))
		adjustHealth(-round(S.get_reagent_amount(/datum/reagent/uranium) * 1))
		adjustToxic(round(S.get_reagent_amount(/datum/reagent/uranium) * 2))
	if(S.has_reagent(/datum/reagent/radium, 1))
		adjustHealth(-round(S.get_reagent_amount(/datum/reagent/radium) * 1))
		adjustToxic(round(S.get_reagent_amount(/datum/reagent/radium) * 3)) // Radium is harsher (OOC: also easier to produce)

	if(S.has_reagent(/datum/reagent/plantnutriment/endurogrow, 1))
		var/total_transferred = S.get_reagent_amount(/datum/reagent/plantnutriment/endurogrow)
		if(total_transferred >= 20)
			myseed.adjust_potency(-round(total_transferred / 10))
			myseed.adjust_yield(-round(total_transferred / 20))
			myseed.adjust_endurance(round(total_transferred / 60))
		else
			to_chat(user, "<span class='notice'>The plants don't seem to react...</span>")

	if(S.has_reagent(/datum/reagent/plantnutriment/liquidearthquake, 1))
		var/total_transferred = S.get_reagent_amount(/datum/reagent/plantnutriment/liquidearthquake)
		if(total_transferred >= 20)
			myseed.adjust_weed_chance(round(total_transferred / 10))
			myseed.adjust_weed_rate(round(total_transferred / 60))
			myseed.adjust_production(round(total_transferred / 60))
		else
			to_chat(user, "<span class='notice'>The plants don't seem to react...</span>")

	// Antitoxin binds shit pretty well. So the tox goes significantly down
	if(S.has_reagent(/datum/reagent/medicine/charcoal, 1))
		adjustToxic(-round(S.get_reagent_amount(/datum/reagent/medicine/charcoal) * 2))

	// Toxins, not good for anything
	if(S.has_reagent(/datum/reagent/toxin, 1))
		adjustToxic(round(S.get_reagent_amount(/datum/reagent/toxin) * 2))

	// Milk is good for humans, but bad for plants. The sugars canot be used by plants, and the milk fat fucks up growth. Not shrooms though. I can't deal with this now...
	if(S.has_reagent(/datum/reagent/consumable/milk, 1))
		adjustNutri(round(S.get_reagent_amount(/datum/reagent/consumable/milk) * 0.1))
		adjustWater(round(S.get_reagent_amount(/datum/reagent/consumable/milk) * 0.9))

	// Beer is a chemical composition of alcohol and various other things. It's a shitty nutrient but hey, it's still one. Also alcohol is bad, mmmkay?
	if(S.has_reagent(/datum/reagent/consumable/ethanol/beer, 1))
		adjustHealth(-round(S.get_reagent_amount(/datum/reagent/consumable/ethanol/beer) * 0.05))
		adjustNutri(round(S.get_reagent_amount(/datum/reagent/consumable/ethanol/beer) * 0.25))
		adjustWater(round(S.get_reagent_amount(/datum/reagent/consumable/ethanol/beer) * 0.7))

	// Fluorine one of the most corrosive and deadly gasses
	if(S.has_reagent(/datum/reagent/fluorine, 1))
		adjustHealth(-round(S.get_reagent_amount(/datum/reagent/fluorine) * 2))
		adjustToxic(round(S.get_reagent_amount(/datum/reagent/fluorine) * 2.5))
		adjustWater(-round(S.get_reagent_amount(/datum/reagent/fluorine) * 0.5))
		adjustWeeds(-rand(1,4))

	// Chlorine one of the most corrosive and deadly gasses
	if(S.has_reagent(/datum/reagent/chlorine, 1))
		adjustHealth(-round(S.get_reagent_amount(/datum/reagent/chlorine) * 1))
		adjustToxic(round(S.get_reagent_amount(/datum/reagent/chlorine) * 1.5))
		adjustWater(-round(S.get_reagent_amount(/datum/reagent/chlorine) * 0.5))
		adjustWeeds(-rand(1,3))

	// White Phosphorous + water -> phosphoric acid. That's not a good thing really.
	// Phosphoric salts are beneficial though. And even if the plant suffers, in the long run the tray gets some nutrients. The benefit isn't worth that much.
	if(S.has_reagent(/datum/reagent/phosphorus, 1))
		adjustHealth(-round(S.get_reagent_amount(/datum/reagent/phosphorus) * 0.75))
		adjustNutri(round(S.get_reagent_amount(/datum/reagent/phosphorus) * 0.1))
		adjustWater(-round(S.get_reagent_amount(/datum/reagent/phosphorus) * 0.5))
		adjustWeeds(-rand(1,2))

	// Plants should not have sugar, they can't use it and it prevents them getting water/nutients, it is good for mold though...
	if(S.has_reagent(/datum/reagent/consumable/sugar, 1))
		adjustWeeds(rand(1,2))
		adjustPests(rand(1,2))
		adjustNutri(round(S.get_reagent_amount(/datum/reagent/consumable/sugar) * 0.1))

	// It is water!
	if(S.has_reagent(/datum/reagent/water, 1))
		adjustWater(round(S.get_reagent_amount(/datum/reagent/water) * 1))

	// Holy water. Mostly the same as water, it also heals the plant a little with the power of the spirits~
	if(S.has_reagent(/datum/reagent/water/holywater, 1))
		adjustWater(round(S.get_reagent_amount(/datum/reagent/water/holywater) * 1))
		adjustHealth(round(S.get_reagent_amount(/datum/reagent/water/holywater) * 0.1))

	// A variety of nutrients are dissolved in club soda, without sugar.
	// These nutrients include carbon, oxygen, hydrogen, phosphorous, potassium, sulfur and sodium, all of which are needed for healthy plant growth.
	if(S.has_reagent(/datum/reagent/consumable/sodawater, 1))
		adjustWater(round(S.get_reagent_amount(/datum/reagent/consumable/sodawater) * 1))
		adjustHealth(round(S.get_reagent_amount(/datum/reagent/consumable/sodawater) * 0.1))
		adjustNutri(round(S.get_reagent_amount(/datum/reagent/consumable/sodawater) * 0.1))

	// Sulphuric Acid
	if(S.has_reagent(/datum/reagent/toxin/acid, 1))
		adjustHealth(-round(S.get_reagent_amount(/datum/reagent/toxin/acid) * 1))
		adjustToxic(round(S.get_reagent_amount(/datum/reagent/toxin/acid) * 1.5))
		adjustWeeds(-rand(1,2))

	// Acid
	if(S.has_reagent(/datum/reagent/toxin/acid/fluacid, 1))
		adjustHealth(-round(S.get_reagent_amount(/datum/reagent/toxin/acid/fluacid) * 2))
		adjustToxic(round(S.get_reagent_amount(/datum/reagent/toxin/acid/fluacid) * 3))
		adjustWeeds(-rand(1,4))

	// Plant-B-Gone is just as bad
	if(S.has_reagent(/datum/reagent/toxin/plantbgone, 1))
		adjustHealth(-round(S.get_reagent_amount(/datum/reagent/toxin/plantbgone) * 5))
		adjustToxic(round(S.get_reagent_amount(/datum/reagent/toxin/plantbgone) * 6))
		adjustWeeds(-rand(4,8))

	// Napalm, not known for being good for anything organic
	if(S.has_reagent(/datum/reagent/napalm, 1))
		if(!(myseed.resistance_flags & FIRE_PROOF))
			adjustHealth(-round(S.get_reagent_amount(/datum/reagent/napalm) * 6))
			adjustToxic(round(S.get_reagent_amount(/datum/reagent/napalm) * 7))
			adjustWeeds(-rand(5,9))

	//Weed Spray
	if(S.has_reagent(/datum/reagent/toxin/plantbgone/weedkiller, 1))
		adjustToxic(round(S.get_reagent_amount(/datum/reagent/toxin/plantbgone/weedkiller) * 0.5))
		//old toxicity was 4, each spray is default 10 (minimal of 5) so 5 and 2.5 are the new ammounts
		adjustWeeds(-rand(1,2))

	//Pest Spray
	if(S.has_reagent(/datum/reagent/toxin/pestkiller, 1))
		adjustToxic(round(S.get_reagent_amount(/datum/reagent/toxin/pestkiller) * 0.5))
		adjustPests(-rand(1,2))

	// Healing
	if(S.has_reagent(/datum/reagent/medicine/cryoxadone, 1))
		adjustHealth(round(S.get_reagent_amount(/datum/reagent/medicine/cryoxadone) * 3))
		adjustToxic(-round(S.get_reagent_amount(/datum/reagent/medicine/cryoxadone) * 3))

	// Ammonia is bad ass.
	if(S.has_reagent(/datum/reagent/ammonia, 1))
		adjustHealth(round(S.get_reagent_amount(/datum/reagent/ammonia) * 0.5))
		adjustNutri(round(S.get_reagent_amount(/datum/reagent/ammonia) * 1))
		if(myseed)
			myseed.adjust_yield(round(S.get_reagent_amount(/datum/reagent/ammonia) * 0.01))

	// Saltpetre is used for gardening IRL, to simplify highly, it speeds up growth and strengthens plants
	if(S.has_reagent(/datum/reagent/saltpetre, 1))
		var/salt = S.get_reagent_amount(/datum/reagent/saltpetre)
		adjustHealth(round(salt * 0.25))
		if (myseed)
			myseed.adjust_production(-round(salt/100)-prob(salt%100))
			myseed.adjust_potency(round(salt*0.5))
	// Ash is also used IRL in gardening, as a fertilizer enhancer and weed killer
	if(S.has_reagent(/datum/reagent/ash, 1))
		adjustHealth(round(S.get_reagent_amount(/datum/reagent/ash) * 0.25))
		adjustNutri(round(S.get_reagent_amount(/datum/reagent/ash) * 0.5))
		adjustWeeds(-1)

	// Diethylamine is more bad ass, and pests get hurt by the corrosive nature of it, not the plant.
	if(S.has_reagent(/datum/reagent/diethylamine, 1))
		adjustHealth(round(S.get_reagent_amount(/datum/reagent/diethylamine) * 1))
		adjustNutri(round(S.get_reagent_amount(/datum/reagent/diethylamine) * 2))
		if(myseed)
			myseed.adjust_yield(round(S.get_reagent_amount(/datum/reagent/diethylamine) * 0.02))
		adjustPests(-rand(1,2))

	// Enduro Grow sacrifices potency + yield for endurance
	if(S.has_reagent(/datum/reagent/plantnutriment/endurogrow, 1))
		myseed.adjust_potency(-round(S.get_reagent_amount(/datum/reagent/plantnutriment/endurogrow) * 0.1))
		myseed.adjust_yield(-round(S.get_reagent_amount(/datum/reagent/plantnutriment/endurogrow) * 0.075))
		myseed.adjust_endurance(round(S.get_reagent_amount(/datum/reagent/plantnutriment/endurogrow) * 0.35))

	// Liquid Earthquake increases production speed but increases weeds
	if(S.has_reagent(/datum/reagent/plantnutriment/liquidearthquake, 1))
		myseed.adjust_weed_rate(round(S.get_reagent_amount(/datum/reagent/plantnutriment/liquidearthquake) * 0.1))
		myseed.adjust_weed_chance(round(S.get_reagent_amount(/datum/reagent/plantnutriment/liquidearthquake) * 0.3))
		myseed.adjust_production(round(S.get_reagent_amount(/datum/reagent/plantnutriment/liquidearthquake) * 0.075))

	// Nutriment Compost, effectively
	if(S.has_reagent(/datum/reagent/consumable/nutriment, 1))
		adjustHealth(round(S.get_reagent_amount(/datum/reagent/consumable/nutriment) * 0.5))
		adjustNutri(round(S.get_reagent_amount(/datum/reagent/consumable/nutriment) * 1))

	// Virusfood Compost for EVERYTHING
	if(S.has_reagent(/datum/reagent/toxin/mutagen/mutagenvirusfood, 1))
		adjustNutri(round(S.get_reagent_amount(/datum/reagent/toxin/mutagen/mutagenvirusfood) * 0.5))
		adjustHealth(-round(S.get_reagent_amount(/datum/reagent/toxin/mutagen/mutagenvirusfood) * 0.5))

	// Blood
	if(S.has_reagent(/datum/reagent/blood, 1))
		adjustNutri(round(S.get_reagent_amount(/datum/reagent/blood) * 1))
		adjustPests(rand(2,4))

	// Strange reagent
	if(S.has_reagent(/datum/reagent/medicine/strange_reagent, 1))
		spawnplant()

	// Adminordrazine the best stuff there is. For testing/debugging.
	if(S.has_reagent(/datum/reagent/medicine/adminordrazine, 1))
		adjustWater(round(S.get_reagent_amount(/datum/reagent/medicine/adminordrazine) * 1))
		adjustHealth(round(S.get_reagent_amount(/datum/reagent/medicine/adminordrazine) * 1))
		adjustNutri(round(S.get_reagent_amount(/datum/reagent/medicine/adminordrazine) * 1))
		adjustPests(-rand(1,5))
		adjustWeeds(-rand(1,5))
	if(S.has_reagent(/datum/reagent/medicine/adminordrazine, 5))
		switch(rand(100))
			if(66 to 100)
				mutatespecie()
			if(33 to 65)
				mutateweed()
			if(1 to 32)
				mutatepest(user)
			else
				to_chat(user, "<span class='warning'>Nothing happens...</span>")
