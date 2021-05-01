//Xenobio control console
/mob/camera/aiEye/remote/xenobio
	visible_icon = TRUE
	icon = 'icons/obj/abductor.dmi'
	icon_state = "camera_target"
	var/allowed_area = null

/mob/camera/aiEye/remote/xenobio/Initialize()
	var/area/A = get_area(loc)
	allowed_area = A.name
	. = ..()

/mob/camera/aiEye/remote/xenobio/setLoc(var/t)
	var/area/new_area = get_area(t)
	if(new_area && new_area.name == allowed_area || new_area && new_area.xenobiology_compatible)
		return ..()
	else
		return

/obj/machinery/computer/camera_advanced/xenobio
	name = "Slime management console"
	desc = "A computer used for remotely handling slimes."
	networks = list("ss13")
	circuit = /obj/item/circuitboard/computer/xenobiology
	var/datum/action/innate/hotkey_help/hotkey_help

	var/datum/component/redirect/listener

	var/obj/machinery/monkey_recycler/connected_recycler
	var/list/stored_slimes
	var/obj/item/slimepotion/slime/current_potion
	var/max_slimes = 5
	var/monkeys = 0

	icon_screen = "slime_comp"
	icon_keyboard = "rd_key"

	light_color = LIGHT_COLOR_PINK

/obj/machinery/computer/camera_advanced/xenobio/Initialize()
	. = ..()
	hotkey_help = new
	stored_slimes = list()
	listener = AddComponent(/datum/component/redirect, list(COMSIG_ATOM_CONTENTS_DEL = CALLBACK(src, .proc/on_contents_del)))
	for(var/obj/machinery/monkey_recycler/recycler in GLOB.monkey_recyclers)
		if(get_area(src) == get_area(recycler))
			connected_recycler = recycler
			connected_recycler.connected += src

/obj/machinery/computer/camera_advanced/xenobio/Destroy()
	stored_slimes = null
	QDEL_NULL(current_potion)
	for(var/i in contents)
		var/mob/living/simple_animal/slime/S = i
		if(istype(S))
			S.forceMove(drop_location())
	return ..()

/obj/machinery/computer/camera_advanced/xenobio/examine(mob/user)
	. = ..()
	var/thing = "It has "
	if((upgradetier & XENOBIO_UPGRADE_SLIMEADV))
		thing += "an advanced slime upgrade disk "
		if((upgradetier & XENOBIO_UPGRADE_MONKEYS))
			thing += "and a monkey upgrade disk "
	else if((upgradetier & XENOBIO_UPGRADE_SLIMEBASIC))
		thing += "a basic slime upgrade disk "
		if((upgradetier & XENOBIO_UPGRADE_MONKEYS))
			thing += "and a monkey upgrade disk "
	else if((upgradetier & XENOBIO_UPGRADE_MONKEYS))
		thing += "a monkey upgrade disk "
	else
		thing += "no upgrades installed."
		. += thing
		return
	thing += "installed."
	. += thing

/obj/machinery/computer/camera_advanced/xenobio/CreateEye()
	eyeobj = new /mob/camera/aiEye/remote/xenobio(get_turf(src))
	eyeobj.origin = src
	eyeobj.visible_icon = TRUE
	eyeobj.icon = 'icons/obj/abductor.dmi'
	eyeobj.icon_state = "camera_target"

/obj/machinery/computer/camera_advanced/xenobio/GrantActions(mob/living/user)
	..()

	if(hotkey_help)
		hotkey_help.target = src
		hotkey_help.Grant(user)
		actions += hotkey_help

	RegisterSignal(user, COMSIG_XENO_SLIME_CLICK_CTRL, .proc/XenoSlimeClickCtrl)	
	RegisterSignal(user, COMSIG_XENO_SLIME_CLICK_ALT, .proc/XenoSlimeClickAlt)	
	RegisterSignal(user, COMSIG_XENO_SLIME_CLICK_SHIFT, .proc/XenoSlimeClickShift)	
	RegisterSignal(user, COMSIG_XENO_TURF_CLICK_SHIFT, .proc/XenoTurfClickShift)	
	RegisterSignal(user, COMSIG_XENO_TURF_CLICK_CTRL, .proc/XenoTurfClickCtrl)	
	RegisterSignal(user, COMSIG_XENO_MONKEY_CLICK_CTRL, .proc/XenoMonkeyClickCtrl)	

/obj/machinery/computer/camera_advanced/xenobio/remove_eye_control(mob/living/user)
	UnregisterSignal(user, COMSIG_XENO_SLIME_CLICK_CTRL)	
	UnregisterSignal(user, COMSIG_XENO_SLIME_CLICK_ALT)	
	UnregisterSignal(user, COMSIG_XENO_SLIME_CLICK_SHIFT)	
	UnregisterSignal(user, COMSIG_XENO_TURF_CLICK_SHIFT)	
	UnregisterSignal(user, COMSIG_XENO_TURF_CLICK_CTRL)	
	UnregisterSignal(user, COMSIG_XENO_MONKEY_CLICK_CTRL)	
	..() 

