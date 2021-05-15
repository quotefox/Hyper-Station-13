/obj/machinery/power/generator
	name = "thermoelectric generator"
	desc = "It's a high efficiency thermoelectric generator."
	icon_state = "teg"
	density = TRUE
	use_power = NO_POWER_USE

	var/obj/machinery/atmospherics/components/binary/circulator/cold_circ
	var/obj/machinery/atmospherics/components/binary/circulator/hot_circ

	var/lastgen = 0
	var/lastgenlev = -1
	var/lastcirc = "00"
	var/overloaded = 0
	var/running = 0
	var/boost = 0
	var/grump = 0 // best var 2013
	var/grumping = 0 // is the engine currently doing grumpy things
	var/list/grump_prefix = list("an upsetting", "an unsettling",
	"a scary", "a loud", "a sassy", "a grouchy", "a grumpy",
	"an awful", "a horrible", "a despicable", "a pretty rad", "a godawful, a wocky")
	var/list/grump_suffix = list("noise", "racket", "ruckus", "sound", "clatter", "fracas", "hubbub, slush")
	var/sound_engine1 = 'sound/machines/tractor_running.ogg'
	var/sound_engine2 = 'sound/machines/engine_highpower.ogg'
	var/sound_tractorrev = 'sound/machines/tractorrev.ogg'
	var/sound_engine_alert1 = 'sound/machines/engine_alert1.ogg'
	var/sound_engine_alert2 = 'sound/machines/engine_alert2.ogg'
	var/sound_engine_alert3 = 'sound/machines/engine_alert3.ogg'
	var/sound_bigzap = 'sound/effects/elec_bigzap.ogg'
	var/sound_bellalert = 'sound/machines/bellalert.ogg'
	var/sound_warningbuzzer = 'sound/machines/warning-buzzer.ogg'
	var/list/sounds_engine = list(sound('sound/machines/tractor_running2.ogg'),sound('sound/machines/tractor_running3.ogg'))
	var/list/sounds_enginegrump = list(sound('sound/machines/engine_grump1.ogg'),sound('sound/machines/engine_grump2.ogg'),sound('sound/machines/engine_grump3.ogg'),sound('sound/machines/engine_grump4.ogg'))

/obj/machinery/power/generator/Initialize(mapload)
	. = ..()
	find_circs()
	connect_to_network()
	SSair.atmos_machinery += src
	update_icon()
	component_parts = list(new /obj/item/circuitboard/machine/generator)

/obj/machinery/power/generator/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/simple_rotation,ROTATION_ALTCLICK | ROTATION_CLOCKWISE | ROTATION_COUNTERCLOCKWISE | ROTATION_VERBS )

/obj/machinery/power/generator/Destroy()
	kill_circs()
	SSair.atmos_machinery -= src
	return ..()

/obj/machinery/power/generator/update_icon()

	if(stat & (NOPOWER|BROKEN))
		cut_overlays()
	else
		cut_overlays()

		var/L = min(round(lastgenlev/100000),11)
		if(L != 0)
			add_overlay(image('icons/obj/power.dmi', "teg-op[L]"))

		if(hot_circ && cold_circ)
			add_overlay("teg-oc[lastcirc]")


#define GENRATE 800		// generator output coefficient from Q

/obj/machinery/power/generator/process_atmos()

	if(!cold_circ || !hot_circ)
		return

	if(powernet)
		var/datum/gas_mixture/cold_air = cold_circ.return_transfer_air()
		var/datum/gas_mixture/hot_air = hot_circ.return_transfer_air()

		if(cold_air && hot_air)

			var/cold_air_heat_capacity = cold_air.heat_capacity()
			var/hot_air_heat_capacity = hot_air.heat_capacity()

			var/delta_temperature = hot_air.temperature - cold_air.temperature


			if(delta_temperature > 0 && cold_air_heat_capacity > 0 && hot_air_heat_capacity > 0)
				var/efficiency = 0.45

				var/energy_transfer = delta_temperature*hot_air_heat_capacity*cold_air_heat_capacity/(hot_air_heat_capacity+cold_air_heat_capacity)

				var/heat = energy_transfer*(1-efficiency)
				if(delta_temperature < 16800) // second point where derivative of below function = 1
					lastgen += LOGISTIC_FUNCTION(500000,0.0009,delta_temperature,10000)
				else
					lastgen += delta_temperature + 482102 // value of above function at 16800, or very nearly so

				hot_air.temperature = hot_air.temperature - energy_transfer/hot_air_heat_capacity
				cold_air.temperature = cold_air.temperature + heat/cold_air_heat_capacity

				//add_avail(lastgen) This is done in process now
		// update icon overlays only if displayed level has changed

		if(hot_air)
			var/datum/gas_mixture/hot_circ_air1 = hot_circ.airs[1]
			hot_circ_air1.merge(hot_air)

		if(cold_air)
			var/datum/gas_mixture/cold_circ_air1 = cold_circ.airs[1]
			cold_circ_air1.merge(cold_air)

		update_icon()

	var/circ = "[cold_circ && cold_circ.last_pressure_delta > 0 ? "1" : "0"][hot_circ && hot_circ.last_pressure_delta > 0 ? "1" : "0"]"
	if(circ != lastcirc)
		lastcirc = circ
		update_icon()

	src.updateDialog()

