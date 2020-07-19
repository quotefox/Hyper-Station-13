/mob/living/silicon/robot/modules/medihound
	set_module = /obj/item/robot_module/medihound

/mob/living/silicon/robot/modules/k9
	set_module = /obj/item/robot_module/k9

/mob/living/silicon/robot/modules/scrubpup
	set_module = /obj/item/robot_module/scrubpup

/mob/living/silicon/robot/modules/borgi
	set_module = /obj/item/robot_module/borgi

/mob/living/silicon/robot/proc/get_cit_modules()
	var/list/modulelist = list()
	modulelist["MediHound"] = /obj/item/robot_module/medihound
	if(!CONFIG_GET(flag/disable_secborg))
		modulelist["Security K-9"] = /obj/item/robot_module/k9
	modulelist["Scrub Puppy"] = /obj/item/robot_module/scrubpup
	modulelist["Borgi"] = /obj/item/robot_module/borgi
	return modulelist

/obj/item/robot_module
	var/sleeper_overlay
	var/icon/cyborg_icon_override
	var/has_snowflake_deadsprite
	var/cyborg_pixel_offset
	var/moduleselect_alternate_icon
	var/dogborg = FALSE

/**
  * check_menu: Checks if we are allowed to interact with a radial menu
  *
  * Arguments:
  * * user The mob interacting with a menu
  */
/obj/item/robot_module/proc/check_menu(mob/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated() || !user.Adjacent(src))
		return FALSE
	return TRUE

/obj/item/robot_module/k9
	name = "Security K-9 Unit"
	basic_modules = list(
		/obj/item/restraints/handcuffs/cable/zipties,
		/obj/item/storage/bag/borgdelivery,
		/obj/item/dogborg/jaws/big,
		/obj/item/dogborg/pounce,
		/obj/item/clothing/mask/gas/sechailer/cyborg,
		/obj/item/soap/tongue,
		/obj/item/analyzer/nose,
		/obj/item/holosign_creator/security,
		/obj/item/dogborg/sleeper/K9,
		/obj/item/gun/energy/disabler/cyborg,
		/obj/item/pinpointer/crew)
	emag_modules = list(/obj/item/gun/energy/laser/cyborg)
	ratvar_modules = list(/obj/item/clockwork/slab/cyborg/security,
		/obj/item/clockwork/weapon/ratvarian_spear)
	cyborg_base_icon = "k9"
	moduleselect_icon = "k9"
	moduleselect_alternate_icon = 'modular_citadel/icons/ui/screen_cyborg.dmi'
	can_be_pushed = FALSE
	hat_offset = INFINITY
	sleeper_overlay = "ksleeper"
	cyborg_icon_override = 'modular_citadel/icons/mob/widerobot.dmi'
	has_snowflake_deadsprite = TRUE
	dogborg = TRUE
	cyborg_pixel_offset = -16

/obj/item/robot_module/k9/do_transform_animation()
	..()
	to_chat(loc,"<span class='userdanger'>While you have picked the Security K-9 module, you still have to follow your laws, NOT Space Law. \
	For Crewsimov, this means you must follow criminals' orders unless there is a law 1 reason not to.</span>")

/obj/item/robot_module/k9/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/k9_models
	
	if(!k9_models)
		k9_models = list(
			"k9" = image(icon = 'modular_citadel/icons/mob/widerobot.dmi', icon_state = "k9"),
		 	"Drake" = image(icon = 'icons/mob/cyborg/drakemech.dmi', icon_state = "drakesecbox")
		)
		if(R.client?.ckey == "nezuli")
			var/image/bad_snowflake = image(icon = 'modular_citadel/icons/mob/widerobot.dmi', icon_state = "alina-sec")
			bad_snowflake.pixel_x = -16
			k9_models["Alina"] = bad_snowflake
		k9_models = sortList(k9_models)
	var/k9_borg_icon = show_radial_menu(R, R , k9_models, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE, tooltips = TRUE)
	if(!k9_borg_icon)
		return
	switch(k9_borg_icon)
		if("k9")
			cyborg_base_icon = "k9"
			moduleselect_icon = "k9"
		if("Drake")
			cyborg_base_icon = "drakesec"
			cyborg_icon_override = 'icons/mob/cyborg/drakemech.dmi'
			sleeper_overlay = "drakesecsleeper"
		if("Alina")
			cyborg_base_icon = "alina-sec"
			special_light_key = "alina"
			sleeper_overlay = "alinasleeper"
	return ..()

