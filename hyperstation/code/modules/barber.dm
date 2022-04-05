/obj/structure/chair/barber_chair
	name = "barbers chair"
	desc = "You sit in this, and your hair shall be cut."
	icon = 'hyperstation/icons/obj/chairs.dmi'
	icon_state = "barber_chair"

//Brush
/obj/item/hairbrush
	name = "hairbrush"
	desc = "A small, circular brush with an ergonomic grip for efficient brush application."
	icon = 'hyperstation/icons/obj/barber.dmi'
	icon_state = "brush"
	//Put lefthand and righthand files here
	w_class = WEIGHT_CLASS_TINY
	var/brush_speed = 3 SECONDS

/obj/item/hairbrush/comb
	name = "comb"
	desc = "A rather simple tool, used to straighten out hair and knots in it."
	icon_state = "blackcomb"

/obj/item/hairbrush/attack(mob/target, mob/user)
	if(target.stat == DEAD)
		to_chat(usr, "<span class='warning'>There isn't much point in brushing someone who can't appreciate it!</span>")
		return
	brush(target, user)
	return COMPONENT_CANCEL_ATTACK_CHAIN

//Brushes someone
/obj/item/hairbrush/proc/brush(mob/living/target, mob/user)
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		var/obj/item/bodypart/head = human_target.get_bodypart(BODY_ZONE_HEAD)

		//Don't brush if you can't reach their head or cancel the action
		if(!head) //No head? No bitches?
			to_chat(usr, "<span class='warning'>[human_target] has no head!</span>")
			return
		if(human_target.is_mouth_covered(head_only = 1))
			to_chat(usr, "<span class='warning'>You can't brush [human_target]'s hair while [human_target.p_their()] head is covered!</span>")
			return
		if(!do_after(user, brush_speed, human_target))
			return

		// Do 1 brute to their head if they're bald. Should've been more careful.
		if(human_target.hair_style == "Bald" || human_target.hair_style == "Skinhead" && is_species(human_target, /datum/species/human)) //It can be assumed most anthros have hair on them!
			human_target.visible_message("<span class='warning'>[usr] scrapes the bristles uncomfortably over [human_target]'s scalp.</span>","<span class='warning'>You scrape the bristles uncomfortably over [human_target]'s scalp.</span>")
			playsound(target, 'hyperstation/sound/misc/bonk.ogg', 100, 1) //Until I fix it
			return

		//Brush their hair
		if(human_target == user)
			human_target.visible_message("<span class='notice'>[usr] brushes [usr.p_their()] hair!</span>","<span class='notice'>You brush your hair.</span>")
			//SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "brushed", /datum/mood/brushed/self)
		else
			user.visible_message("<span class='notice'>[usr] brushes [human_target]'s hair!</span>","<span class='notice'>You brush [human_target]'s hair.</span>")
			//SEND_SIGNAL(human_target, COMISG_ADD_MOOD_EVENT, "brushed", /datum/mood_event/brushed, user)



//fur dyer
/* Gotta port/workaround a lot of things to make do
#define COLOR_MODE_SPECIFIC "Specific Marking"
#define COLOR_MODE_GENERAL "General Color"

/obj/item/fur_dyer
	name = "electric fur dyer"
	desc = "Dye that is capable of recoloring fur in a mostly permanent way."
	icon = 'hyperstation/icons/obj/barber.dmi'
	icon_state = "fur_sprayer"
	w_class = WEIGHT_CLASS_TINY

	var/mode = COLOR_MODE_SPECIFIC

/obj/item/fur_dyer/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/cell)

/obj/item/fur_dyer/attack_self(mob/user, modifiers)
	. = ..()
	if(mode == COLOR_MODE_SPECIFIC)
		mode = COLOR_MODE_GENERAL
	else
		mode = COLOR_MODE_SPECIFIC

	to_chat(user, "Set to [mode]!")

/obj/item/fur_dyer/attack(mob/living/M, mob/living/user, params)
	if(!ishuman(M))
		return ..()

	var/mob/living/carbon/human/target_human = M

	switch(mode)
		if(COLOR_MODE_SPECIFIC)
			dye_marking(target_human, user)
		if(COLOR_MODE_GENERAL)
			dye_general(target_human, user)

/obj/item/fur_dyer/proc/dye_general(mob/living/carbon/human/target_human, mob/living/user)
	var/selected_mutant_color = tgui_alert(user, "Please select which mutant color you'd like to change", "Select Color", list("One", "Two", "Three"))

	if(!selected_mutant_color)
		return

	if(!(item_use_power(power_use_amount, user, TRUE) & COMPONENT_POWER_SUCCESS))
		to_chat(user, "<span class='danger'>A red light blinks!</span>")
		return

	var/selected_color = input(
			user,
			"Select marking color",
			null,
			COLOR_WHITE,
		) as color | null

	if(!selected_color)
		return

	selected_color = sanitize_hexcolor(selected_color)

	visible_message("<span class='notice'>[user] starts to masterfully paint [target_human]!</span>")

	if(do_after(user, 20 SECONDS, target_human))
		switch(selected_mutant_color)
			if("One")
				target_human.dna.features["mcolor"] = selected_color
			if("Two")
				target_human.dna.features["mcolor1"] = selected_color
			if("Three")
				target_human.dna.features["mcolor2"] = selected_color

		target_human.regenerate_icons()
		item_use_power(power_use_amount, user)

		visible_message("<span class='notice'>[user] finishes painting [target_human]!</span>"))

		playsound(src.loc, 'sound/effects/spray2.ogg', 50, TRUE)

/obj/item/fur_dyer/proc/dye_marking(mob/living/carbon/human/target_human, mob/living/user)

	var/list/list/current_markings = target_human.dna.body_markings.Copy()

	if(!current_markings.len)
		to_chat(user, "<span class='warning'>[target_human] has no markings!</span>")
		return

	if(!(item_use_power(power_use_amount, user, TRUE) & COMPONENT_POWER_SUCCESS))
		to_chat(user, "<span class='warning'>A red light blinks!</span>")
		return

	var/selected_marking_area = user.zone_selected

	if(!current_markings[selected_marking_area])
		to_chat(user, "<span class='danger'>[target_human] has no bodymarkings on this limb!</span>")
		return

	var/selected_marking_id = tgui_input_list(user, "Please select which marking you'd like to color!", "Select marking", current_markings[selected_marking_area])

	if(!selected_marking_id)
		return

	var/selected_color = input(
			user,
			"Select marking color",
			null,
			COLOR_WHITE,
		) as color | null

	if(!selected_color)
		return

	selected_color = sanitize_hexcolor(selected_color)

	visible_message("<span class='notice'>[user] starts to masterfully paint [target_human]!</span>")

	if(do_after(user, 20 SECONDS, target_human))
		current_markings[selected_marking_area][selected_marking_id] = selected_color

		target_human.dna.body_markings = current_markings.Copy()

		target_human.regenerate_icons()

		item_use_power(power_use_amount, user)

		visible_message("<span class='notice'>[user] finishes painting [target_human]!</span>")

		playsound(src.loc, 'sound/effects/spray2.ogg', 50, TRUE)
*/
