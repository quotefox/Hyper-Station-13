/*
COSMETIC PARTS

this system allows you to change the _base_ appearance of a limb independent
of species or markings. this, for example, allows us to create "hybrids" like a
mammal with avian legs.

keep in mind that this does not change the species of a leg! in the above example,
the mammal's bird-legs are still mammal legs. this matters in some places, like
body part transplants; mis-matched species will cause extra damage if the surgery
fails and the part is rejected. so you can't attach mammal-bird legs to avians
safely.
*/

/datum/cosmetic_part
	/** The name of the cosmetic part. This shows up in the preferences dropdown. */
	var/name
	var/icon = 'hyperstation/icons/mob/char_parts.dmi'
	var/icon_state
	/** How colors are determined for this part. MUTCOLORS for base color, MATRIXED to allow multiple channels. */
	var/color_src = MUTCOLORS
	/** Whether or not this cosmetic part has an alternate form for digitigrade legs. */
	var/support_digitigrade = TRUE
	/** Species IDs that support this cosmetic part. Bypassed with "show mismatched markings" option. */
	var/list/supported_species

/datum/cosmetic_part/head
/datum/cosmetic_part/chest
/datum/cosmetic_part/arms
/datum/cosmetic_part/legs

// HEADS
// =========================================

/datum/cosmetic_part/head/default
	name = "default"
	icon = null


// CHESTS
// =========================================

/datum/cosmetic_part/chest/default
	name = "default"
	icon = null

/datum/cosmetic_part/chest/ipc_sleek
	name = "sleek ipc chest"
	icon_state = "ipc_sleek"
	supported_species = list("ipc")
	color_src = MATRIXED


// ARMS
// =========================================

/datum/cosmetic_part/arms/default
	name = "default"
	icon = null

/datum/cosmetic_part/arms/avian_alt
	name = "avian claws"
	icon_state = "avian_alt"
	supported_species = list("mammal", "avian", "aquatic", "insect", "xeno", "synthliz")

/datum/cosmetic_part/arms/insect
	name = "insect arms"
	icon = 'modular_citadel/icons/mob/mutant_bodyparts.dmi'
	icon_state = "insect"
	supported_species = list("mammal", "avian", "aquatic", "insect", "xeno", "synthliz")

/datum/cosmetic_part/arms/ipc_sleek
	name = "sleek ipc arms"
	icon_state = "ipc_sleek"
	supported_species = list("ipc")
	color_src = MATRIXED


// LEGS
// =========================================

/datum/cosmetic_part/legs/default
	name = "default"
	icon = null

/datum/cosmetic_part/legs/avian
	name = "avian legs"
	icon = 'modular_citadel/icons/mob/mutant_bodyparts.dmi'
	icon_state = "avian"
	supported_species = list("mammal", "avian", "aquatic", "insect", "xeno", "synthliz")
	support_digitigrade = FALSE

/datum/cosmetic_part/legs/mammal
	name = "mammal legs"
	icon = 'modular_citadel/icons/mob/mutant_bodyparts.dmi'
	icon_state = "mammal"
	supported_species = list("mammal", "avian", "aquatic", "insect", "xeno", "synthliz")
	support_digitigrade = TRUE

/datum/cosmetic_part/legs/insect
	name = "insect legs"
	icon = 'modular_citadel/icons/mob/mutant_bodyparts.dmi'
	icon_state = "insect"
	supported_species = list("mammal", "avian", "aquatic", "insect", "xeno", "synthliz")
	support_digitigrade = TRUE

/datum/cosmetic_part/legs/ipc_sleek
	name = "sleek ipc legs"
	icon_state = "ipc_sleek"
	supported_species = list("ipc")
	color_src = MATRIXED
	support_digitigrade = FALSE