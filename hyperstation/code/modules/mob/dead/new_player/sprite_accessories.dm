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

/datum/sprite_accessory/mam_snouts/easterndragon
	name = "Eastern Dragon (Hyper)"
	icon_state = "easterndw"
	icon = 'hyperstation/icons/mob/char_snouts.dmi'

/datum/sprite_accessory/mam_snouts/feasterndragon
	name = "Eastern Dragon (Top) (Hyper)"
	icon_state = "feasterndw"
	icon = 'hyperstation/icons/mob/char_snouts.dmi'

/datum/sprite_accessory/mam_snouts/easterndragonnowhiskers
	name = "Eastern Dragon - No Whiskers (Hyper)"
	icon_state = "easterndnw"
	icon = 'hyperstation/icons/mob/char_snouts.dmi'

/datum/sprite_accessory/mam_snouts/feasterndragonnowhiskers
	name = "Eastern Dragon - No Whiskers (Top) (Hyper)"
	icon_state = "feasterndnw"
	icon = 'hyperstation/icons/mob/char_snouts.dmi'

/datum/sprite_accessory/mam_snouts/knshuttle // Dahlular and Arcstaisia @ hyperstation, april 2022. Feel free to remove comment. Just remember this is snowflakey Kinaris stuff.
	name = "Kinaris - Shuttle (Hyper)"
	icon_state = "knshuttle"
	icon = 'hyperstation/icons/mob/char_snouts.dmi'

/datum/sprite_accessory/mam_snouts/fchemlight
	name = "RadDog (Top) (Hyper)"
	icon_state = "fchemlight"
	icon = 'hyperstation/icons/mob/char_snouts.dmi'

/datum/sprite_accessory/mam_snouts/chemlight
	name = "RadDog (Hyper)"
	icon_state = "chemlight"
	icon = 'hyperstation/icons/mob/char_snouts.dmi'

/*
EARS
==========================================================
*/

/datum/sprite_accessory/mam_ears/faceant // sarcoph @ hyperstation, march 2022
	name = "Face Antennae (Hyper)"
	icon_state = "faceant"
	icon = 'hyperstation/icons/mob/char_ears.dmi'
	recommended_species = list("insect")

/datum/sprite_accessory/mam_ears/faceant2 // sarcoph @ hyperstation, march 2022
	name = "Face Antennae 2 (Hyper)"
	icon_state = "faceant2"
	icon = 'hyperstation/icons/mob/char_ears.dmi'
	recommended_species = list("insect")

/datum/sprite_accessory/mam_ears/moth
	name = "Moth Antennae (Hyper)"
	icon_state = "moth"
	icon = 'hyperstation/icons/mob/char_ears.dmi'
	recommended_species = list("insect")

/datum/sprite_accessory/mam_ears/plumeant // sarcoph @ hyperstation, march 2022
	name = "Plume Antennae (Hyper)"
	icon_state = "plumeant"
	icon = 'hyperstation/icons/mob/char_ears.dmi'
	recommended_species = list("insect")

/datum/sprite_accessory/mam_ears/roundant // sarcoph @ hyperstation, march 2022
	name = "Round Antennae (Hyper)"
	icon_state = "roundant"
	icon = 'hyperstation/icons/mob/char_ears.dmi'
	recommended_species = list("insect")

/datum/sprite_accessory/mam_ears/thinant // sarcoph @ hyperstation, march 2022
	name = "Thin Antennae (Hyper)"
	icon_state = "thinant"
	icon = 'hyperstation/icons/mob/char_ears.dmi'
	recommended_species = list("insect")

/datum/sprite_accessory/mam_ears/easterndragon
	name = "Eastern Dragon (Hyper)"
	icon_state = "easternd"
	icon = 'hyperstation/icons/mob/char_ears.dmi'

/datum/sprite_accessory/mam_ears/knshuttle // Dahlular and Arcstaisia @ hyperstation, april 2022. Feel free to remove comment. Just remember this is snowflakey Kinaris stuff.
	name = "Kinaris - Shuttle (Hyper)"
	icon_state = "knshuttle"
	icon = 'hyperstation/icons/mob/char_ears.dmi'

/datum/sprite_accessory/mam_ears/chemlight
	name = "RadDog (Hyper)"
	icon_state = "chemlight"
	icon = 'hyperstation/icons/mob/char_ears.dmi'

