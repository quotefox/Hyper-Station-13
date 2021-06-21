

//Jay Sparrow
/datum/quirk/cum_plus
	name = "Extra productive genitals"
	desc = "Your lower bits produce more and hold more than normal."
	value = 0
	category = CATEGORY_SEXUAL
	mob_trait = TRAIT_CUM_PLUS
	gain_text = "<span class='notice'>You feel pressure in your groin.</span>"
	lose_text = "<span class='notice'>You feel a weight lifted from your groin.</span>"
	medical_record_text = "Patient has greatly increased production of sexual fluids"

/datum/quirk/cum_plus/add()
	var/mob/living/carbon/M = quirk_holder
	if(M.getorganslot("testicles"))
		var/obj/item/organ/genital/testicles/T = M.getorganslot("testicles")
		T.fluid_mult = 1.5 //Base is 1
		T.fluid_max_volume = 5

/datum/quirk/cum_plus/remove()
	var/mob/living/carbon/M = quirk_holder
	if(quirk_holder.getorganslot("testicles"))
		var/obj/item/organ/genital/testicles/T = M.getorganslot("testicles")
		T.fluid_mult = 1 //Base is 1
		T.fluid_max_volume = 3 //Base is 3

/datum/quirk/cum_plus/on_process()
	var/mob/living/carbon/M = quirk_holder //If you get balls later, then this will still proc
	if(M.getorganslot("testicles"))
		var/obj/item/organ/genital/testicles/T = M.getorganslot("testicles")
		if(T.fluid_max_volume <= 5 || T.fluid_mult <= 0.2) //INVALID EXPRESSION?
			T.fluid_mult = 1.5 //Base is 0.133
			T.fluid_max_volume = 5