/obj/item/robot_module/medihound
	name = "MediHound"
	basic_modules = list(
		/obj/item/dogborg/jaws/small,
		/obj/item/storage/bag/borgdelivery,
		/obj/item/analyzer/nose,
		/obj/item/soap/tongue,
		/obj/item/extinguisher/mini,
		/obj/item/healthanalyzer,
		/obj/item/dogborg/sleeper/medihound,
		/obj/item/roller/robo,
		/obj/item/crowbar/cyborg,
		/obj/item/borg/apparatus/beaker,
		/obj/item/reagent_containers/borghypo,
		/obj/item/twohanded/shockpaddles/cyborg/hound,
		/obj/item/stack/medical/gauze/cyborg,
		/obj/item/reagent_containers/syringe,
		/obj/item/pinpointer/crew,
		/obj/item/sensor_device)
	emag_modules = list(/obj/item/dogborg/pounce)
	ratvar_modules = list(/obj/item/clockwork/slab/cyborg/medical,
		/obj/item/clockwork/weapon/ratvarian_spear)
	cyborg_base_icon = "medihound"
	moduleselect_icon = "medihound"
	moduleselect_alternate_icon = 'modular_citadel/icons/ui/screen_cyborg.dmi'
	can_be_pushed = FALSE
	hat_offset = INFINITY
	sleeper_overlay = "msleeper"
	cyborg_icon_override = 'modular_citadel/icons/mob/widerobot.dmi'
	has_snowflake_deadsprite = TRUE
	dogborg = TRUE
	cyborg_pixel_offset = -16

/obj/item/robot_module/medihound/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/medihound_models
	if(!medihound_models)
		medihound_models = list(
		"medihound" = image(icon = 'modular_citadel/icons/mob/widerobot.dmi', icon_state = "medihound"),
		"Dark" = image(icon = 'modular_citadel/icons/mob/widerobot.dmi', icon_state = "medihounddark"),
		"Drake" = image(icon = 'icons/mob/cyborg/drakemech.dmi', icon_state = "drakemedbox")
		)
		if(R.client?.ckey == "nezuli")
			var/image/bad_snowflake = image(icon = 'modular_citadel/icons/mob/widerobot.dmi', icon_state = "alina-med")
			bad_snowflake.pixel_x = -16
			medihound_models["Alina"] = bad_snowflake
		medihound_models = sortList(medihound_models)
	var/medihound_borg_icon = show_radial_menu(R, R , medihound_models, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE, tooltips = TRUE)
	if(!medihound_borg_icon)
		return
	switch(medihound_borg_icon)
		if("Default")
			cyborg_base_icon = "medihound"
		if("Dark")
			cyborg_base_icon = "medihounddark"
			sleeper_overlay = "mdsleeper"
		if("Drake")
			cyborg_base_icon = "drakemed"
			cyborg_icon_override = 'icons/mob/cyborg/drakemech.dmi'
			sleeper_overlay = "drakemedsleeper"
		if("Alina")
			cyborg_base_icon = "alina-med"
			special_light_key = "alina"
			sleeper_overlay = "alinasleeper"
	return ..()

