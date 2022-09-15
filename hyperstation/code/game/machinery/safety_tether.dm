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
#define CENTER_TURF get_turf(get_step(src, NORTHEAST))

/obj/machinery/safety_tether
	name = "safety tether"
	desc = "A gargantuan machine that performs emergency teleportations on those unlucky or clumsy enough to slip off the edge."
	density = FALSE
	icon = 'hyperstation/icons/obj/machinery/safety_tether.dmi'
	icon_state = "safety_tether"
	verb_say = "states"

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
	var/cloneloss_min = 90
	var/cloneloss_max = 95

	//Final health a mob should end up at, later adjusted for max health
	var/carbon_final_health = -20

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
	var/silicon_burn_min = 160
	var/silicon_burn_max = 180

	var/brightness_on = 4 //Range of light when on
	light_power = 1.5 //Strength of the light when on
	light_color = LIGHT_COLOR_CYAN

	//Defines the center point around which lighting is located
	var/atom/light_source

	use_power = IDLE_POWER_USE
	power_channel = EQUIP
	idle_power_usage = 1000
	var/teleport_power_draw = 900000 //Uses about a fourth of the upgraded power cell plus default in APCs
	var/tesla_power_ratio = 0.75 //Ratio of its actual power draw to the tesla it creates

	critical_machine = TRUE //If this machine is critical to station operation and should have the area be excempted from power failures.

	//Area types we're allowed to teleport players to. Set up in initialize.
	var/list/allowed_area_types/*= typecacheof(list(/area/maintenance)) */
	var/list/blacklisted_areas /*= typecacheof(list(/area)) */
	var/list/whitelisted_areas /*= typecacheof(list(/area)) */
	var/list/allowed_areas

	//Whitelist and blacklist of types to not dump players into walls or chasms. Set up in initialize.
	//Separate check each time for dense objects in way when getRandomTurf called, since no GLOB list of unblocked turfs maintained
	var/list/turf/allowed_turf_types
	var/list/turf/disallowed_turf_types
	var/list/allowed_turfs

	//What types of chasms are protected by this tether
	var/protected_chasm_type = /turf/open/chasm/cloud

	var/internal_radio = TRUE
	var/obj/item/radio/radio

	//Give it permission to talk on both medical and science frequencies, as with geneticists
	var/radio_key = /obj/item/encryptionkey/headset_medsci

/obj/machinery/safety_tether/Initialize()
	//ensures light is properly centered around the tether. Removes lighting system's pixel approximation that breaks it.
	light_source = CENTER_TURF
	. = ..()

	//Adds this to the global list of safety tethers in the world to pull from when chasms attempt to drop mobs
	GLOB.safety_tethers_list += src

	if(internal_radio)
		radio = new(src)
		radio.keyslot = new radio_key
		radio.subspace_transmission = TRUE
		radio.canhear_range = 0
		radio.listening = FALSE
		radio.recalculateChannels()

	//Setting up the lists for valid teleportation areas
	allowed_area_types = typecacheof(list(/area/maintenance))
	//blacklisted_areas = typecacheof(list(/area/))
	//whitelisted_areas = typecacheof(list(/area/))

	//Set up the list of allowed areas based on our three categories
	allowed_areas = make_associative(allowed_area_types - blacklisted_areas + whitelisted_areas)

	//Don't dump players into walls or chasms
	allowed_turf_types = typecacheof(list(/turf/open))
	disallowed_turf_types = typecacheof(list(/turf/open/chasm))

	allowed_turfs = make_associative(allowed_turf_types - disallowed_turf_types)

	update_icon()

/obj/machinery/safety_tether/Destroy()
	QDEL_NULL(radio)
	GLOB.safety_tethers_list -= src
	light_source.set_light(0)
	. = ..()

/obj/machinery/safety_tether/doMove(atom/destination)
	. = ..()
	//ensures light is properly centered around the tether. Removes lighting system's pixel approximation that breaks it.
	light_source.set_light(0)
	light_source = CENTER_TURF
	return .

/obj/machinery/safety_tether/update_icon()
	cut_overlays()
	if(is_operational())
		add_overlay("operational_overlay")
		if(light_source)
			light_source.set_light(brightness_on, light_power, light_color)
	else
		if(light_source)
			light_source.set_light(0)

/obj/machinery/safety_tether/examine(mob/user)
	. = ..()
	var/operating = is_operational()
	. += "The safety tether's [operating ? "on" : "off"]line."


/obj/machinery/safety_tether/attack_ai(mob/user)
	return examine(user)