/obj/machinery/power/generator/process()
	//Setting this number higher just makes the change in power output slower, it doesnt actualy reduce power output cause **math**
	var/power_output = round(lastgen / 10)
	add_avail(power_output)
	lastgenlev = power_output
	lastgen -= power_output
	if (lastgenlev > 0)
		if(grump < 0) // grumpcode
			grump = 0 // no negative grump plz
		grump++ // get grump'd
		if(grump >= 100 && prob(5))
			playsound(src.loc, pick(sounds_enginegrump), 70, 0)
			src.visible_message("<span class='alert'>[src] makes [pick(grump_prefix)] [pick(grump_suffix)]!</span>")
			grump -= 5
		if(!running)
			playsound(src.loc, sound_tractorrev, 55, 0)
			running = 1
	else
		running = 0
	var/genlev = (lastgenlev/1000000)
	switch(genlev)
		if(0)
			return
		if(0.2 to 1)
			playsound(src.loc, sound_engine1, 60, 0)
			if(prob(5))
				playsound(src.loc, pick(sounds_engine), 70, 0)
		if(1 to 10)
			playsound(src.loc, sound_engine1, 60, 0)
		if(11 to 100)
			playsound(src.loc, sound_engine2, 60, 0)
		if(101 to 500)
			playsound(src.loc, sound_bellalert, 60, 0)
			if(prob(5))
				do_sparks(5,FALSE,src)
		if(501 to 1000)
			playsound(src.loc, sound_warningbuzzer, 50, 0)
			if (prob(5))
				src.visible_message("<span class='alert'>[src] starts smoking!</span>")
			if (!grumping && grump >= 100 && prob(5))
				grumping = 1
				playsound(src.loc, "sound/machines/engine_grump1.ogg", 50, 0)
				grumping = 0
				grump -= 10
		if(1001 to 5000)
			if (prob(5))
				playsound(src.loc, sound_engine_alert1, 55, 0)
			if (prob(5)) 
				playsound(src.loc, 'sound/weapons/emitter2.ogg', 100, 1, extrarange = 10)
				zapStuff(src, 5, min(genlev, 20000))
			if (!grumping && grump >= 100 && prob(5))
				grumping = 1
				playsound(src.loc, "sound/machines/engine_grump1.ogg", 50, 0)
				grumping = 0
				grump -= 30

		if(5001 to 10000)
			if (prob(15))
				playsound(src.loc, sound_engine_alert2, 55, 0)
			if (prob(10)) // lowering a bit more
				playsound(src.loc, 'sound/weapons/emitter2.ogg', 100, 1, extrarange = 10)
				zapStuff(src, 5, min(genlev, 20000))
			if (prob(5))
				src.visible_message("<span class='alert'>[src] starts smoking!</span>")
			if (!grumping && grump >= 100 && prob(10)) // probably not good if this happens several times in a row
				grumping = 1
				playsound(src.loc, "sound/weapons/rocket.ogg", 50, 0)
				var/firesize = rand(1,4)
				for(var/atom/movable/M in view(firesize, src.loc)) // fuck up those jerkbag engineers
					if(M.anchored) continue
					if(ismob(M))
						var/mob/living/L = M
						L.adjustBruteLoss(10)
					if(ismob(M))
						var/atom/targetTurf = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
						M.throw_at(targetTurf, 200, 4)
					else if (prob(15)) // cut down the number of other junk things that get blown around
						var/atom/targetTurf = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
						M.throw_at(targetTurf, 200, 4)
				grumping = 0
				grump -= 30
		if(10001 to INFINITY)
			playsound(src.loc, sound_engine_alert3, 55, 0)
			if(!grumping && grump >= 100 && prob(6))
				grumping = 1
				src.visible_message("<span class='alert'><b>[src] [pick("resonates", "shakes", "rumbles", "grumbles", "vibrates", "roars")] [pick("dangerously", "strangely", "ominously", "frighteningly", "grumpily")]!</b></span>")
				playsound(src.loc, "sound/effects/explosionfar.ogg", 65, 1)
				for (var/obj/structure/window/W in range(6, src.loc)) // smash nearby windows
					if (W.max_integrity >= 80) // plasma glass or better, no break please and thank you
						continue
					if (prob(get_dist(W,src.loc)*6))
						continue
					W.deconstruct(FALSE)
				for (var/mob/living/M in range(6, src.loc))
					shake_camera(M, 3, 16)
				grumping = 0
				grump -= 30
			if (prob(33)) // lowered because all the DEL procs related to zap are stacking up in the profiler
				if(prob(5))
					playsound(src.loc, sound_bigzap, 100, 1, extrarange = 10)
					zapStuff(src, 5, min(genlev, 30000)) //BIG ZAP
				else
					playsound(src.loc, 'sound/weapons/emitter2.ogg', 100, 1, extrarange = 10)
					zapStuff(src, 5, min(genlev, 20000))
			if(prob(5))
				src.visible_message("<span class='alert'>[src] [pick("rumbles", "groans", "shudders", "grustles", "hums", "thrums")] [pick("ominously", "oddly", "strangely", "oddly", "worringly", "softly", "loudly")]!</span>")
			else if (prob(2))
				src.visible_message("<span class='alert'><b>[src] hungers!</b></span>")
	..()

