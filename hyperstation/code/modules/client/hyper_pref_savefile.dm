/datum/preferences/proc/hyper_character_pref_load(savefile/S)
	S["feature_cosmetic_head"] >> features["cosmetic_head"]
	S["feature_cosmetic_chest"] >> features["cosmetic_chest"]
	S["feature_cosmetic_l_arm"] >> features["cosmetic_l_arm"]
	S["feature_cosmetic_r_arm"] >> features["cosmetic_r_arm"]
	S["feature_cosmetic_l_leg"] >> features["cosmetic_l_leg"]
	S["feature_cosmetic_r_leg"] >> features["cosmetic_r_leg"]
	var/cosmetic_head = sanitize_inlist(features["cosmetic_head"], GLOB.cosmetic_heads, "default")
	var/cosmetic_chest = sanitize_inlist(features["cosmetic_chest"], GLOB.cosmetic_chests, "default")
	var/cosmetic_l_arm = sanitize_inlist(features["cosmetic_l_arm"], GLOB.cosmetic_arms, "default")
	var/cosmetic_r_arm = sanitize_inlist(features["cosmetic_r_arm"], GLOB.cosmetic_arms, "default")
	var/cosmetic_l_leg = sanitize_inlist(features["cosmetic_l_leg"], GLOB.cosmetic_legs, "default")
	var/cosmetic_r_leg = sanitize_inlist(features["cosmetic_r_leg"], GLOB.cosmetic_legs, "default")
	features["cosmetic_head"] = GLOB.cosmetic_heads[cosmetic_head]
	features["cosmetic_chest"] = GLOB.cosmetic_chests[cosmetic_chest]
	features["cosmetic_l_arm"] = GLOB.cosmetic_arms[cosmetic_l_arm]
	features["cosmetic_r_arm"] = GLOB.cosmetic_arms[cosmetic_r_arm]
	features["cosmetic_l_leg"] = GLOB.cosmetic_legs[cosmetic_l_leg]
	features["cosmetic_r_leg"] = GLOB.cosmetic_legs[cosmetic_r_leg]


/datum/preferences/proc/hyper_character_pref_save(savefile/S)
	var/datum/cosmetic_part/head = features["cosmetic_head"]
	var/datum/cosmetic_part/chest = features["cosmetic_chest"]
	var/datum/cosmetic_part/l_arm = features["cosmetic_l_arm"]
	var/datum/cosmetic_part/r_arm = features["cosmetic_r_arm"]
	var/datum/cosmetic_part/l_leg = features["cosmetic_l_leg"]
	var/datum/cosmetic_part/r_leg = features["cosmetic_r_leg"]
	WRITE_FILE(S["feature_cosmetic_head"], head.name)
	WRITE_FILE(S["feature_cosmetic_chest"], chest.name)
	WRITE_FILE(S["feature_cosmetic_l_arm"], l_arm.name)
	WRITE_FILE(S["feature_cosmetic_r_arm"], r_arm.name)
	WRITE_FILE(S["feature_cosmetic_l_leg"], l_leg.name)
	WRITE_FILE(S["feature_cosmetic_r_leg"], r_leg.name)