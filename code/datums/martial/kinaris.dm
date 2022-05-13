#define KNS_KICK_COMBO "DG"
#define KNS_RESTRAIN_COMBO "GG"

/datum/martial_art/kinaris
	name = "KNS CQC"
	id = MARTIALART_KNS_CQC
	help_verb = /mob/living/carbon/human/proc/KNS_CQC_help
	block_chance = 75

/datum/martial_art/kinaris/proc/drop_restraining()
	restraining = FALSE

/datum/martial_art/kinaris/proc/check_streak(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(!can_use(A))
		return FALSE
	if(findtext(streak,KNS_KICK_COMBO))
		streak = ""
		Kick(A,D)
		return TRUE
	if(findtext(streak,KNS_RESTRAIN_COMBO))
		streak = ""
		Restrain(A,D)
		return TRUE
	return FALSE

/datum/martial_art/kinaris/proc/Kick(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(!can_use(A))
		return FALSE
	if(!D.stat || !D.IsKnockdown())
		D.visible_message("<span class='warning'>[A] kicks [D] back!</span>", \
							"<span class='userdanger'>[A] kicks you back!</span>")
		playsound(get_turf(A), 'sound/weapons/cqchit1.ogg', 50, 1, -1)
		var/atom/throw_target = get_edge_target_turf(D, A.dir)
		D.throw_at(throw_target, 1, 14, A)
		D.apply_damage(10, BRUTE)
		log_combat(A, D, "kicked (KNS CQC)")
	if(D.IsKnockdown() && !D.stat)
		D.visible_message("<span class='warning'>[A] kicks [D]'s head, knocking [D.p_them()] out!</span>", \
					  		"<span class='userdanger'>[A] kicks your head, knocking you out!</span>")
		playsound(get_turf(A), 'sound/weapons/genhit1.ogg', 50, 1, -1)
		D.SetSleeping(300)
		D.adjustOrganLoss(ORGAN_SLOT_BRAIN, 15, 150)
	return TRUE

/datum/martial_art/kinaris/proc/Restrain(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(restraining)
		return
	if(!can_use(A))
		return FALSE
	if(!D.stat)
		D.visible_message("<span class='warning'>[A] locks [D] into a restraining position!</span>", \
							"<span class='userdanger'>[A] locks you into a restraining position!</span>")
		D.adjustStaminaLoss(20)
		D.Stun(100)
		restraining = TRUE
		addtimer(CALLBACK(src, .proc/drop_restraining), 50, TIMER_UNIQUE)
	return TRUE

/datum/martial_art/kinaris/grab_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(!can_use(A))
		return FALSE
	add_to_streak("G",D)
	if(check_streak(A,D))
		return TRUE
	if(A.grab_state >= GRAB_AGGRESSIVE)
		D.grabbedby(A, 1)
	else
		A.start_pulling(D, 1)
		if(A.pulling)
			D.stop_pulling()
			log_combat(A, D, "grabbed", addition="aggressively")
			A.grab_state = GRAB_AGGRESSIVE //Instant aggressive grab
	return TRUE

/datum/martial_art/kinaris/disarm_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(!can_use(A))
		return FALSE
	add_to_streak("D",D)
	var/obj/item/I = null
	if(check_streak(A,D))
		return TRUE
	if(prob(65))
		if(!D.stat || !D.IsKnockdown() || !restraining)
			I = D.get_active_held_item()
			D.visible_message("<span class='warning'>[A] strikes [D]'s jaw with their hand!</span>", \
								"<span class='userdanger'>[A] strikes your jaw, disorienting you!</span>")
			playsound(get_turf(D), 'sound/weapons/cqchit1.ogg', 50, 1, -1)
			if(I && D.temporarilyRemoveItemFromInventory(I))
				A.put_in_hands(I)
			D.Jitter(2)
			D.apply_damage(5, BRUTE)
	else
		D.visible_message("<span class='danger'>[A] attempted to disarm [D]!</span>", \
							"<span class='userdanger'>[A] attempted to disarm [D]!</span>")
		playsound(D, 'sound/weapons/punchmiss.ogg', 25, 1, -1)
	log_combat(A, D, "disarmed (KNS CQC)", "[I ? " grabbing \the [I]" : ""]")
	if(restraining && A.pulling == D)
		D.visible_message("<span class='danger'>[A] puts [D] into a chokehold!</span>", \
							"<span class='userdanger'>[A] puts you into a chokehold!</span>")
		D.SetSleeping(400)
		restraining = FALSE
		if(A.grab_state < GRAB_NECK)
			A.grab_state = GRAB_NECK
	else
		restraining = FALSE
		return FALSE
	return TRUE

/mob/living/carbon/human/proc/KNS_CQC_help()
	set name = "Remember The Basics"
	set desc = "You try to remember some of the basics of training."
	set category = "KNS CQC"
	to_chat(usr, "<b><i>You try to remember some of your training, undertaken when entering Kinaris employ.</i></b>")

	to_chat(usr, "<span class='notice'>CQC Kick</span>: Disarm Grab. Knocks opponent away. Knocks out stunned or knocked down opponents.")
	to_chat(usr, "<span class='notice'>Restrain</span>: Grab Grab. Locks opponents into a restraining position, disarm to knock them out with a choke hold.")