/obj/machinery/power/generator/proc/get_menu(include_link = TRUE)
	var/t = ""
	if(!powernet)
		t += "<span class='bad'>Unable to connect to the power network!</span>"
	else if(cold_circ && hot_circ)
		var/datum/gas_mixture/cold_circ_air1 = cold_circ.airs[1]
		var/datum/gas_mixture/cold_circ_air2 = cold_circ.airs[2]
		var/datum/gas_mixture/hot_circ_air1 = hot_circ.airs[1]
		var/datum/gas_mixture/hot_circ_air2 = hot_circ.airs[2]

		t += "<div class='statusDisplay'>"

		t += "Output: [DisplayPower(lastgenlev)]"

		t += "<BR>"

		t += "<B><font color='blue'>Cold loop</font></B><BR>"
		t += "Temperature Inlet: [round(cold_circ_air2.temperature, 0.1)] K / Outlet: [round(cold_circ_air1.temperature, 0.1)] K<BR>"
		t += "Pressure Inlet: [round(cold_circ_air2.return_pressure(), 0.1)] kPa /  Outlet: [round(cold_circ_air1.return_pressure(), 0.1)] kPa<BR>"

		t += "<B><font color='red'>Hot loop</font></B><BR>"
		t += "Temperature Inlet: [round(hot_circ_air2.temperature, 0.1)] K / Outlet: [round(hot_circ_air1.temperature, 0.1)] K<BR>"
		t += "Pressure Inlet: [round(hot_circ_air2.return_pressure(), 0.1)] kPa / Outlet: [round(hot_circ_air1.return_pressure(), 0.1)] kPa<BR>"

		t += "</div>"
	else if(!hot_circ && cold_circ)
		t += "<span class='bad'>Unable to locate hot circulator!</span>"
	else if(hot_circ && !cold_circ)
		t += "<span class='bad'>Unable to locate cold circulator!</span>"
	else
		t += "<span class='bad'>Unable to locate any parts!</span>"
	if(include_link)
		t += "<BR><A href='?src=[REF(src)];close=1'>Close</A>"

	return t

/obj/machinery/power/generator/ui_interact(mob/user)
	. = ..()
	var/datum/browser/popup = new(user, "teg", "Thermo-Electric Generator", 460, 300)
	popup.set_content(get_menu())
	popup.set_title_image(user.browse_rsc_icon(src.icon, src.icon_state))
	popup.open()

/obj/machinery/power/generator/Topic(href, href_list)
	if(..())
		return
	if( href_list["close"] )
		usr << browse(null, "window=teg")
		usr.unset_machine()
		return FALSE
	return TRUE


/obj/machinery/power/generator/power_change()
	..()
	update_icon()

