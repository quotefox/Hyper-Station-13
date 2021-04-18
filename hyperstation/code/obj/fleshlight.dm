//Hyperstation 13 fleshlight
//dont forget to credit us!

/obj/item/fleshlight
	name = "fleshlight"
	desc = "A sex toy disguised as a flashlight, used to stimulate someones penis, complete with colour changing sleeve."
	icon = 'hyperstation/icons/obj/fleshlight.dmi'
	icon_state = "fleshlight_base"
	item_state = "fleshlight"
	w_class = WEIGHT_CLASS_SMALL
	var/sleevecolor = "#ffcbd4" //pink
	price = 12
	var/mutable_appearance/sleeve
	var/inuse = 0

/obj/item/fleshlight/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-Click \the [src.name] to customize it.</span>"

/obj/item/fleshlight/Initialize()
	. = ..()
	sleeve = mutable_appearance('hyperstation/icons/obj/fleshlight.dmi', "vagina")
	sleeve.color = sleevecolor
	add_overlay(sleeve)

/obj/item/fleshlight/AltClick(mob/user)
	. = ..()
	var/style = input(usr, "Choose style", "Customize Fleshlight", "vagina") in list("vagina", "anus")
	var/new_color = input(user, "Choose color.", "Customize Fleshlight", sleevecolor) as color|null
	if(new_color)
		cut_overlays()
		sleeve = mutable_appearance('hyperstation/icons/obj/fleshlight.dmi', style)
		sleevecolor = new_color
		sleeve.color = new_color
		add_overlay(sleeve)
	return TRUE

/obj/item/fleshlight/attack(mob/living/carbon/C, mob/living/user)
	var/obj/item/organ/genital/penis/P = C.getorganslot("penis")
	if(inuse == 1) //just to stop stacking and causing people to cum instantly
		return
	if(P&&P.is_exposed())
		inuse = 1
		if(!(C == user)) //if we are targeting someone else.
			C.visible_message("<span class='userlove'>[user] is trying to use [src] on [C]'s penis.</span>", "<span class='userlove'>[user] is trying to use [src] on your penis.</span>")

		if(!do_mob(user, C, 3 SECONDS)) //3 second delay
			inuse = 0
			return

		//checked if not used on yourself, if not, carry on.
		playsound(src, 'sound/lewd/slaps.ogg', 30, 1, -1) //slapping sound
		inuse = 0
		if(!(C == user)) //lewd flavour text
			C.visible_message("<span class='userlove'>[user] pumps [src] on [C]'s penis.</span>", "<span class='userlove'>[user] pumps [src] up and down on your penis.</span>")
		else
			user.visible_message("<span class='userlove'>[user] pumps [src] on their penis.</span>", "<span class='userlove'>You pump the fleshlight on your penis.</span>")

		if(prob(30)) //30% chance to make them moan.
			C.emote("moan")

		C.do_jitter_animation()
		C.adjustArousalLoss(20) //make the target more aroused.
		if (C.getArousalLoss() >= 100 && ishuman(C) && C.has_dna())
			C.mob_climax(forced_climax=TRUE) //make them cum if they are over the edge.

		return

	else
		to_chat(user, "<span class='notice'>You don't see anywhere to use this on.</span>")

	inuse = 0
	..()