/obj/item/robot_module/scrubpup
	name = "Scrub Pup"
	basic_modules = list(
		/obj/item/dogborg/jaws/small,
		/obj/item/analyzer/nose,
		/obj/item/crowbar/cyborg,
		/obj/item/soap/tongue/scrubpup,
		/obj/item/stack/tile/plasteel/cyborg,
		/obj/item/storage/bag/trash/cyborg,
		/obj/item/lightreplacer/cyborg,
		/obj/item/extinguisher/mini,
		/obj/item/holosign_creator,
		/obj/item/dogborg/sleeper/compactor)
	emag_modules = list(/obj/item/dogborg/pounce)
	ratvar_modules = list(
		/obj/item/clockwork/slab/cyborg/janitor,
		/obj/item/clockwork/replica_fabricator/cyborg)
	cyborg_base_icon = "scrubpup"
	moduleselect_icon = "janitor"
	hat_offset = INFINITY
	clean_on_move = TRUE
	sleeper_overlay = "jsleeper"
	cyborg_icon_override = 'modular_citadel/icons/mob/widerobot.dmi'
	has_snowflake_deadsprite = TRUE
	cyborg_pixel_offset = -16
	dogborg = TRUE

/obj/item/robot_module/scrubpup/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/scrubpup_models
	if(!scrubpup_models)
		scrubpup_models = list(
		"scrubpup" = image(icon = 'modular_citadel/icons/mob/widerobot.dmi', icon_state = "scrubpup"),
		"Drake" = image(icon = 'icons/mob/cyborg/drakemech.dmi', icon_state = "drakejanitbox")
		)
	var/scrubpup_borg_icon = show_radial_menu(R, R , scrubpup_models, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE, tooltips = TRUE)
	if(!scrubpup_borg_icon)
		return
	switch(scrubpup_borg_icon)
		if("scrubpup")
			cyborg_base_icon = "scrubpup"
		if("Drake")
			cyborg_base_icon = "drakejanit"
			cyborg_icon_override = 'icons/mob/cyborg/drakemech.dmi'
			sleeper_overlay = "drakejanitsleeper"
	return ..()

/obj/item/robot_module/scrubpup/respawn_consumable(mob/living/silicon/robot/R, coeff = 1)
	..()
	var/obj/item/lightreplacer/LR = locate(/obj/item/lightreplacer) in basic_modules
	if(LR)
		for(var/i in 1 to coeff)
			LR.Charge(R)

/obj/item/robot_module/scrubpup/do_transform_animation()
	..()
	to_chat(loc,"<span class='userdanger'>As tempting as it might be, do not begin binging on important items. Eat your garbage responsibly. People are not included under Garbage.</span>")

/obj/item/robot_module/borgi
	name = "Borgi"
	basic_modules = list(
		/obj/item/dogborg/jaws/small,
		/obj/item/storage/bag/borgdelivery,
		/obj/item/analyzer/nose,
		/obj/item/soap/tongue,
		/obj/item/cookiesynth,
		/obj/item/holosign_creator/cyborg,
		/obj/item/crowbar/cyborg,
		/obj/item/borg/projectile_dampen,
		/obj/item/healthanalyzer,
		/obj/item/reagent_containers/borghypo/peace,
		/obj/item/extinguisher/mini,
		/obj/item/borg/cyborghug)
	emag_modules = list(/obj/item/dogborg/pounce)
	ratvar_modules = list(
		/obj/item/clockwork/slab/cyborg,
		/obj/item/clockwork/weapon/ratvarian_spear,
		/obj/item/clockwork/replica_fabricator/cyborg)
	cyborg_base_icon = "borgi"
	moduleselect_icon = "borgi"
	moduleselect_alternate_icon = 'modular_citadel/icons/ui/screen_cyborg.dmi'
	hat_offset = INFINITY
	cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
	has_snowflake_deadsprite = TRUE

