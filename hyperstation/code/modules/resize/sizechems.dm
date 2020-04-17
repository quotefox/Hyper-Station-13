//Size Chemicals, now with better and less cringy names.

/datum/reagent/dahl/growthchem
	name = "Prospacillin"
	id = "growthchem"
	description = "A stabilized altercation of size-altering liquids, this one appears to increase cell volume."
	color = "#E70C0C"
	taste_description = "a sharp, fiery and intoxicating flavour."
	overdose_threshold = 10
	metabolization_rate = 0.25
	can_synth = FALSE //DO NOT MAKE THIS SNYTHESIZABLE, THESE CHEMS ARE SUPPOSED TO NOT BE USED COMMONLY

/datum/reagent/dahl/growthchem/on_mob_add(mob/living/carbon/M)
	log_game("SIZECODE: [M] ckey: [M.key] has ingested growthchem.")

/datum/reagent/dahl/growthchem/on_mob_life(mob/living/carbon/M)
	if(M.size_multiplier < RESIZE_MACRO)
		M.resize(M.size_multiplier+0.01)

	return

/datum/reagent/dahl/shrinkchem
	name = "Diminicillin"
	id = "shrinkchem"
	description = "A stabilized altercation of size-altering liquids, this one appears to decrease cell volume."
	color = "#0C26E7"
	taste_description = "a pungent, acidic and jittery flavour."
	overdose_threshold = 10
	metabolization_rate = 0.25
	can_synth = FALSE //SAME STORY AS ABOVE

/datum/reagent/dahl/shrinkchem/on_mob_add(mob/living/carbon/M)
	log_game("SIZECODE: [M] ckey: [M.key] has ingested shrinkchem.")

/datum/reagent/dahl/shrinkchem/on_mob_life(mob/living/carbon/M)
	if(M.size_multiplier > RESIZE_MICRO)
		M.resize(M.size_multiplier-0.01)

	return

