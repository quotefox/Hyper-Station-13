//HUGBOT
//HUGBOT PATHFINDING
//HUGBOT ASSEMBLY


/mob/living/simple_animal/bot/hugbot
	name = "\improper Hugbot"
	desc = "A little cudly robot. He looks excited."
	icon = 'hyperstation/icons/mobs/aibots.dmi'
	icon_state = "hugbot0"
	density = FALSE
	anchored = FALSE
	health = 20
	maxHealth = 20
	pass_flags = PASSMOB

	status_flags = (CANPUSH | CANSTUN)

	bot_type = HUG_BOT
	model = "Hugbot"
	bot_core_type = /obj/machinery/bot_core/hugbot
	window_id = "autohug"
	window_name = "Automatic Hugging Unit v1.0 Alpha"
	path_image_color = "#FFDDDD"

	base_speed = 4

	var/stationary_mode = 0 //If enabled, the Hugbot will not move automatically.
	var/mob/living/carbon/patient = null
	var/mob/living/carbon/oldpatient = null
	var/last_found = 0


/mob/living/simple_animal/bot/hugbot/update_icon()
	cut_overlays()
	if(!on)
		icon_state = "hugbot0"
		return
	if(IsStun())
		icon_state = "hugbota"
		return
	if(mode == BOT_HEALING)
		icon_state = "hugbots[stationary_mode]"
		return
	else if(stationary_mode) //Bot has yellow light to indicate stationary mode.
		icon_state = "hugbot2"
	else
		icon_state = "hugbot1"

/mob/living/simple_animal/bot/medbot/Initialize(mapload, new_skin)
	. = ..()
	update_icon()


/mob/living/simple_animal/bot/hugbot/update_canmove()
	. = ..()
	update_icon()

/mob/living/simple_animal/bot/hugbot/bot_reset()
	..()
	update_icon()

/mob/living/simple_animal/bot/hugbot/proc/soft_reset() //Allows the medibot to still actively perform its medical duties without being completely halted as a hard reset does.
	path = list()
	patient = null
	mode = BOT_IDLE
	last_found = world.time
	update_icon()

/mob/living/simple_animal/bot/hugbot/set_custom_texts()

	text_hack = "You bypass [name]'s manipulator pressure sensors."
	text_dehack = "You rewire [name]'s manipulator pressure sensors."
	text_dehack_fail = "[name] seems damaged and does not respond to reprogramming!"

/mob/living/simple_animal/bot/hugbot/attack_paw(mob/user)
	return attack_hand(user)

/mob/living/simple_animal/bot/hugbot/get_controls(mob/user)
	var/dat
	dat += hack(user)
	dat += showpai(user)
	dat += "<TT><B>Hugging Unit Controls v1.0 Alpha</B></TT><BR><BR>"
	dat += "Status: <A href='?src=[REF(src)];power=1'>[on ? "On" : "Off"]</A><BR>"
	dat += "Maintenance panel panel is [open ? "opened" : "closed"]<BR>"
	dat += "Behaviour controls are [locked ? "locked" : "unlocked"]<hr>"
	if(!locked || issilicon(user) || IsAdminGhost(user))
		dat += "Patrol Station: <a href='?src=[REF(src)];operation=patrol'>[auto_patrol ? "Yes" : "No"]</a><br>"
		dat += "Stationary Mode: <a href='?src=[REF(src)];stationary=1'>[stationary_mode ? "Yes" : "No"]</a><br>"

	return dat

/mob/living/simple_animal/bot/hugbot/Topic(href, href_list)
	if(..())
		return 1

	update_controls()
	return

/mob/living/simple_animal/bot/hugbot/attackby(obj/item/W as obj, mob/user as mob, params)
	var/current_health = health
	..()
	if(health < current_health) //if medbot took some damage
		step_to(src, (get_step_away(src,user)))

/mob/living/simple_animal/bot/hugbot/emag_act(mob/user)
	..()
	if(emagged == 2)
		if(user)
			to_chat(user, "<span class='notice'>You short out [src]'s manipulator pressure sensors.</span>")
		audible_message("<span class='danger'>[src]'s arm twitches violently!</span>")
		flick("medibot_spark", src)
		playsound(src, "sparks", 75, 1)


/mob/living/simple_animal/bot/hugbot/proc/assess_patient(mob/living/carbon/C)
	//Time to see if they need medical help!
	if(C.stat == DEAD || (HAS_TRAIT(C, TRAIT_FAKEDEATH)))
		return FALSE	//welp too late for them!

	if(!(loc == C.loc) && !(isturf(C.loc) && isturf(loc)))
		return FALSE

	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		var/datum/component/mood/mood = H.GetComponent(/datum/component/mood)
		if(emagged != 2) // EVERYONE GETS HUGS!
			for(var/datum/mood_event/i in  mood.mood_events)
				if (i.description == "<span class='nicegreen'>Hugs are nice.</span>\n" )
					return FALSE
		else if (C.IsKnockdown())
			return FALSE
		return TRUE

	return FALSE

/mob/living/simple_animal/bot/hugbot/process_scan(mob/living/carbon/human/H)
	if(H.stat == DEAD)
		return

	if((H == oldpatient) && (world.time < last_found + 200))
		return

	if(assess_patient(H))
		last_found = world.time
		return H
	else
		return