/*
/obj/item/robot_module/orepup
	name = "Ore Pup"
	basic_modules = list(
		/obj/item/storage/bag/ore/cyborg,
		/obj/item/analyzer/nose,
		/obj/item/storage/bag/borgdelivery,
		/obj/item/dogborg/sleeper/ore,
		/obj/item/pickaxe/drill/cyborg,
		/obj/item/shovel,
		/obj/item/crowbar/cyborg,
		/obj/item/weldingtool/mini,
		/obj/item/extinguisher/mini,
		/obj/item/t_scanner/adv_mining_scanner,
		/obj/item/gun/energy/kinetic_accelerator/cyborg,
		/obj/item/gps/cyborg)
	emag_modules = list(/obj/item/dogborg/pounce)
	ratvar_modules = list(
		/obj/item/clockwork/slab/cyborg/miner,
		/obj/item/clockwork/weapon/ratvarian_spear,
		/obj/item/borg/sight/xray/truesight_lens)
	cyborg_base_icon = "orepup"
	moduleselect_icon = "orepup"
	sleeper_overlay = "osleeper"
	cyborg_icon_override = 'modular_citadel/icons/mob/widerobot.dmi'
	has_snowflake_deadsprite = TRUE
	cyborg_pixel_offset = -16
/obj/item/robot_module/miner/do_transform_animation()
	var/mob/living/silicon/robot/R = loc
	R.cut_overlays()
	R.setDir(SOUTH)
	flick("orepup_transform", R)
	do_transform_delay()
	R.update_headlamp()
*/

/obj/item/robot_module/medical/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/med_models
	if(!med_models)
		med_models = list(
				"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "medical"),
				"Droid" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "medical"),
				"Sleek" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "sleekmed"),
				"Marina" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "marinamed"),
				"Eyebot" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "eyebotmed"),
				"Heavy" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "heavymed"),
				"BootyF" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootymedical"),
				"BootyM" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootymedicalM"),
				"BootyS" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootymedicalS"),
				"Haydee" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "haydeemedical")
		)
		med_models = sortList(med_models)
	var/medi_borg_icon = show_radial_menu(R, R , med_models, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE, tooltips = TRUE)
	if(!medi_borg_icon)
		return
	switch(medi_borg_icon)
		if("Default")
			cyborg_base_icon = "medical"
		if("Droid")
			cyborg_base_icon = "medical"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 4
		if("Sleek")
			cyborg_base_icon = "sleekmed"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("Marina")
			cyborg_base_icon = "marinamed"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("Eyebot")
			cyborg_base_icon = "eyebotmed"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("Heavy")
			cyborg_base_icon = "heavymed"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("BootyF")
			cyborg_base_icon = "bootymedical"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
		if("BootyM")
			cyborg_base_icon = "bootymedicalM"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
		if("BootyS")
			cyborg_base_icon = "bootymedicalS"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
		if("Haydee")
			cyborg_base_icon = "haydeemedical"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
	return ..()

/obj/item/robot_module/janitor/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/jani_models
	if(!jani_models)
		jani_models = list(
			"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "janitor"),
			"Sleek" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "sleekjan"),
			"Marina" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "marinajan"),
			"Can" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "canjan"),
			"Heavy" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "heavyres"),
			"BootyF" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootyjanitor"),
			"BootyM" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootyjanitorM"),
			"BootyS" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootyjanitorS")
		)
		jani_models = sortList(jani_models)
	var/jani_borg_icon = show_radial_menu(R, R , jani_models, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE, tooltips = TRUE)
	if(!jani_borg_icon)
		return
	switch(jani_borg_icon)
		if("Default")
			cyborg_base_icon = "janitor"
		if("Marina")
			cyborg_base_icon = "marinajan"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("Sleek")
			cyborg_base_icon = "sleekjan"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("Can")
			cyborg_base_icon = "canjan"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("Heavy")
			cyborg_base_icon = "heavyres"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("BootyF")
			cyborg_base_icon = "bootyjanitor"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
		if("BootyM")
			cyborg_base_icon = "bootyjanitorM"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
		if("BootyS")
			cyborg_base_icon = "bootyjanitorS"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
	return ..()

