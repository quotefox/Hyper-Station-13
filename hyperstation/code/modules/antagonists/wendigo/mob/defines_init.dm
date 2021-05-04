#define DEFAULT_MOVESPEED 1.5
//The mob itself
/mob/living/carbon/wendigo
	name = "wendigo"
	gender = FEMALE
	unique_name = FALSE
	hud_possible = list(HEALTH_HUD,STATUS_HUD,ID_HUD,WANTED_HUD,IMPLOYAL_HUD,IMPCHEM_HUD,IMPTRACK_HUD, NANITE_HUD, DIAG_NANITE_FULL_HUD,ANTAG_HUD,GLAND_HUD,SENTIENT_DISEASE_HUD)
	hud_type = /datum/hud/wendigo
	possible_a_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, INTENT_HARM)
	appearance_flags = TILE_BOUND|PIXEL_SCALE|LONG_GLIDE
	status_flags = CANSTUN		//cant be knocked down, unconscious, or be pushed
	maxHealth = 200
	icon = 'hyperstation/icons/mobs/wendigo.dmi'
	icon_state = "reference"
	
	bodyparts = list(/obj/item/bodypart/chest/wendigo, /obj/item/bodypart/head/wendigo,
					/obj/item/bodypart/l_arm/wendigo, /obj/item/bodypart/r_arm/wendigo,
					/obj/item/bodypart/l_leg/wendigo, /obj/item/bodypart/r_leg/wendigo)
	var/obj/item/belt = null
	var/datum/physiology/physiology
	var/obj/structure/soul_storage/connected_link
	var/fake_breast_size = 5	//She doesn't actually have the organ, but we cache her breast size for rp reasons
	var/fake_penis_size = 8

/mob/living/carbon/wendigo/Initialize()
	. = ..()
	/*		//TODO: Uncomment when objectives + forest get finished
	if(!connected_link)
		if(!GLOB.wendigo_soul_storages.len)
			connected_link = new /obj/structure/soul_storage(get_turf(src))
		else
			connected_link = pick(GLOB.wendigo_soul_storages)
	gender = pick(FEMALE, MALE)
	*/
	if(gender == MALE)
		fake_breast_size = 0
	else
		fake_penis_size = 0
	real_name = name
	//DAMAGE RESISTANCE
	physiology = new()
	physiology.brute_mod = 0.7
	physiology.burn_mod = 1.25
	physiology.tox_mod = -1
	physiology.oxy_mod = 1
	physiology.clone_mod = 0
	physiology.stamina_mod = 0		//Running and attacking, prods
	physiology.heat_mod = 2			//IM MELTIIINNNGGGG-!
	physiology.cold_mod = 0	
	physiology.siemens_coeff = 0.2
	physiology.stun_mod = 0			//prods n aggressive grab
	//physiology.bleed_mod = 2
	physiology.speed_mod = 0.9		//Should be faster than a normal person's walking speed
	physiology.hunger_mod = 2		//We're gonna have a FEAST TONIGHT!
	physiology.do_after_speed = 1

	//Traits & Bodyparts
	create_bodyparts()
	create_internal_organs()
	ADD_TRAIT(src, TRAIT_NOCLONE, "initialize")
	add_verb(src, /mob/living/proc/mob_sleep)
	add_verb(src, /mob/living/proc/lay_down)
	add_movespeed_modifier("MOVESPEED_DEFAULT", multiplicative_slowdown=DEFAULT_MOVESPEED)
	update_body_parts()

/mob/living/carbon/wendigo/Destroy()
	QDEL_NULL(physiology)
	return ..()

/mob/living/carbon/wendigo/update_body_parts()
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		BP.update_limb()

/mob/living/carbon/wendigo/update_move_intent_slowdown()
	var/mod = 0
	if(m_intent == MOVE_INTENT_WALK)
		mod = (CONFIG_GET(number/movedelay/walk_delay) / 2)		//complete copy besides this part
	else
		mod = 1.30
	if(!isnum(mod))
		mod = 1
	add_movespeed_modifier(MOVESPEED_ID_MOB_WALK_RUN_CONFIG_SPEED, TRUE, 100, override = TRUE, multiplicative_slowdown = mod)

/mob/living/carbon/wendigo/update_movespeed(resort=TRUE)
	return (..() * physiology.speed_mod)

/mob/living/carbon/wendigo/can_hold_items()
	return TRUE
/mob/living/carbon/wendigo/IsAdvancedToolUser()
	return TRUE
/mob/living/carbon/wendigo/can_be_pulled()
	return FALSE
/mob/living/carbon/wendigo/is_literate()
	return TRUE
/mob/living/carbon/wendigo/canBeHandcuffed()
	return TRUE
/mob/living/carbon/wendigo/update_inv_handcuffed()
	return
/mob/living/carbon/wendigo/update_inv_legcuffed()
	return

//
//ORGANS
//
/mob/living/carbon/wendigo/create_internal_organs()
	internal_organs += new /obj/item/organ/eyes/wendigo
	internal_organs += new /obj/item/organ/liver/wendigo

	internal_organs += new /obj/item/organ/tongue
	internal_organs += new /obj/item/organ/lungs
	internal_organs += new /obj/item/organ/heart
	internal_organs += new /obj/item/organ/stomach
	internal_organs += new /obj/item/organ/ears
	..()
