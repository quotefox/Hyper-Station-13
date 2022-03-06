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

/datum/sprite_accessory/mam_snouts/bigmandible // sarcoph @ hyperstation, march 2022
	name = "Big Mandibles (Hyper)"
	icon_state = "bigmandible"
	icon = 'hyperstation/icons/mob/char_snouts.dmi'
	recommended_species = list("insect")

/datum/sprite_accessory/mam_snouts/proboscis // sarcoph @ hyperstation, march 2022
	name = "Proboscis (Hyper)"
	icon_state = "proboscis"
	icon = 'hyperstation/icons/mob/char_snouts.dmi'
	recommended_species = list("insect")

/datum/sprite_accessory/mam_snouts/rhinobeetle // sarcoph @ hyperstation, march 2022
	name = "Rhino Beetle (Hyper)"
	icon_state = "rhinobeetle"
	icon = 'hyperstation/icons/mob/char_snouts.dmi'
	recommended_species = list("insect")

/datum/sprite_accessory/mam_snouts/scarab // sarcoph @ hyperstation, march 2022
	name = "Scarab Beetle (Hyper)"
	icon_state = "scarab"
	icon = 'hyperstation/icons/mob/char_snouts.dmi'
	recommended_species = list("insect")

/datum/sprite_accessory/mam_snouts/smallmandible // sarcoph @ hyperstation, march 2022
	name = "Small Mandibles (Hyper)"
	icon_state = "smallmandible"
	icon = 'hyperstation/icons/mob/char_snouts.dmi'
	recommended_species = list("insect")

/datum/sprite_accessory/mam_snouts/spider // sarcoph @ hyperstation, march 2022
	name = "Spider (Hyper)"
	icon_state = "spider"
	icon = 'hyperstation/icons/mob/char_snouts.dmi'
	recommended_species = list("insect")

/datum/sprite_accessory/mam_snouts/tarantula // sarcoph @ hyperstation, march 2022
	name = "Tarantula (Hyper)"
	icon_state = "tarantula"
	icon = 'hyperstation/icons/mob/char_snouts.dmi'
	recommended_species = list("insect")


/*
EARS
==========================================================
*/

/datum/sprite_accessory/mam_ears/moth
	name = "Moth (Hyper)"
	icon_state = "moth"
	icon = 'hyperstation/icons/mob/char_ears.dmi'
	recommended_species = list("insect")


/*
WINGS
==========================================================
*/

/datum/sprite_accessory/deco_wings/minibat // sarcoph @ hyperstation, march 2022
	name = "Mini Bat (Hyper)"
	icon_state = "minibat"
	icon = 'hyperstation/icons/mob/char_wings.dmi'

/datum/sprite_accessory/deco_wings/minifeather // sarcoph @ hyperstation, march 2022
	name = "Mini Feather (Hyper)"
	icon_state = "minifeather"
	icon = 'hyperstation/icons/mob/char_wings.dmi'

/datum/sprite_accessory/deco_wings/tinybat // sarcoph @ hyperstation, march 2022
	name = "Tiny Bat (Hyper)"
	icon_state = "tinybat"
	icon = 'hyperstation/icons/mob/char_wings.dmi'

/datum/sprite_accessory/deco_wings/tinyfeather // sarcoph @ hyperstation, march 2022
	name = "Tiny Feather (Hyper)"
	icon_state = "tinyfeather"
	icon = 'hyperstation/icons/mob/char_wings.dmi'


/*
TAILS + ANIMATED TAILS
==========================================================
*/

// "fan" bird tail, short
/datum/sprite_accessory/mam_tails/shorthawk // sarcoph @ hyperstation, jan 2022
	name = "Hawk - Short (Hyper)"
	icon_state = "shorthawk"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

/datum/sprite_accessory/mam_tails_animated/shorthawk // sarcoph @ hyperstation, jan 2022
	name = "Hawk - Short (Hyper)"
	icon_state = "shorthawk"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

