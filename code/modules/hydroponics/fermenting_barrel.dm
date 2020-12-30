/obj/structure/fermenting_barrel
	name = "wooden barrel"
	desc = "A large wooden barrel. You can ferment fruits and such inside it, or just use it to hold liquid."
	icon = 'icons/obj/objects.dmi'
	icon_state = "barrel"
	density = TRUE
	anchored = FALSE
	pressure_resistance = 2 * ONE_ATMOSPHERE
	max_integrity = 300
	var/open = FALSE
	var/speed_multiplier = 1 //How fast it distills. Defaults to 100% (1.0). Lower is better.

/obj/structure/fermenting_barrel/Initialize()
	create_reagents(300, DRAINABLE | AMOUNT_VISIBLE) //Bluespace beakers, but without the portability or efficiency in circuits.
	. = ..()

/obj/structure/fermenting_barrel/examine(mob/user)
	. = ..()
	. += "<span class='notice'>It is currently [open?"open, letting you pour liquids in.":"closed, letting you draw liquids from the tap."]</span>"

/obj/structure/fermenting_barrel/proc/makeWine(obj/item/reagent_containers/food/snacks/grown/fruit)
	if(fruit.reagents)
		fruit.reagents.trans_to(src, fruit.reagents.total_volume)
	var/amount = fruit.seed.potency / 4
	if(fruit.distill_reagent)
		reagents.add_reagent(fruit.distill_reagent, amount)
	else
		var/data = list()
		data["names"] = list("[initial(fruit.name)]" = 1)
		data["color"] = fruit.filling_color
		data["boozepwr"] = fruit.wine_power
		if(fruit.wine_flavor)
			data["tastes"] = list(fruit.wine_flavor = 1)
		else
			data["tastes"] = list(fruit.tastes[1] = 1)
		reagents.add_reagent(/datum/reagent/consumable/ethanol/fruit_wine, amount, data)
	qdel(fruit)
	playsound(src, 'sound/effects/bubbles.ogg', 50, TRUE)

/obj/structure/fermenting_barrel/attackby(obj/item/I, mob/user, params)
	if (user.a_intent != INTENT_HELP)
		return ..()
	if (istype(I, /obj/item/reagent_containers/food/snacks/grown))
		var/obj/item/reagent_containers/food/snacks/grown/fruit = I
		if(!fruit.can_distill)
			to_chat(user, "<span class='warning'>You can't distill this into anything...</span>")
			return TRUE
		else if(!user.transferItemToLoc(I,src))
			to_chat(user, "<span class='warning'>[I] is stuck to your hand!</span>")
			return TRUE
		to_chat(user, "<span class='notice'>You place [I] into [src] to start the fermentation process.</span>")
		addtimer(CALLBACK(src, .proc/makeWine, fruit), rand(80, 120) * speed_multiplier)
		return TRUE
	else
		switch (I.tool_behaviour)
			if (TOOL_SCREWDRIVER)
				user.visible_message("<span class='info'>[user] starts disassembling [src]...</span>",
									"<span class='info'>You start disassembling [src]...</span>")
				var/reagent_calculation = 1
				if (reagents.total_volume)
					user.visible_message("<span class='warning'>Liquid starts pouring out [src] as [user] starts disassembling it!</span>",
									"<span class='warning'>Liquid starts pouring out [src], maybe you should think about this...</span>")
					reagent_calculation += 2+round(reagents.total_volume/100)/2
				I.play_tool_sound(src)
				if(I.use_tool(src, user, 30*reagent_calculation))
					playsound(src.loc, 'sound/items/deconstruct.ogg', 50, TRUE)
					if (reagents.total_volume)
						chem_splash(loc, round(reagent_calculation*0.75), list(reagents))
					deconstruct(TRUE)
				else if (reagents.total_volume)
					visible_message("<span class='info'>[user] stops disassembling [src].</span>")
			if (TOOL_WRENCH)
				if (anchored)	//Imaginary bolts on the ground, just like anything else that can get wrenched
					to_chat(user, "<span class='notice'>You unsecure [src].</span>")
					I.play_tool_sound(src)
					anchored = FALSE
				else
					to_chat(user, "<span class='notice'>You secure [src].</span>")
					I.play_tool_sound(src)
					anchored = TRUE

/obj/structure/fermenting_barrel/attack_hand(mob/user)
	open = !open
	if(open)
		DISABLE_BITFIELD(reagents.reagents_holder_flags, DRAINABLE)
		ENABLE_BITFIELD(reagents.reagents_holder_flags, REFILLABLE)
		to_chat(user, "<span class='notice'>You open [src], letting you fill it.</span>")
	else
		DISABLE_BITFIELD(reagents.reagents_holder_flags, REFILLABLE)
		ENABLE_BITFIELD(reagents.reagents_holder_flags, DRAINABLE)
		to_chat(user, "<span class='notice'>You close [src], letting you draw from its tap.</span>")
	update_icon()

/obj/structure/fermenting_barrel/update_icon()
	if(open)
		icon_state = "barrel_open"
	else
		icon_state = "barrel"

/obj/structure/fermenting_barrel/deconstruct(disassembled = TRUE)
	new /obj/item/stack/sheet/mineral/wood (get_turf(src), 10)
	qdel(src)
