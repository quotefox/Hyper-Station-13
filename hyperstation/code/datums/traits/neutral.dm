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

/datum/quirk/heat
	name = "Estrus Detection"
	desc = "You have a animalistic sense of detecting if someone is in heat, and can get pregnant."
	value = 0
	mob_trait = TRAIT_HEAT_DETECT
	gain_text = "<span class='notice'>You feel your senses adjust, allowing a animalistic sense of other's fertility.</span>"
	lose_text = "<span class='notice'>You feel your sense of other's fertility fade.</span>"


/datum/quirk/inheat
	name = "In Heat"
	desc = "Your system burns with the desire to be bred, your body will betray you and alert other people who can detect it. This requires a womb that can be impregnated."
	value = 0
	mob_trait = TRAIT_HEAT
	gain_text = "<span class='notice'>You body burns with the desire to be bred.</span>"
	lose_text = "<span class='notice'>You feel more in control of your body and thoughts.</span>"