// "narrow" bird tail, long
/datum/sprite_accessory/mam_tails/longpigeon // sarcoph @ hyperstation, jan 2022
	name = "Pigeon - Long (Hyper)"
	icon_state = "longpigeon"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

/datum/sprite_accessory/mam_tails_animated/longpigeon // sarcoph @ hyperstation, jan 2022
	name = "Pigeon - Long (Hyper)"
	icon_state = "longpigeon"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

// "narrow" bird tail, short
/datum/sprite_accessory/mam_tails/shortpigeon // sarcoph @ hyperstation, jan 2022
	name = "Pigeon - Short (Hyper)"
	icon_state = "shortpigeon"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

/datum/sprite_accessory/mam_tails_animated/shortpigeon // sarcoph @ hyperstation, jan 2022
	name = "Pigeon - Short (Hyper)"
	icon_state = "shortpigeon"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

// "forked" bird tail, long
/datum/sprite_accessory/mam_tails/swallow // sarcoph @ hyperstation, jan 2022
	name = "Swallow (Hyper)"
	icon_state = "swallow"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

/datum/sprite_accessory/mam_tails_animated/swallow // sarcoph @ hyperstation, jan 2022
	name = "Swallow (Hyper)"
	icon_state = "swallow"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

// forked bird tail, long; special stripe markings
/datum/sprite_accessory/mam_tails/swallowstriped // sarcoph @ hyperstation, jan 2022
	name = "Swallow - Striped (Hyper)"
	icon_state = "swallowstriped"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

/datum/sprite_accessory/mam_tails_animated/swallowstriped // sarcoph @ hyperstation, jan 2022
	name = "Swallow - Striped (Hyper)"
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

/datum/sprite_accessory/mam_body_markings/bee
	name = "Bee (Hyper)"
	icon_state = "bee"
	icon = 'hyperstation/icons/mob/char_markings.dmi'
	recommended_species = list("insect")

/datum/sprite_accessory/mam_body_markings/moth // sarcoph @ hyperstation, jan 2022
	name = "Moth (Hyper)"
	icon_state = "moth"
	icon = 'hyperstation/icons/mob/char_markings.dmi'
	recommended_species = list("insect")

/datum/sprite_accessory/mam_body_markings/empty
	name = "None (Hyper)"
	icon_state = "empty"
	recommended_species = list("podweak", /*"mammal",*/ "avian", "aquatic", "insect", "xeno", "synthliz", "slimeperson")
	// mammals are cursed to no empty markings until they get their heads fixed.

/datum/sprite_accessory/mam_body_markings/pigeon // sarcoph @ hyperstation, jan 2022
	name = "Pigeon (Hyper)"
	icon_state = "pigeon"
	icon = 'hyperstation/icons/mob/char_markings.dmi'
	recommended_species = list("avian")

/datum/sprite_accessory/mam_body_markings/shrike // sarcoph @ hyperstation, jan 2022
	name = "Shrike (Hyper)"
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

/*
from code/modules/mob/dead/new_player/sprite_accessories/hair_head.dm:
/datum/sprite_accessory/hair
	icon = 'icons/mob/human_face.dmi'	  // default icon for all hairs

	// please make sure they're sorted alphabetically and, where needed, categorized
	// try to capitalize the names please~
	// try to spell
	// you do not need to define _s or _l sub-states, game automatically does this for you
*/

/datum/sprite_accessory/hair/aviancrest
	name = "Avian Crest (Hyper)"
	icon_state = "hair_aviancrest"
	icon = 'hyperstation/icons/mob/char_hair.dmi'

/datum/sprite_accessory/hair/curtains
	name = "Curtains (Hyper)"
	icon_state = "hair_curtains"

/datum/sprite_accessory/hair/mommy
	name = "Hairfre (Hyper)"
	icon_state = "hair_hairfre"

/datum/sprite_accessory/hair/sidehair
	name = "Side Hair (Hyper)"
	icon_state = "hair_tailhair2"
	ckeys_allowed = list("quotefox")