/*
WINGS
==========================================================
*/

/datum/sprite_accessory/deco_wings/beetle // sarcoph @ hyperstation, march 2022
	name = "Beetle (Hyper)"
	icon_state = "beetle"
	icon = 'hyperstation/icons/mob/char_wings.dmi'

/datum/sprite_accessory/moth_wings/beetle
	name = "Beetle (Hyper)"
	icon_state = "beetle"
	icon = 'hyperstation/icons/mob/char_wings.dmi'

/datum/sprite_accessory/deco_wings/beetle2 // sarcoph @ hyperstation, march 2022
	name = "Beetle - 2-toned (Hyper)"
	icon_state = "beetle2"
	icon = 'hyperstation/icons/mob/char_wings.dmi'
	color_src = MATRIXED

/datum/sprite_accessory/moth_wings/beetle2
	name = "Beetle - 2-toned (Hyper)"
	icon_state = "beetle2"
	icon = 'hyperstation/icons/mob/char_wings.dmi'
	color_src = MATRIXED

/datum/sprite_accessory/deco_wings/insect // sarcoph @ hyperstation, march 2022
	name = "Insect (Hyper)"
	icon_state = "insect"
	icon = 'hyperstation/icons/mob/char_wings.dmi'

/datum/sprite_accessory/moth_wings/insect
	name = "Insect (Hyper)"
	icon_state = "insect"
	icon = 'hyperstation/icons/mob/char_wings.dmi'

/datum/sprite_accessory/deco_wings/knshuttle // Dahlular and Arcstaisia @ hyperstation, april 2022. Feel free to remove comment. Just remember this is snowflakey Kinaris stuff.
	name = "Kinaris - Shuttle (Hyper)"
	icon_state = "knshuttle"
	icon = 'hyperstation/icons/mob/char_wings.dmi'
	//recommended_species = list("synthliz") need to give synths a deco wing slot
	color_src = MATRIXED

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

/datum/sprite_accessory/mam_tails/bee // sarcoph @ hyperstation, march 2022
	name = "Bee (Hyper)"
	icon_state = "bee"
	icon = 'hyperstation/icons/mob/char_tails.dmi'
	recommended_species = list("insect")

/datum/sprite_accessory/mam_tails_animated/bee
	name = "Bee (Hyper)"
	icon_state = "bee"
	icon = 'hyperstation/icons/mob/char_tails.dmi'
	recommended_species = list("insect")

/datum/sprite_accessory/mam_tails/bee2 // sarcoph @ hyperstation, march 2022
	name = "Bee w/ Stinger (Hyper)"
	icon_state = "bee2"
	icon = 'hyperstation/icons/mob/char_tails.dmi'
	recommended_species = list("insect")

/datum/sprite_accessory/mam_tails_animated/bee2
	name = "Bee w/ Stinger (Hyper)"
	icon_state = "bee2"
	icon = 'hyperstation/icons/mob/char_tails.dmi'
	recommended_species = list("insect")

// "fan" bird tail, short
/datum/sprite_accessory/mam_tails/shorthawk // sarcoph @ hyperstation, jan 2022
	name = "Hawk - Short (Hyper)"
	icon_state = "shorthawk"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

/datum/sprite_accessory/mam_tails_animated/shorthawk
	name = "Hawk - Short (Hyper)"
	icon_state = "shorthawk"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

/datum/sprite_accessory/mam_tails/insect // sarcoph @ hyperstation, march 2022
	name = "Insect (Hyper)"
	icon_state = "insect"
	icon = 'hyperstation/icons/mob/char_tails.dmi'
	recommended_species = list("insect")

/datum/sprite_accessory/mam_tails_animated/insect
	name = "Insect (Hyper)"
	icon_state = "insect"
	icon = 'hyperstation/icons/mob/char_tails.dmi'
	recommended_species = list("insect")

/datum/sprite_accessory/mam_tails/bug2tone // sarcoph @ hyperstation, march 2022
	name = "Insect - 2-tone (Hyper)"
	icon_state = "bug2tone"
	icon = 'hyperstation/icons/mob/char_tails.dmi'
	recommended_species = list("insect")

/datum/sprite_accessory/mam_tails_animated/bug2tone
	name = "Insect - 2-tone (Hyper)"
	icon_state = "bug2tone"
	icon = 'hyperstation/icons/mob/char_tails.dmi'
	recommended_species = list("insect")

