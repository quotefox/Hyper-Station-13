/datum/reagent/consumable/pilk
	name = "Pilk"
	description = "A forbidden mixture that dates back to the early days of space civilization, its creation is known to have caused at least one or two massacres."
	color = "#cf9f6f"
	taste_description = "heresy"
	glass_icon_state  = "whiskeycolaglass"
	glass_name = "glass of Pilk"
	glass_desc = "Why would you do this to yourself?"
	hydration = 3

/datum/reagent/consumable/pilk/on_mob_life(mob/living/carbon/M)
	M.drowsyness = max(0,M.drowsyness-3)
	M.adjust_bodytemperature(-3 * TEMPERATURE_DAMAGE_COEFFICIENT, BODYTEMP_NORMAL)
	if(HAS_TRAIT(M, TRAIT_CALCIUM_HEALER))
		M.heal_bodypart_damage(0.75,0, 0)
		. = 1
	else
		if(M.getBruteLoss() && prob(20))
			M.heal_bodypart_damage(0.5,0, 0)
			. = 1
	if(holder.has_reagent(/datum/reagent/consumable/capsaicin))
		holder.remove_reagent(/datum/reagent/consumable/capsaicin, 1)
	..()
