GLOBAL_LIST_EMPTY(energy_harvesters)

/obj/item/energy_harvester
	desc = "A Device which upon connection to a node, will harvest the energy and send it to engineerless stations in return for credits, derived from a syndicate powersink model. The instructions say to never use more than 2 harvesters at a time."
	name = "Energy Harvesting Module"
	icon_state = "powersink0"
	icon = 'icons/obj/device.dmi'
	item_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	w_class= WEIGHT_CLASS_BULKY
	flags_1 = CONDUCT_1
	throwforce = 1
	throw_speed = 1
	throw_range = 1
	materials = list(MAT_METAL=750)
	var/drain_rate = 10000000
	var/power_drained = 0
	var/obj/structure/cable/attached
	var/datum/looping_sound/generator/soundloop
	var/active = 0
	var/lastprocessed = 0
	var/overloadprog = 0
	var/alerted = FALSE

/obj/item/energy_harvester/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_SCREWDRIVER)
		if(!anchored)
			var/turf/T = loc
			if(isturf(T) && !T.intact)
				attached = locate() in T
				if(!attached)
					to_chat(user, "<span class='warning'>This device must be placed over an exposed, powered cable node!</span>")
				else
					I.play_tool_sound(src)
					START_PROCESSING(SSobj, src)
					GLOB.energy_harvesters += src
					anchored = 1
					density = 1
					user.visible_message( \
						"[user] attaches \the [src] to the cable.", \
						"<span class='notice'>You attach \the [src] to the cable.</span>",
						"<span class='italics'>You hear some wires being connected to something.</span>")
			else
				to_chat(user, "<span class='warning'>This device must be placed over an exposed, powered cable node!</span>")
		else
			I.play_tool_sound(src)
			STOP_PROCESSING(SSobj, src)
			GLOB.energy_harvesters -= src
			soundloop.stop()
			active = 0
			set_light(0)
			anchored = 0
			density = 0
			user.visible_message( \
				"[user] detaches \the [src] from the cable.", \
				"<span class='notice'>You detach \the [src] from the cable.</span>",
				"<span class='italics'>You hear some wires being disconnected from something.</span>")

/obj/item/energy_harvester/process()
	if(!attached || !anchored)
		return PROCESS_KILL
	var/datum/powernet/PN = attached.powernet
	if(PN)
		var/power_avaliable = PN.netexcess
		if(power_avaliable <= 0)
			set_light(1,1,LIGHT_COLOR_ORANGE)
			soundloop.stop()
			active = 0
			return
		set_light(1,1,LIGHT_COLOR_GREEN)
		soundloop.start()
		active = 1
		power_avaliable = min(power_avaliable, drain_rate)
		attached.add_delayedload(power_avaliable)
		lastprocessed = (power_avaliable * 0.00001)
		SSshuttle.points += lastprocessed
		overloadCheck()

/obj/item/energy_harvester/Initialize()
	. = ..()
	new /obj/item/gps/internal/energy_harvester(src)
	soundloop = new(list(src), FALSE)

/obj/item/energy_harvester/Destroy()
	soundloop.stop()
	QDEL_NULL(soundloop)
	active = 0
	set_light(0)
	GLOB.energy_harvesters -= src
	return ..()

/obj/item/energy_harvester/examine(mob/user)
	. = ..()
	if(active)
		. += "<span class='notice'>The [src]'s display states that it is processing approximately <b>[lastprocessed*60]</b> credits per minute.</span>"
	else
		. += "<span class='notice'><b>The [src]'s display is currently offline.</b></span>"

/obj/item/gps/internal/energy_harvester
	gpstag = "Energy Harvester"

/obj/item/energy_harvester/proc/overloadCheck()
	if(LAZYLEN(GLOB.energy_harvesters) > 2)
		switch(overloadprog)
			if(0 to 25)
				if(prob(7))
					do_sparks(7,FALSE,src)
			if(26 to 51)
				if(prob(7))
					src.visible_message("<span class='alert'>[src] starts smoking!</span>")
					shake_animation(0.5)
					do_sparks(7,FALSE,src)
			if(52 to 98)
				if(!alerted)
					src.visible_message("<span class='alert'>[src] is overloading!")
					playsound(src, 'sound/machines/engine_alert2.ogg', 100)
					alerted = TRUE
				if(prob(25))
					shake_animation(1)
					playsound(loc, 'sound/machines/clockcult/steam_whoosh.ogg', 75, TRUE)
					var/turf/T = get_turf(src)
					T.atmos_spawn_air("co2=25;TEMP=300]")
				if(prob(7))
					tesla_zap(src, 5, 1000, TESLA_MOB_DAMAGE | TESLA_OBJ_DAMAGE)
					playsound(src.loc, 'sound/weapons/emitter2.ogg', 100, 1, extrarange = 10)
					take_damage(1) //Just for the sound effect
			if(99 to INFINITY) //Should've read the instructions buddy.
				tesla_zap(src, 20, 25000, TESLA_MOB_DAMAGE | TESLA_OBJ_DAMAGE)
				playsound(src.loc, 'sound/weapons/emitter2.ogg', 100, 1, extrarange = 10)
				atmos_spawn_air("plasma=50;TEMP=1000")
				visible_message("<span class='danger'>[src] violently explodes!</span>")
				explosion(src.loc, 2, 3, 5, 5, 1, 0, 5, 0, 0)
				Destroy()
		overloadprog++
	else
		overloadprog = 0
		alerted = FALSE
