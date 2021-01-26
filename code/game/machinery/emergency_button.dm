/obj/machinery/emergencybutton
	name = "Emergency Meeting Button"
	desc = "A remote control button to call the Heads of Staff to an urgent meeting. Three uses only, be wise!"
	icon = 'icons/obj/assemblies.dmi'
	icon_state = "bigred" //for now uses the big red button icon, but preferably should be changed to two icon states, one with a glass cover and one without. need someone to sprite it for me
	power_channel = ENVIRON
	armor = list("melee" = 50, "bullet" = 50, "laser" = 50, "energy" = 50, "bomb" = 10, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 70)
	use_power = IDLE_POWER_USE
	idle_power_usage = 2
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	anchored = TRUE
	var/broadcasting_emergency = 3
	var/obj/item/radio/radio
	var/radio_key = /obj/item/encryptionkey/headset_com
	var/command_channel = "Command"
	var/common_channel = null
	var/speaking = null
	var/nextuse = 0

/obj/machinery/emergencybutton/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	broadcast()

/obj/machinery/emergencybutton/proc/broadcast()
	if(!broadcasting_emergency)
		return
	if(world.time < nextuse)
		return
	speaking = "Calling all Heads of Staff or any current station leadership to the Staff Briefing Room due to emergent issues."
	radio.talk_into(src, speaking, "Command")
	nextuse = world.time + 5 MINUTES
	broadcasting_emergency--

/obj/machinery/emergencybutton/emag_act(mob/user)
	if(obj_flags & EMAGGED)
		return
	req_access = list()
	req_one_access = list()
	playsound(src, "sparks", 100, 1)
	for(var/mob/M in GLOB.player_list)
		SEND_SOUND(M, sound('sound/effects/emergency.ogg'))
	obj_flags |= EMAGGED
	speaking = "$%()$·)(CALLING ALL CREW TO THE BRIEFING ROOM DUE TO SUSPICIOUS ACTIVITY. THIS IS MANDATORY."
	radio.talk_into(src, speaking, common_channel)
	addtimer(CALLBACK(src, .proc/teleport_crew), 10 SECONDS)

/obj/machinery/emergencybutton/proc/teleport_crew()
	for(var/mob/living/carbon/human/H in GLOB.alive_mob_list)
		if(H.z != z)
			continue
		if(H.stat == DEAD)
			continue
		do_teleport(H, get_turf(src), 2, TRUE)
		H.Stun(300) //30 seconds of sus time

/obj/machinery/emergencybutton/Initialize()
	. = ..()
	radio = new(src)
	radio.keyslot = new radio_key
	radio.listening = 0
	radio.recalculateChannels()