/obj/machinery/computer/camera_advanced/xenobio/proc/on_contents_del(atom/deleted)
	if(current_potion == deleted)
		current_potion = null
	if(deleted in stored_slimes)
		stored_slimes -= deleted

/obj/machinery/computer/camera_advanced/xenobio/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/reagent_containers/food/snacks/monkeycube) && (upgradetier & XENOBIO_UPGRADE_MONKEYS)) //CIT CHANGE - makes monkey-related actions require XENOBIO_UPGRADE_MONKEYS
		monkeys++
		to_chat(user, "<span class='notice'>You feed [O] to [src]. It now has [monkeys] monkey cubes stored.</span>")
		qdel(O)
		return
	else if(istype(O, /obj/item/storage/bag) && (upgradetier & XENOBIO_UPGRADE_MONKEYS)) //CIT CHANGE - makes monkey-related actions require XENOBIO_UPGRADE_MONKEYS
		var/obj/item/storage/P = O
		var/loaded = FALSE
		for(var/obj/G in P.contents)
			if(istype(G, /obj/item/reagent_containers/food/snacks/monkeycube))
				loaded = TRUE
				monkeys++
				qdel(G)
		if(loaded)
			to_chat(user, "<span class='notice'>You fill [src] with the monkey cubes stored in [O]. [src] now has [monkeys] monkey cubes stored.</span>")
		return
	else if(istype(O, /obj/item/slimepotion/slime)  && (upgradetier & XENOBIO_UPGRADE_SLIMEADV)) // CIT CHANGE - makes giving slimes potions via console require XENOBIO_UPGRADE_SLIMEADV
		var/replaced = FALSE
		if(user && !user.transferItemToLoc(O, src))
			return
		if(!QDELETED(current_potion))
			current_potion.forceMove(drop_location())
			replaced = TRUE
		current_potion = O
		to_chat(user, "<span class='notice'>You load [O] in the console's potion slot[replaced ? ", replacing the one that was there before" : ""].</span>")
		return
	else if(istype(O, /obj/item/multitool))
		var/obj/item/multitool/M = O
		if(istype(M.buffer))
			to_chat(user, "<span class='notice'>You link [src] with [M.buffer] in [M] buffer.</span>")
			connected_recycler = M.buffer
			connected_recycler += src
			return
		else
			to_chat(user, "<span class='warning'>[M] has no buffer.</span>")
			return
	..()

/datum/action/innate/hotkey_help
	name = "Hotkey Help"
	icon_icon = 'icons/mob/actions/actions_silicon.dmi'
	button_icon_state = "hotkey_help"

/datum/action/innate/hotkey_help/Activate()
	if(!target || !isliving(owner))
		return
	to_chat(owner, "<b>Click shortcuts:</b>")
	to_chat(owner, "Shift-click a slime to pick it up, or the floor to drop all held slimes.")
	to_chat(owner, "Ctrl-click a slime to scan it.")
	to_chat(owner, "Alt-click a slime to feed it a potion.")
	to_chat(owner, "Ctrl-click on a dead monkey to recycle it, or the floor to place a new monkey.")

//
// Alternate clicks for slime, monkey and open turf if using a xenobio console

//Picks up slime
/mob/living/simple_animal/slime/ShiftClick(mob/user)
	SEND_SIGNAL(user, COMSIG_XENO_SLIME_CLICK_SHIFT, src)
	..()

//Place slimes
/turf/open/ShiftClick(mob/user)
	SEND_SIGNAL(user, COMSIG_XENO_TURF_CLICK_SHIFT, src)
	..()

//Place monkey
/turf/open/CtrlClick(mob/user)
	SEND_SIGNAL(user, COMSIG_XENO_TURF_CLICK_CTRL, src)
	..()

//Pick up monkey
/mob/living/carbon/monkey/CtrlClick(mob/user)
	SEND_SIGNAL(user, COMSIG_XENO_MONKEY_CLICK_CTRL, src)
	..()

// Scans slime
/mob/living/simple_animal/slime/CtrlClick(mob/user)
	SEND_SIGNAL(user, COMSIG_XENO_SLIME_CLICK_CTRL, src)
	..()

//Feeds a potion to slime
/mob/living/simple_animal/slime/AltClick(mob/user)
	SEND_SIGNAL(user, COMSIG_XENO_SLIME_CLICK_ALT, src)
	..()

