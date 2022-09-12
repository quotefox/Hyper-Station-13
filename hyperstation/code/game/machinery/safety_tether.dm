//Teleports players who fall off cloud chasm tiles to itself, drawing power in the process.

//bugs; power draw not working

//Maybe if separating into multiple objects like with the grav gen, have it arc tesla lightning to each corner upon teleport?


// Have it pull back all player mobs, and all borgs if possible
// have chasm tiles, when something falls in send a signal that the safety tether catches, containing the chasm turf and the mob
// then the tether can either report it's inactive to the tile so that it then deletes the entity, or teeleport the player

// create global list of safety tethers in the world to then process

//Easy definitions to have the machine talk on the appropriate frequencies.
//#define SPEAK(message) radio.talk_into(src, message, radio_channel)

#define SPEAKMEDICAL(message) radio.talk_into(src, message, RADIO_CHANNEL_MEDICAL)
#define SPEAKSCIENCE(message) radio.talk_into(src, message, RADIO_CHANNEL_SCIENCE)

/obj/machinery/safety_tether
	name = "safety tether"
	desc = "A gargantuan machine that performs emergency teleportations on those unlucky or clumsy enough to slip off the edge."
	density = FALSE
	icon = 'hyperstation/icons/obj/machinery/safety_tether.dmi'
	icon_state = "safety_tether"
	verb_say = "states"

	//Shifts the starting location so as to center the machine
	pixel_x = -32
	pixel_y = -32

	//Set width and height in case we make this dense
	bound_width = 96
	bound_height = 96

	//We don't want this getting destroyed since it cannot be remade.
	move_resist = INFINITY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

	//var/obj/machinery/computer/tether_computer/connected = null //So we remember the connected clone machine.

	//Here for easy balancing and possibly changing it between different tether objects or if upgrades occur.

	var/dismember_prob = 50 //Probability of dismembering 2 limbs rather than 1

	//Max and min amounts of clone damage for organics
	var/cloneloss_min = 45
	var/cloneloss_max = 70

	//Amount of subject's blood to keep on successful teleport
	var/bleed_ratio = 0.75

	//Max and min amounts of burn damage for silicates.
	/*
	Cyborg health guide
	100;   max health
	<50;   module 3 offline
	<0;    module 2 offline
	<-50;  module 3 offline
	-100+; death
	*/
	var/silicon_burn_min = 120
	var/silicon_burn_max = 140

	var/brightness_on = 4 //Range of light when on
	light_power = 1.5 //Strength of the light when on
	light_color = LIGHT_COLOR_CYAN

	//Defines the center point around which lighting is located
	var/atom/light_source
	//_mask = matrix(1, 0, 32, 0, 1, 32)

	use_power = IDLE_POWER_USE
	power_channel = EQUIP
	idle_power_usage = 1000
	var/teleport_power_draw = 900000 //Uses about a fourth of the upgraded power cell plus default in APCs
	var/tesla_power_ratio = 0.01 //ratio of its actual power draw to the tesla it creates, 9000 total looks decent

	critical_machine = FALSE //If this machine is critical to station operation and should have the area be excempted from power failures.

	var/internal_radio = TRUE
	var/obj/item/radio/radio

	//Give it permission to talk on both medical and science frequencies, as with geneticists
	var/radio_key = /obj/item/encryptionkey/headset_medsci

	//var/radio_channel = RADIO_CHANNEL_MEDICAL

/obj/machinery/safety_tether/Initialize()
	. = ..()

	//Adds this to the global list of safety tethers in the world to pull from when chasms attempt to drop mobs
	GLOB.safety_tethers_list += src

	if(internal_radio)
		radio = new(src)
		radio.keyslot = new radio_key
		radio.subspace_transmission = TRUE
		radio.canhear_range = 0
		radio.recalculateChannels()

	//ensures light is properly centered around the tether. Removes lighting system's pixel approximation that breaks it.
	light_source = get_turf(src)
	update_icon()
	power_change() //Here to start lights on ititialization.

/obj/machinery/safety_tether/Destroy()
	QDEL_NULL(radio)
	GLOB.safety_tethers_list -= src
	. = ..()

/obj/machinery/safety_tether/doMove(atom/destination)
	. = ..()
	//ensures light is properly centered around the tether. Removes lighting system's pixel approximation that breaks it.
	light_source = get_turf(src)
	return .

/obj/machinery/safety_tether/update_icon()
	cut_overlays()
	if(is_operational())
		add_overlay("operational_overlay")


