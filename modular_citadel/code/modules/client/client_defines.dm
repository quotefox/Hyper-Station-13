/client
	var/cryo_warned = -3000//when was the last time we warned them about not cryoing without an ahelp, set to -5 minutes so that rounstart cryo still warns

	//respawn
	var/lastrespawn = 0 //when the last time they respawned.
	var/list/pastcharacters = list() //to stop players spawning back in with the same character.
	var/respawn_observing = 0
