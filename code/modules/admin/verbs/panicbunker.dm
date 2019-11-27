/client/proc/panicbunker()
	set category = "Server"
	set name = "Toggle Panic Bunker"
	if (!CONFIG_GET(flag/sql_enabled))
		to_chat(usr, "<span class='adminnotice'>The Database is not enabled!</span>")
		return

	var/new_pb = !CONFIG_GET(flag/panic_bunker)
	CONFIG_SET(flag/panic_bunker, new_pb)

	log_admin("[key_name(usr)] has toggled the Panic Bunker, it is now [new_pb ? "on" : "off"]")
	message_admins("[key_name_admin(usr)] has toggled the Panic Bunker, it is now [new_pb ? "enabled" : "disabled"].")
	if (new_pb && !SSdbcore.Connect())
		message_admins("The Database is not connected! Panic bunker will not work until the connection is reestablished.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Panic Bunker", "[new_pb ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	send2irc("Panic Bunker", "[key_name(usr)] has toggled the Panic Bunker, it is now [new_pb ? "enabled" : "disabled"].")


/client/proc/addbunkerbypass(ckeytobypass as text)
	set category = "Special Verbs"
	set name = "Whitelist"
	set desc = "Adds a given ckey onto the whitelist to bypass the panic bunker."
	if(!CONFIG_GET(flag/sql_enabled))
		to_chat(usr, "<span class='adminnotice'>The Database is not enabled!</span>")
		return

	GLOB.bunker_passthrough |= ckey(ckeytobypass)
	log_admin("[key_name(usr)] has added [ckeytobypass] to the whitelist.")
	message_admins("[key_name_admin(usr)] has added [ckeytobypass] to the whitelist.")
	send2irc("Panic Bunker", "[key_name(usr)] has added [ckeytobypass] to the whitelist.")


	//Hyperstation13 change Adds to a whitelist on the database table "whitelist", so players can join at a later date!
	var/sql_ckey = sanitizeSQL(ckeytobypass)
	var/datum/DBQuery/query_client_in_db = SSdbcore.NewQuery("SELECT 1 FROM [format_table_name("whitelist")] WHERE ckey = '[sql_ckey]'")
	if(!query_client_in_db.Execute())
		qdel(query_client_in_db)
		return
	if(!query_client_in_db.NextRow())
		//add to database!
		var/datum/DBQuery/query_add_player_whitelist = SSdbcore.NewQuery("INSERT INTO [format_table_name("whitelist")] (`ckey`) VALUES ('[sql_ckey]')")
		if(!query_add_player_whitelist.Execute())
			qdel(query_client_in_db)
			qdel(query_add_player_whitelist)
			return


/client/proc/revokebunkerbypass(ckeytobypass as text)
	set category = "Special Verbs"
	set name = "Revoke PB Bypass"
	set desc = "Revoke's a ckey's permission to bypass the panic bunker for a given round."
	if(!CONFIG_GET(flag/sql_enabled))
		to_chat(usr, "<span class='adminnotice'>The Database is not enabled!</span>")
		return

	GLOB.bunker_passthrough -= ckey(ckeytobypass)
	log_admin("[key_name(usr)] has removed [ckeytobypass] from the current round's bunker bypass list.")
	message_admins("[key_name_admin(usr)] has removed [ckeytobypass] from the current round's bunker bypass list.")
	send2irc("Panic Bunker", "[key_name(usr)] has removed [ckeytobypass] from the current round's bunker bypass list.")