/obj/machinery/safety_tether/examine(mob/user)
	. = ..()
	if(is_operational())
		. += "The safety tether's currently protecting the station."
	else
		. += "The safety tether's offline."


/obj/machinery/safety_tether/attack_ai(mob/user)
	return examine(user)

//Returns true if teleport is successful, false otherwise
/obj/machinery/safety_tether/proc/bungee_teleport(mob/living/M)

	if(ismovableatom(M) && is_operational() != 0 && do_teleport(M, get_turf(src), channel = TELEPORT_CHANNEL_BLUESPACE))
		use_power(teleport_power_draw)

		//Style points
		playsound(src, 'sound/magic/lightningbolt.ogg', 100, 1, extrarange = 5)
		// TESLA_MOB_DAMAGE | TESLA_OBJ_DAMAGE  | TESLA_MOB_STUN | TESLA_ALLOW_DUPLICATES
		tesla_zap(src, 3, teleport_power_draw * tesla_power_ratio, TESLA_MOB_DAMAGE | FALSE  | TESLA_MOB_STUN | FALSE) //Set to zap harmlessly but in a way that looks cool

		M.spawn_gibs()
		M.emote("scream")

		//priority_announce("[M] ([key_name(M)]) had a tether mishap")

		if(iscarbon(M))

			var/mob/living/carbon/Carbon = M

			to_chat(Carbon, "<span class='italics'>Buzzing static snaps taut on your chest....</span>")
			Carbon.adjustCloneLoss(rand(40,75))

			//Random limb removal
			var/dismember_num = 1

			//Dismember two limbs
			if(prob(dismember_prob))
				dismember_num = 2

			var/dismembered_arm = FALSE
			var/dismembered_leg = FALSE

			for(var/obj/item/bodypart/BP in Carbon.bodyparts)
				if(BP.body_part != CHEST && BP.body_part != HEAD) //I am not ready to find out what happens if your chest is missing
					var/zone = BP.body_zone
					//Checks to ensure that only one arm and one leg each are dismembered, to prevent severe disabling like 2 arms being removed.
					if(zone == BODY_ZONE_L_ARM || zone == BODY_ZONE_R_ARM)
						if(!dismembered_arm)
							dismembered_arm = TRUE
							BP.dismember()

					if(zone == BODY_ZONE_L_LEG || zone == BODY_ZONE_R_LEG)
						if(!dismembered_leg)
							dismembered_leg = TRUE
							BP.dismember()

					dismember_num -= 1

					//We've dismembered enough limbs.
					if(dismember_num <= 0)
						break

			//Bleed our pal a little
			M.blood_volume = BLOOD_VOLUME_NORMAL * M.blood_ratio * bleed_ratio

			src.visible_message("<span class='boldwarning'>[src] spits out [M] and viscera!</span>")
			if(internal_radio)

				//Area name gotten just in case the locale of it's moved from engineering when mapmaking.
				var/area/A = get_area(get_turf(src))
				var/area_name = A.name
				SPEAKMEDICAL("The safety tether's caught the would-be crater [M] at the [area_name].")

			//All this ended up causing issues by canting the player 90 degrees due to the player having enforced rest at the time of teleportation
			//animate(M, transform = oldtransform, alpha = oldalpha, color = oldcolor, time = 10)

			//M.transform = oldtransform
			//M.alpha = oldalpha
			//M.color = oldcolor
		else
			if(issilicon(M))
				var/mob/living/silicon/S = M
				to_chat(S, "<span class='italics'>Your circuits spark, slag, and pop as overwhelming white noise crackles and YANKS...</span>")
				S.apply_damage_type(damage = rand(silicon_burn_min, silicon_burn_max), damagetype = BURN)

				if(internal_radio)

					//Area name gotten just in case the locale of it's moved from engineering when mapmaking.
					var/area/A = get_area(get_turf(src))
					var/area_name = A.name
					SPEAKSCIENCE("The safety tether's caught the would-be crater [M] at the [area_name].")

		return TRUE

	else
		return FALSE

//Updates machine icon and lighting every time power in the area changes
/obj/machinery/safety_tether/power_change()
	. = ..()
	if(light_source)
		if(stat & NOPOWER)
			light_source.set_light(0)
		else
			light_source.set_light(brightness_on, light_power, light_color)
	update_icon()

