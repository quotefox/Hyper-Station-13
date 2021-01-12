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
		FC.target = H
		FC.current_victim = H
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

/client/proc/spawn_twitch_plays_clowncar()
	set category = "Fun"
	set name = "Spawn Twich Plays: Clown Car Edition"
	set desc = "A clown car that weights the direction it goes based on the keys ghosts are pushing. Terrible idea? Maybe."

	if(!check_rights(R_FUN))
		return
	
	var/turf/T = get_turf(usr)
	var/obj/vehicle/sealed/car/clowncar/twitch_plays/G = new /obj/vehicle/sealed/car/clowncar/twitch_plays(T)
	var/area/A = get_area(G)
	log_admin("[key_name(usr)] spawned a twitch plays clown car.")
	message_admins("[key_name(usr)] spawned a twitch plays clown car. Some soundtrack is likely recommended for the fuckshit that's about to unfold.")
	notify_ghosts("A Ghost Controlled Clown Car has been spawned at \the [A.name]! Double click it to orbit and wrestle its direction with other ghosts!", 'yogstation/sound/misc/bikehorn_creepy.ogg', source = G, action = NOTIFY_JUMP, flashwindow = FALSE)

