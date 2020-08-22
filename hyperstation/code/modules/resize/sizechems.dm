//Size Chemicals, now with better and less cringy names.

/datum/reagent/growthchem
	name = "Prospacillin"
	id = "growthchem"
	description = "A stabilized altercation of size-altering liquids, this one appears to increase cell volume."
	color = "#E70C0C"
	taste_description = "a sharp, fiery and intoxicating flavour"
	overdose_threshold = 10
	metabolization_rate = 0.25
	can_synth = FALSE //DO NOT MAKE THIS SNYTHESIZABLE, THESE CHEMS ARE SUPPOSED TO NOT BE USED COMMONLY

/datum/reagent/growthchem/on_mob_add(mob/living/carbon/M)
	. = ..()
	if(ishuman(M))
		log_game("SIZECODE: [M] ckey: [M.key] has ingested growthchem.")

/datum/reagent/growthchem/on_mob_life(mob/living/carbon/M)
	if(!ishuman(M))
		return..()
	if(M.size_multiplier < RESIZE_MACRO)
		M.resize(M.size_multiplier+0.025)
		M.visible_message("<span class='danger'>[pick("[M] grows!", "[M] expands in size!", "[M] pushes outwards in stature!")]</span>", "<span class='danger'>[pick("You feel your body fighting for space and growing!", "The world contracts inwards in every direction!", "You feel your muscles expand, and your surroundings shrink!")]</span>")
	..()
	. = 1

/datum/reagent/shrinkchem
	name = "Diminicillin"
	id = "shrinkchem"
	description = "A stabilized altercation of size-altering liquids, this one appears to decrease cell volume."
	color = "#0C26E7"
	taste_description = "a pungent, acidic and jittery flavour"
	overdose_threshold = 10
	metabolization_rate = 1
	can_synth = FALSE //SAME STORY AS ABOVE

/datum/reagent/shrinkchem/on_mob_add(mob/living/carbon/M)
	. = ..()
	if(ishuman(M))
		log_game("SIZECODE: [M] ckey: [M.key] has ingested shrinkchem.")

/datum/reagent/shrinkchem/on_mob_life(mob/living/carbon/M)
	if(!ishuman(M))
		return..()
	if(M.size_multiplier > RESIZE_MICRO)
		M.resize(M.size_multiplier-0.025)
		M.visible_message("<span class='danger'>[pick("[M] shrinks down!", "[M] dwindles in size!", "[M] compresses down!")]</span>", "<span class='danger'>[pick("You feel your body compressing in size!", "The world pushes outwards in every direction!", "You feel your muscles contract, and your surroundings grow!")]</span>")
	..()
	. = 1
