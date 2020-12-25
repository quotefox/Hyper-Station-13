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
		else
			to_chat("<span class='notice'>You need at least 2 [W.name] to loom into fabric!</span>")
	else
		switch (I.tool_behaviour)
			if (TOOL_SCREWDRIVER)
				user.visible_message("<span class='info'>[user] starts disassembling [src]...</span>",
									"<span class='info'>You start disassembling [src]...</span>")
				I.play_tool_sound(src)
				if(I.use_tool(src, user, 60))
					playsound(src.loc, 'sound/items/deconstruct.ogg', 50, TRUE)
					deconstruct(TRUE)
			if (TOOL_WRENCH)
				if (anchored)
					to_chat(user, "<span class='notice'>You unsecure the [src].</span>")
					I.play_tool_sound(src)
					anchored = FALSE
				else
					to_chat(user, "<span class='notice'>You secure the [src].</span>")
					I.play_tool_sound(src)
					anchored = TRUE

/obj/structure/loom/deconstruct(disassembled = TRUE)
	new /obj/item/stack/sheet/mineral/wood (get_turf(src), 10)
	qdel(src)