//possible emagging or other interactions later, like EMPs
/*
/obj/machinery/safety_tether/emag_act(mob/user)
	if(!occupant)
		return
	to_chat(user, "<span class='warning'>You corrupt the genetic compiler.</span>")
	malfunction()

/obj/machinery/clonepod/proc/malfunction()
	var/mob/living/mob_occupant = occupant
	if(mob_occupant)
		connected_message("Critical Error!")
		SPEAK("Critical error! Please contact a Thinktronic Systems \
			technician, as your warranty may be affected.")
		mess = TRUE
		maim_clone(mob_occupant)	//Remove every bit that's grown back so far to drop later, also destroys bits that haven't grown yet
		update_icon()
		if(mob_occupant.mind != clonemind)
			clonemind.transfer_to(mob_occupant)
		mob_occupant.grab_ghost() // We really just want to make you suffer.
		flash_color(mob_occupant, flash_color="#960000", flash_time=100)
		to_chat(mob_occupant, "<span class='warning'><b>Agony blazes across your consciousness as your body is torn apart.</b><br><i>Is this what dying is like? Yes it is.</i></span>")
		playsound(src.loc, 'sound/machines/warning-buzzer.ogg', 50, 0)
		SEND_SOUND(mob_occupant, sound('sound/hallucinations/veryfar_noise.ogg',0,1,50))
		QDEL_IN(mob_occupant, 40)

/obj/machinery/clonepod/emp_act(severity)
	. = ..()
	if (!(. & EMP_PROTECT_SELF))
		var/mob/living/mob_occupant = occupant
		if(mob_occupant && prob(100/(severity*efficiency)))
			connected_message(Gibberish("EMP-caused Accidental Ejection", 0))
			SPEAK(Gibberish("Exposure to electromagnetic fields has caused the ejection of, ERROR: John Doe, prematurely." ,0))
			mob_occupant.apply_vore_prefs()
			go_out()

/obj/machinery/clonepod/proc/horrifyingsound()
	for(var/i in 1 to 5)
		playsound(loc,pick('sound/hallucinations/growl1.ogg','sound/hallucinations/growl2.ogg','sound/hallucinations/growl3.ogg'), 100, rand(0.95,1.05))
		sleep(1)
	sleep(10)
	playsound(loc,'sound/hallucinations/wail.ogg',100,1)

/obj/machinery/clonepod/deconstruct(disassembled = TRUE)
	if(occupant)
		go_out()
	..()
*/

// Write up a manual maybe?
/*
 *	Manual -- A big ol' manual.
 */
/*
/obj/item/paper/guides/jobs/medical/cloning
	name = "paper - 'H-87 Cloning Apparatus Manual"
	info = {"<h4>Getting Started</h4>
	Congratulations, your station has purchased the H-87 industrial cloning device!<br>
	Using the H-87 is almost as simple as brain surgery! Simply insert the target humanoid into the scanning chamber and select the scan option to create a new profile!<br>
	<b>That's all there is to it!</b><br>
	<i>Notice, cloning system cannot scan inorganic life or small primates.  Scan may fail if subject has suffered extreme brain damage.</i><br>
	<p>Clone profiles may be viewed through the profiles menu. Scanning implants a complementary HEALTH MONITOR IMPLANT into the subject, which may be viewed from each profile.
	Profile Deletion has been restricted to \[Station Head\] level access.</p>
	<h4>Cloning from a profile</h4>
	Cloning is as simple as pressing the CLONE option at the bottom of the desired profile.<br>
	Per your company's EMPLOYEE PRIVACY RIGHTS agreement, the H-87 has been blocked from cloning crewmembers while they are still alive.<br>
	<br>
	<p>The provided CLONEPOD SYSTEM will produce the desired clone.  Standard clone maturation times (With SPEEDCLONE technology) are roughly 90 seconds.
	The cloning pod may be unlocked early with any \[Medical Researcher\] ID after initial maturation is complete.</p><br>
	<i>Please note that resulting clones may have a small DEVELOPMENTAL DEFECT as a result of genetic drift.</i><br>
	<h4>Profile Management</h4>
	<p>The H-87 (as well as your station's standard genetics machine) can accept STANDARD DATA DISKETTES.
	These diskettes are used to transfer genetic information between machines and profiles.
	A load/save dialog will become available in each profile if a disk is inserted.</p><br>
	<i>A good diskette is a great way to counter aforementioned genetic drift!</i><br>
	<br>
	<font size=1>This technology produced under license from Thinktronic Systems, LTD.</font>"}
*/

//#undef SPEAK
#undef SPEAKMEDICAL
#undef SPEAKSCIENCE