//Procedure to find a random area to teleport a mob to
/obj/machinery/safety_tether/proc/findRandomTurf()

	//Pick an area
	var/area/selected_area = safepick(typecache_filter_list(GLOB.sortedAreas,allowed_areas))

	//Compile a list of turfs to pick from
	var/list/turf/open/unblocked_turfs = typecache_filter_list(get_area_turfs(selected_area),allowed_turfs)

	//Check if there's objects with density like machines, doors, or windows in the way, removed from pick list if so
	for(var/turf/open/T in unblocked_turfs)
		if(is_blocked_turf(T))
			unblocked_turfs -= T

	//Pick a specific turf from our list and return it
	return safepick(unblocked_turfs)


//Returns true if teleport is successful, false otherwise
/obj/machinery/safety_tether/proc/attempt_teleport(mob/living/M, turf/chasm_turf, oldalpha, oldcolor, oldtransform)

	//sleep(20)

	//Gets a random safe location to teleport the mob to. Here because do_teleport can't run without it
	var/turf/open/Target_Turf = findRandomTurf()
	if(!Target_Turf)
		Target_Turf = get_turf(src)

	if(ismovableatom(M) && istype(chasm_turf, protected_chasm_type) && is_operational() != 0 && do_teleport(M, Target_Turf, channel = TELEPORT_CHANNEL_BLUESPACE))
		log_admin("[M] ([key_name(M)]) was saved by the Safety Tether.")
		INVOKE_ASYNC(src, .proc/bungee_teleport, M, Target_Turf, oldalpha, oldcolor, oldtransform) //Don't hold up the callstack, this can be done separately.
																//Doubles as failsafe in case any runtimes are encountered. Mob won't be clouded.
		return TRUE

	log_admin("[M] ([key_name(M)]) was failed by the Safety Tether and fell into the clouds.")
	return FALSE

/obj/machinery/safety_tether/proc/bungee_teleport(mob/living/M, turf/open/Target_Turf, oldalpha, oldcolor, oldtransform)

	//Give 'em gravity again, was only there to prevent multiple chasm drops
	M.floating = FALSE

	//Fun sound bites as the machine gears up to teleport
	M.density = FALSE //Prevents a very unlikely issue where players can move around an invisible but not-yet-teleported tether victim
	playsound(CENTER_TURF, 'sound/magic/charge.ogg', 100, 1, extrarange = 5)

	//For if the player is teleported to maintenance or wherever else
	if(CENTER_TURF != Target_Turf)
		playsound(M, 'sound/magic/charge.ogg', 100, 1, extrarange = 2)
	sleep(20)
	M.density = initial(M.density)

	use_power(teleport_power_draw)

	M.alpha = oldalpha
	M.color = oldcolor
	M.transform = oldtransform

	//Style points
	playsound(src, 'sound/magic/lightningbolt.ogg', 100, 1, extrarange = 5)

	//For if the player is teleported to maintenance or wherever else
	if(CENTER_TURF != Target_Turf)
		playsound(M, 'sound/magic/lightningbolt.ogg', 100, 1, extrarange = 5)

	// TESLA_MOB_DAMAGE | TESLA_OBJ_DAMAGE  | TESLA_MOB_STUN | TESLA_ALLOW_DUPLICATES
	tesla_zap(CENTER_TURF, 3, teleport_power_draw * tesla_power_ratio, TESLA_MOB_DAMAGE | FALSE  | TESLA_MOB_STUN | FALSE) //Set to zap harmlessly but in a way that looks cool
	tesla_zap(M, 3, 9000, FALSE | FALSE  | TESLA_MOB_STUN | FALSE) //Set to zap harmlessly but in a way that looks cool

	M.spawn_gibs()
	M.emote("scream")

	if(iscarbon(M))

		var/mob/living/carbon/Carbon = M

		to_chat(Carbon, "<span class='italics'>Buzzing static snaps taut on your chest....</span>")

		//Random limb removal
		var/dismember_num = 1

		//Dismember two limbs
		if(prob(dismember_prob))
			dismember_num = 2

		var/dismembered_arm = FALSE
		var/dismembered_leg = FALSE

		var/total_loss = Carbon.health + Carbon.maxHealth //Get the player's current absolute nonnegative health

		for(var/obj/item/bodypart/BP in Carbon.bodyparts)
			if(BP.body_part != CHEST && BP.body_part != HEAD) //I am not ready to find out what happens if your chest is missing
				var/zone = BP.body_zone
				//Checks to ensure that only one arm and one leg each are dismembered, to prevent severe disabling like 2 arms being removed.
				if(zone == BODY_ZONE_L_ARM || zone == BODY_ZONE_R_ARM)
					if(!dismembered_arm)
						dismembered_arm = TRUE
						BP.dismember(BURN)

				if(zone == BODY_ZONE_L_LEG || zone == BODY_ZONE_R_LEG)
					if(!dismembered_leg)
						dismembered_leg = TRUE
						BP.dismember(BURN)

				dismember_num -= 1

				//We've dismembered enough limbs.
				if(dismember_num <= 0)
					break

		//Bleed our pal a little
		M.blood_volume -= BLOOD_VOLUME_NORMAL * M.blood_ratio * bleed_ratio

		src.visible_message("<span class='boldwarning'>[src] spits out [M] and viscera!</span>")

		//Radio in the teleportation
		if(radio && internal_radio)

			//Get the name of the area we teleported the player to
			var/area/A = get_area(Target_Turf)
			var/area_name = A.name
			SPEAKMEDICAL("The safety tether's caught the would-be crater [M] at the [area_name].")

		//Lotsa damage. Enough cloneloss to keep them on the very edge of crit, especially with suffocation
		//Then burn damage to bring them to the -20 health threshold for docs to later stabalize
		Carbon.adjustCloneLoss(rand(cloneloss_min, cloneloss_max)*(Carbon.maxHealth/100))

		total_loss -= Carbon.health + Carbon.maxHealth //Find the total amount of health lost from when damage started to now
		Carbon.adjustFireLoss(Carbon.maxHealth-carbon_final_health*(Carbon.maxHealth/100) - total_loss)

		//Kill the player at a delay, done asynchronously in case we want to apply animations while sleep() call is occuring
		INVOKE_ASYNC(src, .proc/delayed_kill, Carbon)

		//All this ended up causing issues by canting the player 90 degrees due to the player having enforced rest at the time of teleportation
		//animate(M, transform = oldtransform, alpha = oldalpha, color = oldcolor, time = 10)

	else
		if(issilicon(M))
			var/mob/living/silicon/S = M
			to_chat(S, "<span class='italics'>Your circuits spark, slag, and pop as overwhelming white noise crackles and YANKS...</span>")
			S.apply_damage_type(damage = rand(silicon_burn_min, silicon_burn_max), damagetype = BURN)

			src.visible_message("<span class='boldwarning'>[src] spits out [M] and oily, smoking circuits!</span>")

			//Radio in the teleportation
			if(radio && internal_radio)

				//Get the name of the area we teleported the player to
				var/area/A = get_area(Target_Turf)
				var/area_name = A.name
				SPEAKSCIENCE("The safety tether's caught the would-be crater [M] at the [area_name].")

