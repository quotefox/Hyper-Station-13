/datum/reagent/medicine/copium
	name = "copium"
	description = "A heavy scented substance meant to help one deal with loss."
	reagent_state = LIQUID
	color = "#a8707e"
	overdose_threshold = 21
	metabolization_rate = 0.75 * REAGENTS_METABOLISM
	pH = 4

/datum/reagent/medicine/copium/on_mob_life(mob/living/carbon/M)
	var/datum/component/mood/mood = M.GetComponent(/datum/component/mood)
	if(mood.sanity <= SANITY_NEUTRAL && current_cycle >= 5)
		mood.setSanity(min(mood.sanity+5, SANITY_NEUTRAL))
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "copium", /datum/mood_event/copium)
	..()

/datum/reagent/medicine/copium/overdose_process(mob/living/carbon/M) //copious amounts of copium
	M.blur_eyes(10)
	if(prob(50))
		M.adjustToxLoss(1, 0)
	if(prob(5))
		M.say(pick("That's okay. Things are going to be okay.", "This is fine.", "I'm okay with the events that are unfolding currently.", "World of Spacecraft is still a good game...", "I'm winning.", "Diesels are far more powerful."))
	if(prob(5))
		M.emote("me", 1, "seems to be crying.")
	if(prob(4))
		M.emote("me", 1, "falls over, crying.")
		M.Knockdown(40)

//To-do: /datum/reagent/medicine/seethium