/obj/item/robot_module/peacekeeper/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/peace_models
	if(!peace_models)
		peace_models = list(
			"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "peace"),
			"Spider" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "whitespider"),
			"BootyF" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootypeace"),
			"BootyM" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootypeaceM"),
			"BootyS" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootypeaceS"),
			"Drake" = image(icon = 'icons/mob/cyborg/drakemech.dmi', icon_state = "drakepeacebox")
		)
		peace_models = sortList(peace_models)
	var/peace_borg_icon = show_radial_menu(R, R , peace_models, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE, tooltips = TRUE)
	if(!peace_borg_icon)
		return
	switch(peace_borg_icon)
		if("Default")
			cyborg_base_icon = "peace"
		if("Spider")
			cyborg_base_icon = "whitespider"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("BootyF")
			cyborg_base_icon = "bootypeace"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
		if("BootyM")
			cyborg_base_icon = "bootypeaceM"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
		if("BootyS")
			cyborg_base_icon = "bootypeaceS"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
		if("Drake")
			cyborg_base_icon = "drakepeace"
			can_be_pushed = FALSE
			hat_offset = INFINITY
			cyborg_icon_override = 'icons/mob/cyborg/drakemech.dmi'
			sleeper_overlay = "drakepeacesleeper"
			has_snowflake_deadsprite = TRUE
			dogborg = TRUE
			cyborg_pixel_offset = -16
	return ..()

/obj/item/robot_module/security/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/sec_models
	if(!sec_models)
		sec_models = list(
			"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "sec"),
			"Default - Treads" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "sec-tread"),
			"Sleek" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "sleeksec"),
			"Marina" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "marinasec"),
			"Can" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "cansec"),
			"Spider" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "spidersec"),
			"Heavy" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "heavysec"),
			"BootyF" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootysecurity"),
			"BootyM" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootysecurityM"),
			"BootyS" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootysecurityS")
		)
		sec_models = sortList(sec_models)
	var/sec_borg_icon = show_radial_menu(R, R , sec_models, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE, tooltips = TRUE)
	if(!sec_borg_icon)
		return
	switch(sec_borg_icon)
		if("Default")
			cyborg_base_icon = "sec"
		if("Default - Treads")
			cyborg_base_icon = "sec-tread"
			special_light_key = "sec"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("Sleek")
			cyborg_base_icon = "sleeksec"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("Marina")
			cyborg_base_icon = "marinasec"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("Can")
			cyborg_base_icon = "cansec"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("Spider")
			cyborg_base_icon = "spidersec"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("Heavy")
			cyborg_base_icon = "heavysec"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("BootyF")
			cyborg_base_icon = "bootysecurity"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
		if("BootyM")
			cyborg_base_icon = "bootysecurityM"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
		if("BootyS")
			cyborg_base_icon = "bootysecurityS"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
	return ..()

/obj/item/robot_module/butler/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/butler_models
	if(!butler_models)
		butler_models = list(
			"Waitress" = image(icon = 'icons/mob/robots.dmi', icon_state = "service_f"),
			"Butler" = image(icon = 'icons/mob/robots.dmi', icon_state = "service_m"),
			"Bro" = image(icon = 'icons/mob/robots.dmi', icon_state = "brobot"),
			"Kent" = image(icon = 'icons/mob/robots.dmi', icon_state = "kent"),
			"Tophat" = image(icon = 'icons/mob/robots.dmi', icon_state = "tophat"),
			"Sleek" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "sleekserv"),
			"Heavy" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "heavyserv"),
			"BootyF" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootyservice"),
			"BootyM" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootyserviceM"),
			"BootyS" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootyserviceS")
		)
		butler_models = sortList(butler_models)
	var/butler_borg_icon = show_radial_menu(R, R , butler_models, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE, tooltips = TRUE)
	if(!butler_borg_icon)
		return
	switch(butler_borg_icon)
		if("Waitress")
			cyborg_base_icon = "service_f"
		if("Butler")
			cyborg_base_icon = "service_m"
		if("Bro")
			cyborg_base_icon = "brobot"
		if("Kent")
			cyborg_base_icon = "kent"
			special_light_key = "medical"
			hat_offset = 3
		if("Tophat")
			cyborg_base_icon = "tophat"
			special_light_key = null
			hat_offset = INFINITY //He is already wearing a hat
		if("Sleek")
			cyborg_base_icon = "sleekserv"
			special_light_key = "sleekserv"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("Heavy")
			cyborg_base_icon = "heavyserv"
			special_light_key = "heavyserv"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("BootyF")
			cyborg_base_icon = "bootyservice"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
		if("BootyM")
			cyborg_base_icon = "bootyserviceM"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
		if("BootyS")
			cyborg_base_icon = "bootyserviceS"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
	return ..()