// "narrow" bird tail, long
/datum/sprite_accessory/mam_tails/longpigeon // sarcoph @ hyperstation, jan 2022
	name = "Pigeon - Long (Hyper)"
	icon_state = "longpigeon"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

/datum/sprite_accessory/mam_tails_animated/longpigeon
	name = "Pigeon - Long (Hyper)"
	icon_state = "longpigeon"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

// "narrow" bird tail, short
/datum/sprite_accessory/mam_tails/shortpigeon // sarcoph @ hyperstation, jan 2022
	name = "Pigeon - Short (Hyper)"
	icon_state = "shortpigeon"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

/datum/sprite_accessory/mam_tails_animated/shortpigeon
	name = "Pigeon - Short (Hyper)"
	icon_state = "shortpigeon"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

// "forked" bird tail, long
/datum/sprite_accessory/mam_tails/swallow // sarcoph @ hyperstation, jan 2022
	name = "Swallow (Hyper)"
	icon_state = "swallow"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

/datum/sprite_accessory/mam_tails_animated/swallow
	name = "Swallow (Hyper)"
	icon_state = "swallow"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

// forked bird tail, long; special stripe markings
/datum/sprite_accessory/mam_tails/swallowstriped // sarcoph @ hyperstation, jan 2022
	name = "Swallow - Striped (Hyper)"
	icon_state = "swallowstriped"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

/datum/sprite_accessory/mam_tails_animated/swallowstriped
	name = "Swallow - Striped (Hyper)"
	icon_state = "swallowstriped"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

/datum/sprite_accessory/mam_tails/easterndragon //Pulled base from Virgo, seriously love the server and love you guys, stay lovely.
	name = "Eastern Dragon (Hyper)"
	icon_state = "easternd"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

/datum/sprite_accessory/mam_tails_animated/easterndragon
	name = "Eastern Dragon (Hyper)"
	icon_state = "easternd"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

/datum/sprite_accessory/mam_tails/knshuttle // Dahlular and Arcstaisia @ hyperstation, april 2022. Feel free to remove comment. Just remember this is snowflakey Kinaris stuff.
	name = "Kinaris - Shuttle (Hyper)"
	icon_state = "knshuttle"
	icon = 'hyperstation/icons/mob/char_tails.dmi'
	recommended_species = list("synthliz")

/datum/sprite_accessory/mam_tails_animated/knshuttle
	name = "Kinaris - Shuttle (Hyper)"
	icon_state = "knshuttle"
	icon = 'hyperstation/icons/mob/char_tails.dmi'
	recommended_species = list("synthliz")

/datum/sprite_accessory/mam_tails/chemlight
	name = "RadDog (Hyper)"
	icon_state = "chemlight"
	icon = 'hyperstation/icons/mob/char_tails.dmi'

/datum/sprite_accessory/mam_tails_animated/chemlight
	name = "RadDog (Hyper)"
	icon_state = "chemlight"
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

/datum/sprite_accessory/mam_body_markings/bee // sarcoph @ hyperstation, march 2022
	name = "Bee (Hyper)"
	icon_state = "bee"
	icon = 'hyperstation/icons/mob/char_markings.dmi'
	recommended_species = list("insect")

/datum/sprite_accessory/mam_body_markings/bee_fluff // sarcoph @ hyperstation, march 2022
	name = "Bee - Fluffy (Hyper)"
	icon_state = "bee_fluff"
	icon = 'hyperstation/icons/mob/char_markings.dmi'
	recommended_species = list("insect")

/datum/sprite_accessory/mam_body_markings/bug3tone // sarcoph @ hyperstation, march 2022
	name = "Beetle - 3-tone (Hyper)"
	icon_state = "bug3tone"
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

/datum/sprite_accessory/mam_body_markings/easterndragon
	name = "Eastern Dragon (Hyper)"
	icon_state = "easternd"
	icon = 'hyperstation/icons/mob/char_markings.dmi'

/datum/sprite_accessory/mam_body_markings/knshuttle // Dahlular and Arcstaisia @ hyperstation, april 2022. Feel free to remove comment. Just remember this is snowflakey Kinaris stuff.
	name = "Kinaris - Shuttle (Hyper)"
	icon_state = "knshuttle"
	icon = 'hyperstation/icons/mob/char_markings.dmi'

