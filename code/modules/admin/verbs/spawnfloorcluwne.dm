/client/proc/spawn_floor_cluwne()
	set category = "Fun"
	set name = "Unleash Floor Cluwne"
	set desc = "Pick a specific target. Be warned: spawning more than one may cause issues!"
	var/target

	if(!check_rights(R_FUN))
		return

	target = input("Any specific target in mind? Please note only live, non cluwned, human targets are valid.", "Target", target) as null|anything in GLOB.player_list
	if(target && ishuman(target))
		var/turf/T = get_turf(target)
		var/mob/living/carbon/human/H = target
		var/mob/living/simple_animal/hostile/floor_cluwne/FC = new /mob/living/simple_animal/hostile/floor_cluwne(T)
		FC.Acquire_Victim(H)
		FC.current_victim = H
		log_admin("[key_name(usr)] spawned floor cluwne.")
		message_admins("[key_name(usr)] spawned floor cluwne.")
		deadchat_broadcast("<span class='deadsay'><b>Floor Cluwne</b> has just been spawned!</span>")
