//Loom, turns raw cotton and durathread into their respective fabrics.

/obj/structure/loom
	name = "loom"
	desc = "A simple device used to weave cloth and other thread-based fabrics together into usable material."
	icon = 'icons/obj/hydroponics/equipment.dmi'
	icon_state = "loom"
	density = TRUE
	anchored = TRUE

/obj/structure/loom/attackby(obj/item/I, mob/user)
	if (user.a_intent != INTENT_HELP)
		return ..()
	if (istype(I, /obj/item/stack/sheet))
		if (!anchored)
			return to_chat(user, "<span class='notice'>You have to anchor [src] first!</span>")

		var/obj/item/stack/sheet/W = I
		if(W.is_fabric && W.amount > 1)
			user.visible_message("<span class='notice'[user] starts weaving [W.name] through the loom.</span>",
								"<span class='notice'>You start weaving the [W.name] through the loom.</span>")

			if(W.use_tool(src, user, W.pull_effort))
				new W.loom_result(drop_location())
				to_chat(user, "<span class='notice'>You weave the [W.name] into a workable fabric.</span>")
				W.amount = (W.amount - 2)
				if(W.amount < 1)
					qdel(W)
		else if(W.is_fabric)
			to_chat("<span class='notice'>You need at least 2 [W.name] to loom into fabric!</span>")
		return
	else
		switch (I.tool_behaviour)
			if (TOOL_SCREWDRIVER)
				user.visible_message("<span class='info'>[user] starts disassembling [src]...</span>",
									"<span class='info'>You start disassembling [src]...</span>")
				I.play_tool_sound(src)
				if(I.use_tool(src, user, 60))
					playsound(src.loc, 'sound/items/deconstruct.ogg', 50, TRUE)
					deconstruct(TRUE)
				return
			if (TOOL_WRENCH)
				if (anchored)
					to_chat(user, "<span class='notice'>You unsecure the [src].</span>")
					I.play_tool_sound(src)
					anchored = FALSE
				else
					to_chat(user, "<span class='notice'>You secure the [src].</span>")
					I.play_tool_sound(src)
					anchored = TRUE
				return
	return ..()

/obj/structure/loom/deconstruct(disassembled = TRUE)
	new /obj/item/stack/sheet/mineral/wood (get_turf(src), 10)
	qdel(src)



/*///Handles the weaving.
/obj/structure/loom/proc/weave(obj/item/stack/sheet/S, mob/user)
	if(!istype(S) || !S.is_fabric)
		return FALSE
	if(!anchored)
		user.show_message("<span class='notice'>The loom needs to be wrenched down.</span>", MSG_VISUAL)
		return FALSE
	if(S.amount < FABRIC_PER_SHEET)
		user.show_message("<span class='notice'>You need at least [FABRIC_PER_SHEET] units of fabric before using this.</span>", 1)
		return FALSE
	user.show_message("<span class='notice'>You start weaving \the [S.name] through the loom..</span>", MSG_VISUAL)
	if(S.use_tool(src, user, S.pull_effort))
		if(S.amount >= FABRIC_PER_SHEET)
			new S.loom_result(drop_location())
			S.use(FABRIC_PER_SHEET)
			user.show_message("<span class='notice'>You weave \the [S.name] into a workable fabric.</span>", MSG_VISUAL)
	return TRUE

/obj/structure/loom/unanchored
	anchored = FALSE

#undef FABRIC_PER_SHEET */
