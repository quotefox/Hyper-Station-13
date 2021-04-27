//Skyrat port start
/datum/quirk/alcohol_lightweight
	name = "Alcoholic Lightweight"
	desc = "Alcohol really goes straight to your head, gotta be careful with what you drink."
	value = 0
	mob_trait = TRAIT_ALCOHOL_LIGHTWEIGHT
	gain_text = "<span class='notice'>You feel woozy thinking of alcohol.</span>"
	lose_text = "<span class='notice'>You regain your stomach for drinks.</span>"
//Skyrat port stop

/datum/quirk/cursed_blood
	name = "Cursed Blood"
	desc = "Your lineage is cursed with the paleblood curse. Best to stay away from holy water... Hell water, on the other hand..."
	value = 0
	mob_trait = TRAIT_CURSED_BLOOD
	gain_text = "<span class='notice'>A curse from a land where men return as beasts runs deep in your blood. Best to stay away from holy water... Hell water, on the other hand...</span>"
	lose_text = "<span class='notice'>You feel the weight of the curse in your blood finally gone.</span>"
	medical_record_text = "Patient suffers from an unknown type of aversion to holy reagents. Keep them away from a chaplain."

/* Disabled for now, some scripts not working.
/datum/quirk/heat
	name = "Estrus Detection"
	desc = "You have a animalistic sense of detecting if someone is in heat, and can get pregnant."
	value = 0
	mob_trait = TRAIT_HEAT_DETECT
	gain_text = "<span class='notice'>You feel your senses adjust, allowing a animalistic sense of others' fertility.</span>"
	lose_text = "<span class='notice'>You feel your sense of others' fertility fade.</span>"
*/

/datum/quirk/inheat
	name = "In Heat"
	desc = "Your system burns with the desire to be bred, your body will betray you and alert others' to your desire when examining you. Satisfying your lust will make you happy, but ignoring it may cause you to become sad and needy."
	value = 0
	mob_trait = TRAIT_HEAT
	gain_text = "<span class='notice'>You body burns with the desire to be bred.</span>"
	lose_text = "<span class='notice'>You feel more in control of your body and thoughts.</span>"

/datum/quirk/overweight
	name = "Overweight"
	desc = "You're particularly fond of food, and join the round being overweight."
	value = 0
	gain_text = "<span class='notice'>You feel a bit chubby!</span>"
	//no lose_text cause why would there be?

/datum/quirk/overweight/on_spawn()
	var/mob/living/M = quirk_holder
	M.nutrition = rand(NUTRITION_LEVEL_FAT + NUTRITION_LEVEL_START_MIN, NUTRITION_LEVEL_FAT + NUTRITION_LEVEL_START_MAX)
	M.overeatduration = 100
	ADD_TRAIT(M, TRAIT_FAT, OBESITY)

/datum/quirk/virile
	name = "Virile"
	desc = "Either through higher quality sperms, more of them, or just being more horny, your impregnation chance will increase by 20-30%."
	value = 1
	medical_record_text = "Patient has a higher sperm count."
	mob_trait = TRAIT_VIRILE
	gain_text = "<span class='notice'>You feel more potent."
	lose_text = "<span class='notice'>You feel less potent."
	var/ichange = 0

/datum/quirk/virile/add()
	ichange = rand(20,30)
	quirk_holder.impregchance += ichange

/datum/quirk/virile/remove()
	if(quirk_holder)
		quirk_holder.impregchance -= ichange


/datum/quirk/macrophile
	name = "Macrophile"
	desc = "You are attracted to larger people, and being stepped on by them."
	value = 0
	mob_trait = TRAIT_MACROPHILE
	gain_text = "<span class='notice'>You feel attracted to people larger than you."
	lose_text = "<span class='notice'>You feel less attracted to people larger than you."

/datum/quirk/microphile
	name = "Microphile"
	desc = "You are attracted to smaller people, and stepping on them."
	value = 0
	mob_trait = TRAIT_MICROPHILE
	gain_text = "<span class='notice'>You feel attracted to people smaller than you."
	lose_text = "<span class='notice'>You feel less attracted to people smaller than you."