//Picks up slime
/obj/machinery/computer/camera_advanced/xenobio/proc/XenoSlimeClickShift(mob/living/user, mob/living/simple_animal/slime/S)
	if(!(upgradetier & XENOBIO_UPGRADE_SLIMEBASIC))
		return
	if(!GLOB.cameranet.checkTurfVis(S.loc))
		to_chat(user, "<span class='warning'>Target is not near a camera. Cannot proceed.</span>")
		return
	var/area/mobarea = get_area(S.loc)
	var/mob/camera/aiEye/remote/xenobio/X = eyeobj
	if(mobarea.name == X.allowed_area || mobarea.xenobiology_compatible)
		if(stored_slimes.len >= max_slimes)
			to_chat(user, "<span class='warning'>Slime storage is full.</span>")
			return
		if(S.ckey)
			to_chat(user, "<span class='warning'>The slime wiggled free!</span>")
			return
		if(S.buckled)
			S.Feedstop(silent = TRUE)
		S.visible_message("[S] vanishes in a flash of light!")
		S.forceMove(src)
		stored_slimes += S

//Place slimes
/obj/machinery/computer/camera_advanced/xenobio/proc/XenoTurfClickShift(mob/living/user, turf/open/T)
	if(!(upgradetier & XENOBIO_UPGRADE_SLIMEBASIC))
		return
	if(!GLOB.cameranet.checkTurfVis(T))
		to_chat(user, "<span class='warning'>Target is not near a camera. Cannot proceed.</span>")
		return
	var/area/turfarea = get_area(T)
	var/mob/camera/aiEye/remote/xenobio/X = eyeobj
	if(turfarea.name == X.allowed_area || turfarea.xenobiology_compatible)
		for(var/mob/living/simple_animal/slime/S in stored_slimes)
			S.forceMove(T)
			S.visible_message("[S] warps in!")
			stored_slimes -= S

//Place monkey
/obj/machinery/computer/camera_advanced/xenobio/proc/XenoTurfClickCtrl(mob/living/user, turf/open/T)
	if(!(upgradetier & XENOBIO_UPGRADE_MONKEYS))
		return
	if(!GLOB.cameranet.checkTurfVis(T))
		to_chat(user, "<span class='warning'>Target is not near a camera. Cannot proceed.</span>")
		return
	var/area/turfarea = get_area(T)
	var/mob/camera/aiEye/remote/xenobio/X = eyeobj
	if(turfarea.name == X.allowed_area || turfarea.xenobiology_compatible)
		if(monkeys >= 1)
			var/mob/living/carbon/monkey/food = new/mob/living/carbon/monkey(T, TRUE, user)
			if(!QDELETED(food))
				food.LAssailant = user
				monkeys = round(monkeys-1, 0.1)
				to_chat(user, "[src] now has [monkeys] monkeys stored.")

//Pick up monkey
/obj/machinery/computer/camera_advanced/xenobio/proc/XenoMonkeyClickCtrl(mob/living/user, mob/living/carbon/monkey/M)
	if(!(upgradetier & XENOBIO_UPGRADE_MONKEYS))
		return
	if(!connected_recycler)
		to_chat(user, "<span class='notice'>There is no connected monkey recycler. You can connect one with a multitool.</span>")
		return
	if(!GLOB.cameranet.checkTurfVis(M.loc))
		to_chat(user, "<span class='warning'>Target is not near a camera. Cannot proceed.</span>")
		return
	var/area/mobarea = get_area(M.loc)
	var/mob/camera/aiEye/remote/xenobio/X = eyeobj
	if(mobarea.name == X.allowed_area || mobarea.xenobiology_compatible)
		if(!M.stat)
			return
		M.visible_message("[M] vanishes as [M.p_theyre()] reclaimed for recycling!")
		connected_recycler.use_power(500)
		monkeys += connected_recycler.cube_production
		to_chat(user, "[src] now has [monkeys] monkeys available.")
		qdel(M)

// Scans slime
/obj/machinery/computer/camera_advanced/xenobio/proc/XenoSlimeClickCtrl(mob/living/user, mob/living/simple_animal/slime/S)
	if(!GLOB.cameranet.checkTurfVis(S.loc))
		to_chat(user, "<span class='warning'>Target is not near a camera. Cannot proceed.</span>")
		return
	var/area/mobarea = get_area(S.loc)
	var/mob/camera/aiEye/remote/xenobio/X = eyeobj
	if(mobarea.name == X.allowed_area || mobarea.xenobiology_compatible)
		slime_scan(S, user)

//Feeds a potion to slime
/obj/machinery/computer/camera_advanced/xenobio/proc/XenoSlimeClickAlt(mob/living/user, mob/living/simple_animal/slime/S)
	if(!(upgradetier & XENOBIO_UPGRADE_SLIMEBASIC))
		return
	if(!GLOB.cameranet.checkTurfVis(S.loc))
		to_chat(user, "<span class='warning'>Target is not near a camera. Cannot proceed.</span>")
		return
	var/area/mobarea = get_area(S.loc)
	if(QDELETED(current_potion))
		to_chat(user, "<span class='warning'>No potion loaded.</span>")
		return
	var/mob/camera/aiEye/remote/xenobio/X = eyeobj
	if(mobarea.name == X.allowed_area || mobarea.xenobiology_compatible)
		current_potion.attack(S, user)
