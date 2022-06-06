/mob/dead/new_player/Login()
	if(!client)
		return
	if(CONFIG_GET(flag/use_exp_tracking))
		client.set_exp_from_db()
		client.set_db_player_flags()
	if(!mind)
		mind = new /datum/mind(key)
		mind.active = 1
		mind.current = src

	. = ..()
	if(!. || !client)
		return FALSE

	var/motd = global.config.motd
	if(motd)
		to_chat(src, "<div class=\"motd\">[motd]</div>", handle_whitespace=FALSE)

	if(GLOB.admin_notice)
		to_chat(src, "<span class='notice'><b>Admin Notice:</b>\n \t [GLOB.admin_notice]</span>")

	var/spc = CONFIG_GET(number/soft_popcap)
	if(spc && living_player_count() >= spc)
		to_chat(src, "<span class='notice'><b>Server Notice:</b>\n \t [CONFIG_GET(string/soft_popcap_message)]</span>")

	sight |= SEE_TURFS

	new_player_panel()
	client.playtitlemusic()
	if(SSticker.current_state < GAME_STATE_SETTING_UP)
		var/tl = SSticker.GetTimeLeft()
		var/postfix
		if(tl > 0)
			postfix = "in about [DisplayTimeText(tl)]"
		else
			postfix = "soon"
		to_chat(src, "Please set up your character and select \"Ready\". The game will start [postfix].")

	if(client.prefs.path)	//Hyper edit: notify of a newer preference version
		var/savefile/S = new /savefile(client.prefs.path)
		if(S)
			S.cd = "/"
			var/slot
			S["default_slot"] >> slot
			var/differing_version_notification = 0
			if(slot)
				S.cd = "/character[slot]"
				var/slot_version = S["version"]
				if(slot_version < SAVEFILE_VERSION_MAX)
					S.cd = "/"
					S["new_differences_notification"] >> differing_version_notification
					if(!differing_version_notification || differing_version_notification <= slot_version)
						S["new_differences_notification"] << slot_version
						to_chat(src, "<span class='danger'><B>There were recent changes with characters, and your savefiles are outdated.</B></span>")
