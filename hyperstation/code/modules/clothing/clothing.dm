
//Here comes the fetish code.
//This stuff will definitely, absolutely, completely need to be touched up later -Dahl
/obj/item/clothing
	var/recent_struggle = 0
	var/mob/M

/obj/item/clothing/shoes
	var/list/inside_emotes = list()
	var/recent_squish = 0

/obj/item/clothing/shoes/Initialize()
	inside_emotes = list(
		"<font color='red'>You feel weightless for a moment as \the [name] moves upwards.</font>",
		"<font color='red'>\The [name] are a ride you've got no choice but to participate in as the wearer moves.</font>",
		"<font color='red'>The wearer of \the [name] moves, pressing down on you.</font>",
		"<font color='red'>More motion while \the [name] move, feet pressing down against you.</font>"
	)

	..()

/obj/item/clothing/shoes/proc/handle_movement(var/turf/walking, var/running)
	if(prob(1) && !recent_squish)
		recent_squish = 1
		spawn(100)
			recent_squish = 0
		for(var/mob/living/M in contents)
			var/emote = pick(inside_emotes)
			to_chat(M,emote)
	return

/obj/item/clothing/shoes/attackby(var/obj/item/I, var/mob/user)
	if(istype(I,/obj/item/clothing/head/mob_holder/micro))
		var/full = 0
		for(var/mob/M in src)
			full++
		if(full >= 2)
			to_chat(user, "<span class='warning'>You can't fit anyone else into \the [src]!</span>")
		else
			var/obj/item/clothing/head/mob_holder/holder = I
			if(holder.held_mob && (holder.held_mob in holder))
				var/mob/living/M = holder.held_mob
				//holder.dump_mob()
				to_chat(M, "<span class='warning'>[user] stuffs you into \the [src]!</span>")
				M.forceMove(src)
				to_chat(user, "<span class='notice'>You stuff \the [M] into \the [src]!</span>")
	else
		..()

/obj/item/clothing/shoes/assume_air(datum/gas_mixture/env)
	var/atom/location = loc
	if(!loc)
		return //null
	var/turf/T = get_turf(loc)
	while(location != T)
		location = location.loc
		if(ismob(location))
			return location.loc.assume_air(env)
	return location.assume_air(env)

/obj/item/clothing/shoes/remove_air(amount)
	var/atom/location = loc
	if(!loc)
		return //null
	var/turf/T = get_turf(loc)
	while(location != T)
		location = location.loc
		if(ismob(location))
			return location.loc.remove_air(amount)
	return location.remove_air(amount)

/obj/item/clothing/shoes/attack_self(var/mob/user)
	for(var/mob/M in src)
		M.forceMove(get_turf(user))
		to_chat(M, "<span class='warning'>[user] shakes you out of \the [src]!</span>")
		to_chat(user, "<span class='notice'>You shake [M] out of \the [src]!</span>")

	..()

//Couldn't help myself but add this. Might need a balance pass later, depending on how it's inevitably abused
/obj/item/clothing/shoes/MouseDrop(atom/over_object)
	var/mob/living/M = usr
	if(!ishuman(M) || !M.Adjacent(src) || M.incapacitated())
		return FALSE
	if(M.size_multiplier <= 0.25)
		to_chat(M, "<span class='notice'>You crawl into \the [src]!</span>")
		M.forceMove(src)

/obj/item/clothing/shoes/container_resist(mob/living/micro)
	var/mob/living/carbon/human/macro = loc
	if(!istype(macro))
		to_chat(micro, "<span class='notice'>You start to climb out of [src]!</span>")
		if(do_after(micro, 50, src))
			to_chat(micro, "<span class='notice'>You climb out of [src]!</span>")
			micro.forceMove(loc)
		return

	var/escape_message_micro = "You start to climb out of [src]!"
	var/escape_message_macro = "Something is trying to climb out of your [src]!"
	var/escape_time = 60

	if(macro.shoes == src)
		escape_message_micro = "You start to climb around the larger creature's feet and ankles!"
		escape_time = 100

	to_chat(micro, "<span class='notice'>[escape_message_micro]</span>")
	to_chat(macro, "<span class='danger'>[escape_message_macro]</span>")
	if(!do_after(micro, escape_time, macro))
		to_chat(micro, "<span class='danger'>You're pinned underfoot!</span>")
		to_chat(macro, "<span class='danger'>You pin the escapee underfoot!</span>")
		return

	to_chat(micro, "<span class='notice'>You manage to escape [src]!</span>")
	to_chat(macro, "<span class='danger'>Someone has climbed out of your [src]!</span>")
	micro.forceMove(macro.loc)