/obj/machinery/safety_tether/proc/delayed_kill(mob/living/carbon/Carbon)
	//Wait just long enough for them to realize their mistake, then kill them.
	sleep(20)
	Carbon.succumb()

	//Thankfully method of application doesn't matter, because otherwise this simple idea would need like, 15 different method calls, including creating a reagent holder for this machine. Chemistry code is a MESS
	Carbon.reagents.add_reagent(/datum/reagent/toxin/formaldehyde, 1)

//Updates machine icon and lighting every time power in the area changes
/obj/machinery/safety_tether/power_change()
	. = ..()

	if(stat & NOPOWER)
		if(radio && internal_radio) //If called while initializing results in a null error.
			SPEAKCOMMON("The Safety Tether's shut down from a lack of power.")
	else
		if(SSticker.HasRoundStarted() && radio && internal_radio)
			SPEAKCOMMON("The Safety Tether is back online.")
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
	<b>Thirdly</b>; Large amounts of electricity are siphoned upon any and every use of the Safety Tether, enough so to arc through the air and <i>hopefully</i> into the grounding rods supplied nearby. The transit of matter near-instantaneously and unplanned to one location from anywhere on the planet is, understandably, enough to drain a fourth of the APCs energy or so when activated.<br><br>

	<i>However</i>, the old engram Layenia works under is faulty <i>at best</i>, resulting in <u><font color=red>blood loss, loss of limbs, painful cellular damages and burns to personnel and cyborgs respectively <font size=1>followed by death via cardiac arrest</font></u></font> when falling into the clouds. Because of this, caution is still highly advised when working on the exterior of Layenia. A radio has been retrofitted to the device to call appropriate medical or scientific services onscene as an added precaution.<br><br>
	Should any more information be needed on the tether, please contact your local sector executive."}

//#undef SPEAK
#undef SPEAKCOMMON
#undef SPEAKMEDICAL
#undef SPEAKSCIENCE
#undef CENTER_TURF