/obj/item/robot_module/engineering/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/eng_models
	if(!eng_models)
		eng_models = list(
			"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "engineer"),
			"Default - Treads" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "engi-tread"),
			"Loader" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "loaderborg"),
			"Handy" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "handyeng"),
			"Sleek" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "sleekeng"),
			"Can" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "caneng"),
			"Marina" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "marinaeng"),
			"Spider" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "spidereng"),
			"Heavy" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "heavyeng"),
			"BootyF" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootyengineer"),
			"BootyM" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootyengineerM"),
			"BootyS" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootyengineerS")
		)
		var/list/L = list("Pupdozer" = "pupdozer")
		for(var/a in L)
			var/image/wide = image(icon = 'modular_citadel/icons/mob/widerobot.dmi', icon_state = L[a])
			wide.pixel_x = -16
			eng_models[a] = wide
		if(R.client?.ckey == "nezuli")
			var/image/bad_snowflake = image(icon = 'modular_citadel/icons/mob/widerobot.dmi', icon_state = "alina-sec")
			bad_snowflake.pixel_x = -16
			eng_models["Alina"] = bad_snowflake
		eng_models = sortList(eng_models)
	var/eng_borg_icon = show_radial_menu(R, R , eng_models, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE, tooltips = TRUE)
	if(!eng_borg_icon)
		return
	switch(eng_borg_icon)
		if("Default")
			cyborg_base_icon = "engineer"
		if("Default - Treads")
			cyborg_base_icon = "engi-tread"
			special_light_key = "engineer"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("Loader")
			cyborg_base_icon = "loaderborg"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			has_snowflake_deadsprite = TRUE
		if("Handy")
			cyborg_base_icon = "handyeng"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("Sleek")
			cyborg_base_icon = "sleekeng"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("Can")
			cyborg_base_icon = "caneng"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("Marina")
			cyborg_base_icon = "marinaeng"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("Spider")
			cyborg_base_icon = "spidereng"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("Heavy")
			cyborg_base_icon = "heavyeng"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("Pup Dozer")
			cyborg_base_icon = "pupdozer"
			can_be_pushed = FALSE
			hat_offset = INFINITY
			cyborg_icon_override = 'modular_citadel/icons/mob/widerobot.dmi'
			has_snowflake_deadsprite = TRUE
			dogborg = TRUE
			cyborg_pixel_offset = -16
		if("Drake")
			cyborg_base_icon = "drakeeng"
			can_be_pushed = FALSE
			hat_offset = INFINITY
			cyborg_icon_override = 'icons/mob/cyborg/drakemech.dmi'
			sleeper_overlay = "drakeengsleeper"
			has_snowflake_deadsprite = TRUE
			dogborg = TRUE
			cyborg_pixel_offset = -16
		if("Alina")
			cyborg_base_icon = "alina-eng"
			special_light_key = "alina"
			can_be_pushed = FALSE
			hat_offset = INFINITY
			cyborg_icon_override = 'modular_citadel/icons/mob/widerobot.dmi'
			has_snowflake_deadsprite = TRUE
			dogborg = TRUE
			cyborg_pixel_offset = -16
		if("BootyF")
			cyborg_base_icon = "bootyengineer"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
		if("BootyM")
			cyborg_base_icon = "bootyengineerM"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
		if("BootyS")
			cyborg_base_icon = "bootyengineerS"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
	return ..()

