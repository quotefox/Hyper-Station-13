//not the most effient bot in the world, but it does its job.

/client/proc/discordmessage(input as message)
	set category = "Special Verbs"
	set name = "Hyperbot Message"
	set desc = "Makes the local bot say something in general chat on discord."

	if(input)
		world.hypermessage(input)
		message_admins("[key_name_admin(usr)] has made the Hyperbot post '[input]' in General.")

/world/proc/hypermessage(message)
	fdel("Hyperbot/message.txt") //cleaning up old message
	if(message)
		var botmsg = "![message]"
		text2file(botmsg,"Hyperbot/message.txt") //the bot on local reads a new text file and sends it to the discord.