/*
from modular_citadel/code/modules/mob/dead/new_player/sprite_accessories.dm:
/datum/sprite_accessory
    var/extra = FALSE
    var/extra_color_src = MUTCOLORS2	//The color source for the extra overlay.
    var/extra2 = FALSE
    var/extra_icon = 'modular_citadel/icons/mob/mam_tails.dmi'
    var/extra2_icon = 'modular_citadel/icons/mob/mam_tails.dmi'
    var/extra2_color_src = MUTCOLORS3
    var/list/ckeys_allowed

we use the "citadel" versions of mutant/species parts, which usually (but not always)
begins with "mam_" somewhere. stuff that's built for only humans/lizards in other parts
of the code are from TG, don't use those.

keep everything in alphabetical order, please!
*/


// TODO: code it so that we don't have to type in "icon = 'hyperstation/icons/mob/etc'"
// manually for hyperstation parts


/*
SNOUTS
==========================================================
*/


/*
EARS
==========================================================
*/


/*
TAILS + ANIMATED TAILS
==========================================================
*/

// "fan" bird tail, short
/datum/sprite_accessory/mam_tails/shorthawk
	name = "Hawk - Short"
	icon_state = "shorthawk"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

/datum/sprite_accessory/mam_tails_animated/shorthawk
	name = "Hawk - Short"
	icon_state = "shorthawk"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

// "narrow" bird tail, long
/datum/sprite_accessory/mam_tails/longpigeon
	name = "Pigeon - Long"
	icon_state = "longpigeon"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

/datum/sprite_accessory/mam_tails_animated/longpigeon
	name = "Pigeon - Long"
	icon_state = "longpigeon"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

// "narrow" bird tail, short
/datum/sprite_accessory/mam_tails/shortpigeon
	name = "Pigeon - Short"
	icon_state = "shortpigeon"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

/datum/sprite_accessory/mam_tails_animated/shortpigeon
	name = "Pigeon - Short"
	icon_state = "shortpigeon"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

// "forked" bird tail, long
/datum/sprite_accessory/mam_tails/swallow
	name = "Swallow"
	icon_state = "swallow"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

/datum/sprite_accessory/mam_tails_animated/swallow
	name = "Swallow"
	icon_state = "swallow"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

// forked bird tail, long; special stripe markings
/datum/sprite_accessory/mam_tails/swallowstriped
	name = "Swallow - Striped"
	icon_state = "swallowstriped"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

/datum/sprite_accessory/mam_tails_animated/swallowstriped
	name = "Swallow - Striped"
	icon_state = "swallowstriped"
	icon = 'hyperstation/icons/mob/char_tails.dmi'


/*
BODY MARKINGS
==========================================================
*/

/*
from modular_citadel/code/modules/mob/dead/new_player/sprite_accessories.dm:
/datum/sprite_accessory/mam_body_markings
	extra = FALSE
	extra2 = FALSE
	color_src = MATRIXED
	gender_specific = 0
	icon = 'modular_citadel/icons/mob/mam_markings.dmi'
	recommended_species = list("mammal", "xeno", "slimeperson", "podweak", "avian", "aquatic")
*/

/datum/sprite_accessory/mam_body_markings/pigeon
	name = "Pigeon"
	icon_state = "pigeon"
	icon = 'hyperstation/icons/mob/char_markings.dmi'
	recommended_species = list("avian")

/datum/sprite_accessory/mam_body_markings/shrike
	name = "Shrike"
	icon_state = "shrike"
	icon = 'hyperstation/icons/mob/char_markings.dmi'
	recommended_species = list("avian")


/*
TAUR BODIES
==========================================================
*/

/*
from modular_citadel/code/modules/mob/dead/new_player/sprite_accessories.dm:
/datum/sprite_accessory/taur
	icon = 'modular_citadel/icons/mob/mam_taur.dmi'
	extra_icon = 'modular_citadel/icons/mob/mam_taur.dmi'
	extra = TRUE
	extra2_icon = 'modular_citadel/icons/mob/mam_taur.dmi'
	extra2 = TRUE
	center = TRUE
	dimension_x = 64
	var/taur_mode = NOT_TAURIC
	color_src = MATRIXED
	recommended_species = list("human", "lizard", "insect", "mammal", "xeno", "jelly", "slimeperson", "podweak", "avian", "aquatic")
*/


/*
HAIRSTYLES
==========================================================
*/