//doged was here
/datum/sprite_accessory/mam_body_markings/chemlight
	name = "RadDog (Hyper)"
	icon_state = "chemlight"
	icon = 'hyperstation/icons/mob/char_markings.dmi'

//racc do a code maybe it won't explode
/datum/sprite_accessory/mam_body_markings/raccalt
	name = "RaccAlt (Hyper)"
	icon_state = "raccalt"
	icon = 'hyperstation/icons/mob/char_markings.dmi'

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
/datum/sprite_accessory/taur/chemnaga //Chemlight experimental sprites for future spriting
	name = "RadDog Naga (Hyper)"
	icon_state = "chemnaga"
	taur_mode = SNEK_TAURIC
	ckeys_allowed = list("chemlight")

/datum/sprite_accessory/taur/chemlight
	name = "RadDog Taur (Hyper)"
	icon_state = "chemlight"
	taur_mode = PAW_TAURIC
	ckeys_allowed = list("chemlight")


/*
IPCS
==========================================================
*/

/*
from modular_citadel/code/modules/mob/dead/new_player/sprite_accessories.dm:

/datum/sprite_accessory/antenna
	icon = 'modular_citadel/icons/mob/ipc_antennas.dmi'
	color_src = MUTCOLORS3
	recommended_species = list("ipc")

/datum/sprite_accessory/screen
	icon = 'modular_citadel/icons/mob/ipc_screens.dmi'
	color_src = null
*/

/datum/sprite_accessory/antenna/idog_down
	name = "Dog, down (Hyper)"
	icon_state = "idog_down"
	color_src = MATRIXED

/datum/sprite_accessory/antenna/idog_up
	name = "Dog, up (Hyper)"
	icon_state = "idog_up"
	color_src = MATRIXED

/datum/sprite_accessory/antenna/headset
	name = "Headphones (Hyper)"
	icon_state = "headset"
	color_src = MATRIXED

/datum/sprite_accessory/antenna/aquatic
	name = "Fins (Hyper)"
	icon_state = "aquatic"
	color_src = MATRIXED

/datum/sprite_accessory/screen/ghost
	name = "Ghost (Hyper)"
	icon_state = "ghost"

/datum/sprite_accessory/screen/heartbeat
	name = "Heartbeat (Hyper)"
	icon_state = "heartbeat"

/datum/sprite_accessory/screen/ocean
	name = "Ocean (Hyper)"
	icon_state = "ocean"

/datum/sprite_accessory/antenna/catears
	name = "Pointy Ears (Hyper)"
	icon_state = "catears"
	color_src = MATRIXED

/datum/sprite_accessory/screen/valley
	name = "Valley (Hyper)"
	icon_state = "valley"

/datum/sprite_accessory/screen/visor
	name = "Black Visor (Hyper)"
	icon = 'hyperstation/icons/mob/ipc_screen_visor.dmi'
	icon_state = "visor_black"

/datum/sprite_accessory/screen/visor/blue
	name = "Blue Visor (Hyper)"
	icon_state = "visor_blue"

/datum/sprite_accessory/screen/visor/green
	name = "Green Visor (Hyper)"
	icon_state = "visor_green"

/datum/sprite_accessory/screen/visor/red
	name = "Red Visor (Hyper)"
	icon_state = "visor_red"

/datum/sprite_accessory/screen/visor/white
	name = "White Visor (Hyper)"
	icon_state = "visor_white"

/datum/sprite_accessory/screen/visor/yellow
	name = "Yellow Visor (Hyper)"
	icon_state = "visor_yellow"


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

/datum/sprite_accessory/hair/hsglamour
	name = "Glamour (Hyper)"
	icon_state = "hair_glamourh"

/datum/sprite_accessory/hair/emoh
	name = "Emo (Hyper)"
	icon_state = "hair_emoh"

/*
BEARDS
==========================================================
*/

/*
/datum/sprite_accessory/facial_hair
	icon = 'icons/mob/human_face.dmi'
	gender = MALE // barf (unless you're a dorf, dorfs dig chix w/ beards :P)
*/

/datum/sprite_accessory/facial_hair/mane
	name = "Neckfluff (Hyper)"
	icon_state = "facial_neckfluff"