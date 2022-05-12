/datum/preferences/proc/hyper_character_pref_load(savefile/S)
	S["feature_cosmetic_head"] >> features["cosmetic_head"]
	S["feature_cosmetic_chest"] >> features["cosmetic_chest"]
	S["feature_cosmetic_l_arm"] >> features["cosmetic_l_arm"]
	S["feature_cosmetic_r_arm"] >> features["cosmetic_r_arm"]
	S["feature_cosmetic_l_leg"] >> features["cosmetic_l_leg"]
	S["feature_cosmetic_r_leg"] >> features["cosmetic_r_leg"]
	features["cosmetic_head"] = sanitize_inlist(features["cosmetic_head"], GLOB.cosmetic_head, "default")
	features["cosmetic_chest"] = sanitize_inlist(features["cosmetic_chest"], GLOB.cosmetic_chest, "default")
	features["cosmetic_l_arm"] = sanitize_inlist(features["cosmetic_l_arm"], GLOB.cosmetic_arms, "default")
	features["cosmetic_r_arm"] = sanitize_inlist(features["cosmetic_r_arm"], GLOB.cosmetic_arms, "default")
	features["cosmetic_l_leg"] = sanitize_inlist(features["cosmetic_l_leg"], GLOB.cosmetic_legs, "default")
	features["cosmetic_r_leg"] = sanitize_inlist(features["cosmetic_r_leg"], GLOB.cosmetic_legs, "default")


/datum/preferences/proc/hyper_character_pref_save(savefile/S)
	WRITE_FILE(S["feature_cosmetic_head"], features["cosmetic_head"])
	WRITE_FILE(S["feature_cosmetic_chest"], features["cosmetic_chest"])
	WRITE_FILE(S["feature_cosmetic_l_arm"], features["cosmetic_l_arm"])
	WRITE_FILE(S["feature_cosmetic_r_arm"], features["cosmetic_r_arm"])
	WRITE_FILE(S["feature_cosmetic_l_leg"], features["cosmetic_l_leg"])
	WRITE_FILE(S["feature_cosmetic_r_leg"], features["cosmetic_r_leg"])