/obj/machinery/power/generator/proc/find_circs()
	kill_circs()
	var/list/circs = list()
	var/obj/machinery/atmospherics/components/binary/circulator/C
	var/circpath = /obj/machinery/atmospherics/components/binary/circulator
	if(dir == NORTH || dir == SOUTH)
		C = locate(circpath) in get_step(src, EAST)
		if(C && C.dir == WEST)
			circs += C

		C = locate(circpath) in get_step(src, WEST)
		if(C && C.dir == EAST)
			circs += C

	else
		C = locate(circpath) in get_step(src, NORTH)
		if(C && C.dir == SOUTH)
			circs += C

		C = locate(circpath) in get_step(src, SOUTH)
		if(C && C.dir == NORTH)
			circs += C

	if(circs.len)
		for(C in circs)
			if(C.mode == CIRCULATOR_COLD && !cold_circ)
				cold_circ = C
				C.generator = src
			else if(C.mode == CIRCULATOR_HOT && !hot_circ)
				hot_circ = C
				C.generator = src

/obj/machinery/power/generator/wrench_act(mob/living/user, obj/item/I)
	if(!panel_open)
		return
	anchored = !anchored
	I.play_tool_sound(src)
	if(!anchored)
		kill_circs()
	connect_to_network()
	to_chat(user, "<span class='notice'>You [anchored?"secure":"unsecure"] [src].</span>")
	return TRUE

/obj/machinery/power/generator/multitool_act(mob/living/user, obj/item/I)
	if(!anchored)
		return
	find_circs()
	to_chat(user, "<span class='notice'>You update [src]'s circulator links.</span>")
	return TRUE

/obj/machinery/power/generator/screwdriver_act(mob/user, obj/item/I)
	if(..())
		return TRUE
	panel_open = !panel_open
	I.play_tool_sound(src)
	to_chat(user, "<span class='notice'>You [panel_open?"open":"close"] the panel on [src].</span>")
	return TRUE

/obj/machinery/power/generator/crowbar_act(mob/user, obj/item/I)
	default_deconstruction_crowbar(I)
	return TRUE

/obj/machinery/power/generator/on_deconstruction()
	kill_circs()

/obj/machinery/power/generator/proc/kill_circs()
	if(hot_circ)
		hot_circ.generator = null
		hot_circ = null
	if(cold_circ)
		cold_circ.generator = null
		cold_circ = null

/obj/machinery/power/generator/proc/zapStuff(atom/zapstart, range = 3, power)
	. = zapstart.dir
	if(power < 1000)
		return

	var/target_atom
	var/mob/living/target_mob
	var/obj/machinery/target_machine
	var/obj/structure/target_structure
	var/list/arctargetsmob = list()
	var/list/arctargetsmachine = list()
	var/list/arctargetsstructure = list()

	if(prob(20)) //let's not hit all the engineers with every beam and/or segment of the arc
		for(var/mob/living/Z in oview(zapstart, range+2))
			arctargetsmob += Z
	if(arctargetsmob.len)
		var/mob/living/H = pick(arctargetsmob)
		var/atom/A = H
		target_mob = H
		target_atom = A

	else
		for(var/obj/machinery/X in oview(zapstart, range+2))
			arctargetsmachine += X
		if(arctargetsmachine.len)
			var/obj/machinery/M = pick(arctargetsmachine)
			var/atom/A = M
			target_machine = M
			target_atom = A

		else
			for(var/obj/structure/Y in oview(zapstart, range+2))
				arctargetsstructure += Y
			if(arctargetsstructure.len)
				var/obj/structure/O = pick(arctargetsstructure)
				var/atom/A = O
				target_structure = O
				target_atom = A

	if(target_atom)
		zapstart.Beam(target_atom, icon_state="nzcrentrs_power", time=5)
		var/zapdir = get_dir(zapstart, target_atom)
		if(zapdir)
			. = zapdir

	if(target_mob)
		target_mob.electrocute_act(rand(5,10), "Discharge Bolt", 1, stun = 0)
		if(prob(15))
			zapStuff(target_mob, 5, power / 2)
			zapStuff(target_mob, 5, power / 2)
		else
			zapStuff(target_mob, 5, power / 1.5)

	else if(target_machine)
		if(prob(15))
			zapStuff(target_machine, 5, power / 2)
			zapStuff(target_machine, 5, power / 2)
		else
			zapStuff(target_machine, 5, power / 1.5)

	else if(target_structure)
		if(prob(15))
			zapStuff(target_structure, 5, power / 2)
			zapStuff(target_structure, 5, power / 2)
		else
			zapStuff(target_structure, 5, power / 1.5)
