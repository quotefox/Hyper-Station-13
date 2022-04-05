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

