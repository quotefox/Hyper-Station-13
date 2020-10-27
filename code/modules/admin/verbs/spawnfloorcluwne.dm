/client/proc/spawn_floor_cluwne()
	set category = "Fun"
	set name = "Unleash Targeted Floor Cluwne"
	set desc = "Pick a specific target. Be warned: spawning more than one may cause issues!"
	var/target

	if(!check_rights(R_FUN))
		return

	target = input("Any specific target in mind? Please note only live, non cluwned, human targets are valid.", "Target", target) as null|anything in GLOB.player_list
	if(target && ishuman(target))
		var/mob/living/carbon/human/H = target
		var/mob/living/simple_animal/hostile/floor_cluwne/FC = new /mob/living/simple_animal/hostile/floor_cluwne(H.loc)
		FC.forced = TRUE
		FC.Acquire_Victim(H)
		log_admin("[key_name(usr)] spawned floor cluwne.")
		message_admins("[key_name(usr)] spawned floor cluwne.")
		deadchat_broadcast("<span class='deadsay'><b>Floor Cluwne</b> has just been spawned!</span>")

/client/proc/spawn_random_floor_cluwne()
	set category = "Fun"
	set name = "Unleash Random Floor Cluwne"
	set desc = "Goes after a random player in your Z level. Be warned: spawning more than one may cause issues!"

	if(!check_rights(R_FUN))
		return
	
	var/turf/T = get_turf(usr)
	new /mob/living/simple_animal/hostile/floor_cluwne(T)
	log_admin("[key_name(usr)] spawned a random target floor cluwne.")
	message_admins("[key_name(usr)] spawned a random target floor cluwne.")
