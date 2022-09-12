//Teleports players who fall off cloud chasm tiles to itself, drawing power in the process.

//bugs; power draw not working

//Maybe if separating into multiple objects like with the grav gen, have it arc tesla lightning to each corner upon teleport?


// Have it pull back all player mobs, and all borgs if possible
// have chasm tiles, when something falls in send a signal that the safety tether catches, containing the chasm turf and the mob
// then the tether can either report it's inactive to the tile so that it then deletes the entity, or teeleport the player

// create global list of safety tethers in the world to then process

//Easy definitions to have the machine talk on the appropriate frequencies.
#define SPEAKCOMMON(message) radio.talk_into(src, message, null)
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

	//Amount of subject's blood to remove on successful teleport
	var/bleed_ratio = 0.25

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

	use_power = IDLE_POWER_USE
	power_channel = EQUIP
	idle_power_usage = 1000
	var/teleport_power_draw = 900000 //Uses about a fourth of the upgraded power cell plus default in APCs
	var/tesla_power_ratio = 0.75 //ratio of its actual power draw to the tesla it creates

	critical_machine = TRUE //If this machine is critical to station operation and should have the area be excempted from power failures.

	var/internal_radio = TRUE
	var/obj/item/radio/radio

	//Give it permission to talk on both medical and science frequencies, as with geneticists
	var/radio_key = /obj/item/encryptionkey/headset_medsci

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

		log_admin("[M] ([key_name(M)]) was saved by the Safety Tether.")

		if(iscarbon(M))

			var/mob/living/carbon/Carbon = M

			to_chat(Carbon, "<span class='italics'>Buzzing static snaps taut on your chest....</span>")
			Carbon.adjustCloneLoss(rand(cloneloss_min, cloneloss_max))

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
			M.blood_volume -= BLOOD_VOLUME_NORMAL * M.blood_ratio * bleed_ratio

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

				src.visible_message("<span class='boldwarning'>[src] spits out [M] and oily, smoking circuits!</span>")
				if(internal_radio)

					//Area name gotten just in case the locale of it's moved from engineering when mapmaking.
					var/area/A = get_area(get_turf(src))
					var/area_name = A.name
					SPEAKSCIENCE("The safety tether's caught the would-be crater [M] at the [area_name].")

		return TRUE

	else
		log_admin("[M] ([key_name(M)]) was failed by the Safety Tether and fell into the clouds.")
		return FALSE

//Updates machine icon and lighting every time power in the area changes
/obj/machinery/safety_tether/power_change()
	. = ..()
	if(light_source)
		if(stat & NOPOWER)
			SPEAKCOMMON("The Safety Tether's shut down from a lack of power.")
			light_source.set_light(0)
		else
			SPEAKCOMMON("The Safety Tether is back online.")
			light_source.set_light(brightness_on, light_power, light_color)
	update_icon()

/*
 *	Manual -- A big ol' manual.
 */

/obj/item/paper/fluff/safety_tether
	name = "paper - 'Safety Tether Introduction"
	info = {"<center><h4>Kinaris IVA Safety Tether</h4></center>
	Hello, if you’re reading this note, that means you’ve been selected to work in our Retrograde Tether Program. Few portions of Andromeda have such outdated engrams as Layenia does, so getting a proper Tether raised quite a lot of pushback. However, working in a gas giant has been deemed hazardous enough to warrant the allowance of a Safety Tether.<br><br>
	For those unfamiliar with the technology of a Safety Tether;
	<b>First</b> and foremost; Understand that it needs to be powered <b>at all times</b>. Failure to supply constant energy to the tether can and will prevent its function, and doom personnel to the clouds beneath if any are so unlucky as to fall in the interim. <br>
	<b>Secondly</b>; Speaking of clouds. when powered, the tether will rescue any humanoid beings or borgs who would slip into them.<br>
	<b>Thirdly</b>; Large amounts of electricity are siphoned upon any and every use of the Safety Tether, enough so to arc through the air and <i>hopefully</i> into the grounding rods supplied nearby. The transit of matter instantaneously and unplanned to one location from anywhere on the planet is, understandably, enough to drain a fourth of the APCs energy or so when activated.<br><br>

	<i>However</i>, the old engram Layenia works under is faulty <i>at best</i>, resulting in <u>blood loss, loss of limbs, and painful cellular damages or burns to personnel and cyborgs respectively</u> when falling into the clouds. Because of this, caution is still highly advised when working on the exterior of Layenia. A radio has been retrofitted to the device to call appropriate medical or scientific services onscene as an added precaution.<br><br>
	Should any more information be needed on the tether, please contact your local sector executive."}

//#undef SPEAK
#undef SPEAKCOMMON
#undef SPEAKMEDICAL
#undef SPEAKSCIENCE