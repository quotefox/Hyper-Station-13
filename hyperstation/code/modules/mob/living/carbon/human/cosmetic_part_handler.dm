/obj/item/bodypart/proc/apply_cosmetic(datum/cosmetic_part/part)
	if(!is_organic_limb() || animal_origin || !part)
		return
	cosmetic_icon = part


/mob/living/carbon/human/proc/handle_cosmetic_parts()
	var/features = dna.features
	var/list/body_zones = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	for(var/zone in body_zones)
		var/datum/cosmetic_part/cosmetic_pref = features["cosmetic_" + zone]
		if(!istype(cosmetic_pref, /datum/cosmetic_part))
			continue
		var/datum/cosmetic_part/part = cosmetic_pref
		var/obj/item/bodypart/body_part = get_bodypart(zone)
		if(body_part && part)
			body_part.apply_cosmetic(part)
