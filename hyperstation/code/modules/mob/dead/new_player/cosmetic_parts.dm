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
	var/name
	var/icon = 'hyperstation/icons/mob/char_parts.dmi'
	var/icon_state
	var/support_digitigrade = TRUE

/datum/cosmetic_part/head
/datum/cosmetic_part/chest
/datum/cosmetic_part/arms
/datum/cosmetic_part/legs

/datum/cosmetic_part/legs/avian
	name = "avian"
	icon = 'modular_citadel/icons/mob/mutant_bodyparts.dmi'
	icon_state = "avian"