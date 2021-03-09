
	//The mob should have a gender you want before running this proc. Will run fine without H
/datum/preferences/proc/random_character(gender_override)
	if(gender_override)
		gender = gender_override
	else
		gender = pick(MALE,FEMALE)
	underwear = random_underwear(gender)
	undie_color = random_short_color()
	undershirt = random_undershirt(gender)
	shirt_color = random_short_color()
	socks = random_socks()
	socks_color = random_short_color()
	skin_tone = random_skin_tone()
	hair_style = random_hair_style(gender)
	facial_hair_style = random_facial_hair_style(gender)
	hair_color = random_short_color()
	facial_hair_color = hair_color
	eye_color = random_eye_color()
	wing_color = "fff"
	if(!pref_species)
		var/rando_race = pick(GLOB.roundstart_races)
		pref_species = new rando_race()
	features = random_features(pref_species?.id)
	age = rand(AGE_MIN,AGE_MAX)

/datum/preferences/proc/update_preview_icon()
	// Silicons only need a very basic preview since there is no customization for them.
//	var/wide_icon = FALSE //CITDEL THINGS
//	if(features["taur"] != "None")
//		wide_icon = TRUE
	if(job_engsec_high)
		switch(job_engsec_high)
			if(AI_JF)
				parent.show_character_previews(image('icons/mob/ai.dmi', resolve_ai_icon(preferred_ai_core_display), dir = SOUTH))
				return
			if(CYBORG)
				parent.show_character_previews(image('icons/mob/robots.dmi', icon_state = "robot", dir = SOUTH))
				return

	// Set up the dummy for its photoshoot
	var/mob/living/carbon/human/dummy/mannequin = generate_or_wait_for_human_dummy(DUMMY_HUMAN_SLOT_PREFERENCES)
	mannequin.cut_overlays()

	mannequin.add_overlay(mutable_appearance('modular_citadel/icons/ui/backgrounds.dmi', bgstate, layer = SPACE_LAYER))
	copy_to(mannequin)
	mannequin.resize(body_size*0.01, 0)


	// Determine what job is marked as 'High' priority, and dress them up as such.
	var/datum/job/previewJob
	var/highRankFlag = job_civilian_high | job_medsci_high | job_engsec_high

	if(chosen_gear && current_tab != 2)
		for(var/A in chosen_gear)
			var/datum/gear/G = new A		//Shouldn't really be anything else, but byond fuckery
			if(!mannequin.get_item_by_slot(G.category))
				mannequin.equip_to_appropriate_slot(new G.path)

	if(job_civilian_low & ASSISTANT)
		previewJob = SSjob.GetJob("Assistant")
	else if(highRankFlag)
		var/highDeptFlag
		if(job_civilian_high)
			highDeptFlag = CIVILIAN
		else if(job_medsci_high)
			highDeptFlag = MEDSCI
		else if(job_engsec_high)
			highDeptFlag = ENGSEC

		for(var/datum/job/job in SSjob.occupations)
			if(job.flag == highRankFlag && job.department_flag == highDeptFlag)
				previewJob = job
				break

	if(previewJob)
		if(current_tab != 2)
			mannequin.job = previewJob.title
			previewJob.equip(mannequin, TRUE)

	COMPILE_OVERLAYS(mannequin)
	if(body_size>100)
		parent.show_character_previews_large(new /mutable_appearance(mannequin))//just to stop clipping of larger characters
	else
		parent.show_character_previews(new /mutable_appearance(mannequin))

	unset_busy_human_dummy(DUMMY_HUMAN_SLOT_PREFERENCES)