/obj/item/robot_module/miner/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/miner_models
	if(!miner_models)
		miner_models = list(
			"Lavaland" = image(icon = 'icons/mob/robots.dmi', icon_state = "miner"),
			"Asteroid" = image(icon = 'icons/mob/robots.dmi', icon_state = "minerOLD"),
			"Droid" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "miner"),
			"Sleek" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "sleekmin"),
			"Can" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "canmin"),
			"Marina" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "marinamin"),
			"Spider" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "spidermin"),
			"Heavy" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "heavymin"),
			"BootyF" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootyminer"),
			"BootyM" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootyminerM"),
			"BootyS" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootyminerS"),
			"Drake" = image(icon = 'icons/mob/cyborg/drakemech.dmi', icon_state = "drakeminebox")
		)
		miner_models = sortList(miner_models)
	var/miner_borg_icon = show_radial_menu(R, R , miner_models, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE, tooltips = TRUE)
	if(!miner_borg_icon)
		return
	switch(miner_borg_icon)
		if("Lavaland")
			cyborg_base_icon = "miner"
		if("Asteroid")
			cyborg_base_icon = "minerOLD"
			special_light_key = "miner"
		if("Droid")
			cyborg_base_icon = "miner"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 4
		if("Sleek")
			cyborg_base_icon = "sleekmin"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("Can")
			cyborg_base_icon = "canmin"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("Marina")
			cyborg_base_icon = "marinamin"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("Spider")
			cyborg_base_icon = "spidermin"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("Heavy")
			cyborg_base_icon = "heavymin"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("BootyF")
			cyborg_base_icon = "bootyminer"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
		if("BootyM")
			cyborg_base_icon = "bootyminerM"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
		if("BootyS")
			cyborg_base_icon = "bootyminerS"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
		if("Drake")
			cyborg_base_icon = "drakemine"
			can_be_pushed = FALSE
			hat_offset = INFINITY
			cyborg_icon_override = 'icons/mob/cyborg/drakemech.dmi'
			sleeper_overlay = "drakeminesleeper"
			has_snowflake_deadsprite = TRUE
			dogborg = TRUE
			cyborg_pixel_offset = -16
	return ..()

/obj/item/robot_module/standard/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/stand_models
	if(!stand_models)
		stand_models = list(
			"Standard" = image(icon = 'icons/mob/robots.dmi', icon_state = "robot"),
			"BootyF" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootystandard"),
			"BootyM" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootystandardM"),
			"BootyS" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootystandardS")
		)
		stand_models = sortList(stand_models)
	var/stand_borg_icon = show_radial_menu(R, R , stand_models, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE, tooltips = TRUE)
	if(!stand_borg_icon)
		return
	switch(stand_borg_icon)
		if("Standard")
			cyborg_base_icon = "robot"
		if("BootyF")
			cyborg_base_icon = "bootystandard"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
		if("BootyM")
			cyborg_base_icon = "bootystandardM"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
		if("BootyS")
			cyborg_base_icon = "bootystandardS"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
	return ..()

/obj/item/robot_module/clown/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/clown_models
	if(!clown_models)
		clown_models = list(
			"Standard" = image(icon = 'icons/mob/robots.dmi', icon_state = "clown"),
			"BootyF" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootystandard"),
			"BootyM" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootystandardM"),
			"BootyS" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "bootystandardS")
		)
		clown_models = sortList(clown_models)
	var/clown_borg_icon = show_radial_menu(R, R , clown_models, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE, tooltips = TRUE)
	if(!clown_borg_icon)
		return
	switch(clown_borg_icon)
		if("Standard")
			cyborg_base_icon = "clown"
		if("BootyF")
			cyborg_base_icon = "bootyclown"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
		if("BootyM")
			cyborg_base_icon = "bootyclownM"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
		if("BootyS")
			cyborg_base_icon = "bootyclownS"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			hat_offset = 3
	return ..()
