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

/datum/reagent/medicine/ibuprofen
	name = "Ibuprofen"
	description = "A milder painkiller with a higher overdose threshold than morphine and fewer ill effects."
	reagent_state = LIQUID
	color = "#E6E6E6"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 60
	//addiction_threshold = 25
	pH = 4

/datum/reagent/medicine/ibuprofen/on_mob_life(mob/living/carbon/M)
	M.adjustPainLoss(-1.5*REM, 0)// mild painkiller. Better than bicardine, worse than morphine.
	..()

/datum/reagent/medicine/ibuprofen/overdose_process(mob/living/M)
	if(prob(15))
		//M.drop_all_held_items()
		M.Dizzy(3)
	..()