/obj/machinery/fan_assembly
	name = "fan assembly"
	desc = "A basic microfan assembly."
	icon = 'icons/obj/poweredfans.dmi'
	icon_state = "mfan_assembly"
	max_integrity = 150
	use_power = NO_POWER_USE
	power_channel = ENVIRON
	idle_power_usage = 0
	active_power_usage = 0
	max_integrity = 150
	layer = ABOVE_NORMAL_TURF_LAYER
	anchored = FALSE
	density = FALSE
	CanAtmosPass = ATMOS_PASS_YES
	var/state = 1
	var/buildstacktype = /obj/item/stack/sheet/metal
	var/buildstackamount = 10
	/*
			1 = Wrenched in place
			2 = Welded in place
			3 = Wires attached to it
	*/

/obj/machinery/fan_assembly/Initialize(mapload, ndir, building)
	. = ..()
	if(building)
		setDir(ndir)

/obj/machinery/fan_assembly/Destroy()
	return ..()

/obj/machinery/fan_assembly/attackby(obj/item/W, mob/living/user, params)
	switch(state)
		if(1)
			// State 1
			if(istype(W, /obj/item/weldingtool))
				if(weld(W, user))
					to_chat(user, "<span class='notice'>You weld the fan assembly securely into place.</span>")
					setAnchored(TRUE)
					state = 2
					update_icon()
				return
		if(2)
			// State 2
			if(istype(W, /obj/item/stack/cable_coil))
				if(!W.tool_start_check(user, amount=2))
					to_chat(user, "<span class='warning'>You need two lengths of cable to wire the fan assembly!</span>")
					return
				to_chat(user, "<span class='notice'>You start to add wires to the assembly...</span>")
				if(W.use_tool(src, user, 30, volume=50, amount=2))
					to_chat(user, "<span class='notice'>You add wires to the fan assembly.</span>")
					state = 3
					var/obj/machinery/poweredfans/F = new(loc, src)
					forceMove(F)
					F.setDir(src.dir)
					return
			else if(istype(W, /obj/item/weldingtool))
				if(weld(W, user))
					to_chat(user, "<span class='notice'>You unweld the fan assembly from its place.</span>")
					state = 1
					update_icon()
					setAnchored(FALSE)
				return
	return ..()

/obj/machinery/fan_assembly/wrench_act(mob/user, obj/item/I)
	if(state != 1)
		return FALSE
	user.visible_message("<span class='warning'>[user] disassembles [src].</span>",
		"<span class='notice'>You start to disassemble [src]...</span>", "You hear wrenching noises.")
	if(I.use_tool(src, user, 30, volume=50))
		deconstruct()
	return TRUE

/obj/machinery/fan_assembly/proc/weld(obj/item/weldingtool/W, mob/living/user)
	if(!W.tool_start_check(user, amount=0))
		return FALSE
	switch(state)
		if(1)
			to_chat(user, "<span class='notice'>You start to weld \the [src]...</span>")
		if(2)
			to_chat(user, "<span class='notice'>You start to unweld \the [src]...</span>")
	if(W.use_tool(src, user, 30, volume=50))
		return TRUE
	return FALSE

/obj/machinery/fan_assembly/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		new buildstacktype(loc,buildstackamount)
	qdel(src)

/obj/machinery/fan_assembly/examine(mob/user)
	..()
	deconstruction_hints(user)

/obj/machinery/fan_assembly/proc/deconstruction_hints(mob/user)
	switch(state)
		if(1)
			to_chat(user, "<span class='notice'>The fan assembly seems to be <b>unwelded</b> and loose.</span>")
		if(2)
			to_chat(user, "<span class='notice'>The fan assembly seems to be welded, but missing <b>wires</b>.</span>")
		if(3)
			to_chat(user, "<span class='notice'>The outer plating is <b>wired</b> firmly in place.</span>")

/obj/machinery/fan_assembly/update_icon()
	switch(state)
		if(1)
			icon_state = "mfan_assembly"
		if(2)
			icon_state = "mfan_welded"
