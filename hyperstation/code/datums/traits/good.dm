/datum/quirk/narsianspeaker
	name = "Nar-Sian speaker"
	desc = "Obsessed with forbidden knowledge regarding the blood cult, you've learned how to speak their ancient language."
	value = 1
	category = CATEGORY_LANGUAGES
	gain_text = "<span class='notice'>Your mind feels sensitive to the slurred, ancient language of Nar'Sian cultists.</span>"
	lose_text = "<span class='notice'>You forget how to speak Nar'Sian!</span>"

/datum/quirk/narsianspeaker/add()
	var/mob/living/M = quirk_holder
	M.grant_language(/datum/language/narsie)

/datum/quirk/narsianspeaker/remove()
	if(quirk_holder)
		quirk_holder.remove_language(/datum/language/ratvar)

/datum/quirk/ratvarianspeaker
	name = "Ratvarian speaker"
	desc = "Obsessed with the inner workings of the clock cult, you've learned how to speak their language."
	value = 1
	category = CATEGORY_LANGUAGES
	gain_text = "<span class='notice'>Your mind feels sensitive to the ancient language of Ratvarian cultists.</span>"
	lose_text = "<span class='notice'>You forget how to speak Ratvarian!</span>"

/datum/quirk/ratvarianspeaker/add()
	var/mob/living/M = quirk_holder
	M.grant_language(/datum/language/ratvar)

/datum/quirk/ratvarianspeaker/remove()
	if(quirk_holder)
		quirk_holder.remove_language(/datum/language/ratvar)

/datum/quirk/encodedspeaker
	name = "Encoded Audio speaker"
	desc = "You've been augmented with language encoders, allowing you to understand encoded audio."
	value = 1
	category = CATEGORY_LANGUAGES
	gain_text = "<span class='notice'>Your mouth feels a little weird for a moment as your language encoder kicks in.</span>"
	lose_text = "<span class='notice'>You feel your encoded audio chip malfunction. You can no longer speak or understand the language of fax machines.</span>"

/datum/quirk/encodedspeaker/add()
	var/mob/living/M = quirk_holder
	M.grant_language(/datum/language/machine)

/datum/quirk/encodedspeaker/remove()
	if(quirk_holder)
		quirk_holder.remove_language(/datum/language/ratvar)

/datum/quirk/xenospeaker
	name = "Xenocommon speaker"
	desc = "Through time observing and interacting with xenos and xeno hybrids, you've learned the intricate hissing patterns of their language."
	value = 1
	category = CATEGORY_LANGUAGES
	gain_text = "<span class='notice'>You feel that you are now able to hiss in the same way xenomorphs do.</span>"
	lose_text = "<span class='notice'>You seem to no longer know how to speak xenocommon.</span>"

/datum/quirk/xenospeaker/add()
	var/mob/living/M = quirk_holder
	M.grant_language(/datum/language/xenocommon)

/datum/quirk/xenospeaker/remove()
	if(quirk_holder)
		quirk_holder.remove_language(/datum/language/ratvar)