/mob/living/simple_animal/bot/hugbot/handle_automated_action()
	if(!..())
		return

	if(mode == BOT_HEALING)
		medicate_patient(patient)
		return

	if(IsStun())
		oldpatient = patient
		patient = null
		mode = BOT_IDLE
		update_icon()
		return

	if(frustration > 8)
		oldpatient = patient
		soft_reset()

	if(QDELETED(patient))
		var/scan_range = (stationary_mode ? 1 : DEFAULT_SCAN_RANGE) //If in stationary mode, scan range is limited to adjacent patients.
		patient = scan(/mob/living/carbon/human, oldpatient, scan_range)
		oldpatient = patient

	if(patient && (get_dist(src,patient) <= 1)) //Patient is next to us, begin treatment!
		if(mode != BOT_HEALING)
			mode = BOT_HEALING
			update_icon()
			frustration = 0
			medicate_patient(patient)
		return

	//Patient has moved away from us!
	else if(patient && path.len && (get_dist(patient,path[path.len]) > 2))
		path = list()
		mode = BOT_IDLE
		last_found = world.time

	else if(stationary_mode && patient) //Since we cannot move in this mode, ignore the patient and wait for another.
		soft_reset()
		return

	if(patient && path.len == 0 && (get_dist(src,patient) > 1))
		path = get_path_to(src, get_turf(patient), /turf/proc/Distance_cardinal, 0, 30,id=access_card)
		mode = BOT_MOVING
		if(!path.len) //try to get closer if you can't reach the patient directly
			path = get_path_to(src, get_turf(patient), /turf/proc/Distance_cardinal, 0, 30,1,id=access_card)
			if(!path.len) //Do not chase a patient we cannot reach.
				soft_reset()

	if(path.len > 0 && patient)
		if(!bot_move(path[path.len]))
			oldpatient = patient
			soft_reset()
		return

	if(path.len > 8 && patient)
		frustration++

	if(auto_patrol && !stationary_mode && !patient)
		if(mode == BOT_IDLE || mode == BOT_START_PATROL)
			start_patrol()

		if(mode == BOT_PATROL)
			bot_patrol()

	return

/mob/living/simple_animal/bot/hugbot/UnarmedAttack(atom/A)
	if(iscarbon(A))
		var/mob/living/carbon/C = A
		patient = C
		mode = BOT_HEALING
		update_icon()
		medicate_patient(C)
		update_icon()
	else
		..()

/mob/living/simple_animal/bot/hugbot/proc/medicate_patient(mob/living/carbon/C)
	if(!on)
		return

	if(!istype(C))
		oldpatient = patient
		soft_reset()
		return

	if(C.stat == DEAD || (HAS_TRAIT(C, TRAIT_FAKEDEATH)))
		oldpatient = patient
		soft_reset()
		return

	visible_message("<span class='notice'>[src] hugs [C] to make [C.p_them()] feel better!</span>", \
			"<span class='notice'>You hug [C] to make [C.p_them()] feel better!</span>")
	SEND_SIGNAL(C, COMSIG_ADD_MOOD_EVENT, "hug", /datum/mood_event/hug)

	if (emagged != 2)
		C.AdjustStun(-60)
		C.AdjustKnockdown(-60)
		C.AdjustUnconscious(-60)
		C.AdjustSleeping(-100)
		if(recoveringstam)
			C.adjustStaminaLoss(-15)
		else if(resting)
			C.resting = 0
			C.update_canmove()
	else
		C.Knockdown(100)
		C.Stun(100)
		C.update_canmove()

	playsound(C.loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)

	oldpatient = patient
	patient = null
	mode = BOT_IDLE
	update_icon()
	return

/mob/living/simple_animal/bot/hugbot/explode()
	on = FALSE
	visible_message("<span class='boldannounce'>[src] blows apart!</span>")
	do_sparks(3, TRUE, src)
	..()

/obj/machinery/bot_core/hugbot
	req_one_access = list(ACCESS_ROBOTICS)

/obj/item/bot_assembly/hugbot
	desc = "It's a box of hugs with an arm attached."
	name = "incomplete hugbot assembly"
	icon = 'hyperstation/icons/mobs/aibots.dmi'
	icon_state = "hugbot_arm"
	created_name = "Hugbot"

/obj/item/bot_assembly/hugbot/attackby(obj/item/W, mob/user, params)
	..()
	if(istype(W, /obj/item/assembly/prox_sensor))
		if(!can_finish_build(W, user))
			return
		var/mob/living/simple_animal/bot/hugbot/A = new(drop_location())
		A.name = created_name
		A.robot_arm = W.type
		to_chat(user, "<span class='notice'>You add [W] to [src]. Beep boop!</span>")
		qdel(W)
		qdel(src)

/obj/item/storage/box/hug/attackby(obj/item/I, mob/user, params)
	if((istype(I, /obj/item/bodypart/l_arm/robot)) || (istype(I, /obj/item/bodypart/r_arm/robot)))
		if(contents.len) //prevent accidently deleting contents
			to_chat(user, "<span class='warning'>You need to empty [src] out first!</span>")
			return
		if(!user.temporarilyRemoveItemFromInventory(I))
			return
		qdel(I)
		to_chat(user, "<span class='notice'>You add [I] to the [src]! You've got a hugbot assembly now!</span>")
		var/obj/item/bot_assembly/hugbot/A = new
		qdel(src)
		user.put_in_hands(A)
	else
		return ..()
