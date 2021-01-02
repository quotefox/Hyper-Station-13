//Hyperstation Arousal hud
//This needs alot of attention, im a bad coder. a shitty attempt at making a more user friendly/modern hud
//if you wanna use this on your own server go ahead, but alittle credit would always be nice! -quotefox
//This still uses alot of cits arousal system!

/obj/screen/arousal/ui_interact(mob/user)
	. = ..()
	var/dat	=	{"<B>Genitals</B><BR><HR>"}

	//List genitals
	var/obj/item/organ/genital/penis/P = user.getorganslot("penis")
	if (P) //they have a pp
		dat	+= "<a href='byond://?src=[REF(src)];hidepenis=1'>[P.mode == "hidden" ? "Penis <font color='red'>(Hidden)</font>" : (P.mode == "clothes" ? "Penis <font color='yellow'>(Hidden by Clothes)</font>" : (P.mode == "visable" ? "Penis <font color='green'>(Visable)</font>" : "Penis <font color='green'>(Visable)</font>"))]</a><BR>"

	var/obj/item/organ/genital/testicles/T = user.getorganslot("testicles")
	if (T) //they have teabags
		if(!T.internal)
			dat	+= "<a href='byond://?src=[REF(src)];hidetesticles=1'>[T.mode == "hidden" ? "Testicles <font color='red'>(Hidden)</font>" : (T.mode == "clothes" ? "Testicles <font color='yellow'>(Hidden by Clothes)</font>" : (T.mode == "visable" ? "Testicles <font color='green'>(Visable)</font>" : "Testicles <font color='green'>(Visable)</font>"))]</a><BR>"
		else //internal balls
			dat	+= "<a href='byond://?src=[REF(src)];na=1'>Internal Testicles</A><BR>"
	var/obj/item/organ/genital/vagina/V = user.getorganslot("vagina")
	if (V) //they have a vjay
		dat	+= "<a href='byond://?src=[REF(src)];hidevagina=1'>[V.mode == "hidden" ? "Vagina <font color='red'>(Hidden)</font>" : (V.mode == "clothes" ? "Vagina <font color='yellow'>(Hidden by Clothes)</font>" : (V.mode == "visable" ? "Vagina <font color='green'>(Visable)</font>" : "Vagina <font color='green'>(Visable)</font>"))]</a><BR>"

	var/obj/item/organ/genital/breasts/B = user.getorganslot("breasts")
	if (B) //they have a boobiedoo
		dat	+= "<a href='byond://?src=[REF(src)];hidebreasts=1'>[B.mode == "hidden" ? "Breasts <font color='red'>(Hidden)</font>" : (B.mode == "clothes" ? "Breasts <font color='yellow'>(Hidden by Clothes)</font>" : (B.mode == "visable" ? "Breasts <font color='green'>(Visable)</font>" : "Breasts <font color='green'>(Visable)</font>"))]</a><BR>"

	dat	+=	{"<BR><B>Contexual Options</B><BR><HR>"}
	//Options
	dat	+= "<a href='byond://?src=[REF(src)];masturbate=1'>Masturbate</A>"
	dat	+=	"(Stimulate a sexual organ with your hands.)<BR>"

	dat	+= "<a href='byond://?src=[REF(src)];climax=1'>Climax</A>"
	dat	+=	"(Orgasm from a sexual organ.)<BR>"

	dat	+= "<a href='byond://?src=[REF(src)];container=1'>Fill container</A>"
	dat	+=	"(Use a container in your hand to collect your seminal fluid.)<BR>"

	if(user.pulling)
		dat	+= "<a href='byond://?src=[REF(src)];kiss=1'>Kiss [user.pulling]</A>"
		dat	+=	"(Kiss a partner, or object.)<BR>"

		dat	+= "<a href='byond://?src=[REF(src)];climaxover=1'>Climax over [user.pulling]</A>" //you can cum on objects if you really want...
		dat	+=	"(Orgasm over a person or object.)<BR>"

		if(isliving(user.pulling))
			if(iscarbon(user.pulling))
				dat	+= "<a href='byond://?src=[REF(src)];climaxwith=1'>Climax with [user.pulling]</A>"
				dat	+=	{"(Orgasm with another person.)<BR>"}

				var/mob/living/carbon/human/H = user.pulling
				if(H.breedable && P && H)
					dat	+= "<a href='byond://?src=[REF(src)];impreg=1'>Impregnate [user.pulling]</A>"
					dat	+=	"(Climax inside another person, knocking them up.)<BR>"


	dat	+=	{"<HR>"}//Newline for the objects
	if(P.condom == 1)
		dat	+= "<a href='byond://?src=[REF(src)];removecondom=1'>Remove Condom</A><BR>"
	if(P.sounding == 1)
		dat	+= "<a href='byond://?src=[REF(src)];removesound=1'>Remove Sounding Rod</A><BR>"

	dat	+= "<a href='byond://?src=[REF(src)];refresh=1'>Refresh</A>"
	dat	+= "<a href='byond://?src=[REF(src)];omenu=1'>Old Menu</A><BR>"

	var/datum/browser/popup = new(user, "arousal", "Arousal Panel")
	popup.set_content(dat)
	popup.set_title_image(user.browse_rsc_icon(icon, icon_state), 500,600)

	popup.open()


/obj/screen/arousal/Topic(href, href_list)
	. = ..() //Sanity checks.
	if(..())
		return

	var/mob/living/carbon/human/H = usr
	if (!H)
		return
	if(usr.stat==1) //No sleep-masturbation, you're unconscious.
		to_chat(usr, "<span class='warning'>You must be conscious to do that!</span>")
		usr << browse(null, "window=arousal") //closes the window
		return
	if(usr.stat==3)
		to_chat(usr, "<span class='warning'>You must be alive to do that!</span>")
		usr << browse(null, "window=arousal") //closes the window
		return

	if(href_list["hidepenis"])
		var/obj/item/organ/genital/penis/P = usr.getorganslot("penis")
		var/picked_visibility = input(usr, "Choose visibility", "Expose/Hide genitals", "Hidden by clothes") in list("Always visible", "Hidden by clothes", "Always hidden")
		P.toggle_visibility(picked_visibility)

	if(href_list["hidevagina"])
		var/obj/item/organ/genital/vagina/V = usr.getorganslot("vagina")
		var/picked_visibility = input(usr, "Choose visibility", "Expose/Hide genitals", "Hidden by clothes") in list("Always visible", "Hidden by clothes", "Always hidden")
		V.toggle_visibility(picked_visibility)

	if(href_list["hidebreasts"])
		var/obj/item/organ/genital/breasts/B = usr.getorganslot("breasts")
		var/picked_visibility = input(usr, "Choose visibility", "Expose/Hide genitals", "Hidden by clothes") in list("Always visible", "Hidden by clothes", "Always hidden")
		B.toggle_visibility(picked_visibility)

	if(href_list["hidetesticles"])
		var/obj/item/organ/genital/testicles/T = usr.getorganslot("testicles")
		var/picked_visibility = input(usr, "Choose visibility", "Expose/Hide genitals", "Hidden by clothes") in list("Always visible", "Hidden by clothes", "Always hidden")
		T.toggle_visibility(picked_visibility)

	if(href_list["masturbate"])
		if (H.arousalloss >= (H.max_arousal / 100) * 33) //requires 33% arousal.
			H.solomasturbate()
			return
		else
			to_chat(usr, "<span class='warning'>You aren't aroused enough for that! </span>")
		return

	if(href_list["container"])
		if (H.arousalloss >= (H.max_arousal / 100) * 33) //requires 33% arousal.
			H.cumcontainer()
			return
		else
			to_chat(usr, "<span class='warning'>You aren't aroused enough for that! </span>")
		return

	if(href_list["climax"])
		if (H.arousalloss >= (H.max_arousal / 100) * 33) //requires 33% arousal.
			H.climaxalone(FALSE)
			return
		else
			to_chat(usr, "<span class='warning'>You aren't aroused enough for that! </span>")
		return

	if(href_list["climaxover"])
		if (H.arousalloss >= (H.max_arousal / 100) * 33) //requires 33% arousal.
			H.climaxover(usr.pulling)
			return
		else
			to_chat(usr, "<span class='warning'>You aren't aroused enough for that! </span>")
		return

	if(href_list["climaxwith"])
		if (H.arousalloss >= (H.max_arousal / 100) * 33) //requires 33% arousal.
			H.climaxwith(usr.pulling)
			return
		else
			to_chat(usr, "<span class='warning'>You aren't aroused enough for that! </span>")
		return

	if(href_list["impreg"])
		if (H.arousalloss >= (H.max_arousal / 100) * 33) //requires 33% arousal.
			H.impregwith(usr.pulling)
			return
		else
			to_chat(usr, "<span class='warning'>You aren't aroused enough for that! </span>")
		return

	if(href_list["kiss"])
		if(usr.pulling)
			kiss()
		else
			to_chat(usr, "<span class='warning'>You cannot do this alone!</span>")
		return

	if(href_list["removecondom"])
		H.menuremovecondom()

	if(href_list["removesound"])
		H.menuremovesounding()

	if(href_list["omenu"])
		H.mob_climax()
		usr << browse(null, "window=arousal") //closes the window
		return

	src.ui_interact(usr)


obj/screen/arousal/proc/kiss()
	if(usr.restrained(TRUE))
		to_chat(usr, "<span class='warning'>You can't do that while restrained!</span>")
		return
	var/mob/living/carbon/human/H = usr
	if (H)
		H.kisstarget(H.pulling)


/mob/living/carbon/human/proc/menuremovecondom()

	if(restrained(TRUE))
		to_chat(src, "<span class='warning'>You can't do that while restrained!</span>")
		return
	var/free_hands = get_num_arms()
	if(!free_hands)
		to_chat(src, "<span class='warning'>You need at least one free arm.</span>")
		return
	var/obj/item/organ/genital/penis/P = getorganslot("penis")
	if(!P.condom)
		to_chat(src, "<span class='warning'>You don't have a condom on!</span>")
		return
	if(P.condom)
		to_chat(src, "<span class='warning'>You tug the condom off the end of your penis!</span>")
		removecondom()
		src.ui_interact(usr) //reopen dialog
		return
	return

/mob/living/carbon/human/proc/menuremovesounding()

	if(restrained(TRUE))
		to_chat(src, "<span class='warning'>You can't do that while restrained!</span>")
		return
	var/free_hands = get_num_arms()
	if(!free_hands)
		to_chat(src, "<span class='warning'>You need at least one free arm.</span>")
		return
	var/obj/item/organ/genital/penis/P = getorganslot("penis")
	if(!P.sounding)
		to_chat(src, "<span class='warning'>You don't have a rod inside!</span>")
		return
	if(P.sounding)
		to_chat(src, "<span class='warning'>You pull the rod off from the tip of your penis!</span>")
		removesounding()
		src.ui_interact(usr) //reopen dialog
		return
	return

/mob/living/carbon/human/proc/solomasturbate()
	if(restrained(TRUE))
		to_chat(src, "<span class='warning'>You can't do that while restrained!</span>")
		return
	var/free_hands = get_num_arms()
	if(!free_hands)
		to_chat(src, "<span class='warning'>You need at least one free arm.</span>")
		return
	for(var/helditem in held_items)
		if(isobj(helditem))
			free_hands--
	if(free_hands <= 0)
		to_chat(src, "<span class='warning'>You're holding too many things.</span>")
		return
	//We got hands, let's pick an organ
	var/obj/item/organ/genital/picked_organ
	picked_organ = pick_masturbate_genitals()
	if(picked_organ)
		src << browse(null, "window=arousal") //closes the window
		mob_masturbate(picked_organ)
		return
	else //They either lack organs that can masturbate, or they didn't pick one.
		to_chat(src, "<span class='warning'>You cannot climax without choosing genitals.</span>")
		return


//Kissing target proc
/mob/living/carbon/human/proc/kisstarget(mob/living/L)

	src << browse(null, "window=arousal") //closes the arousal window, if its open, mainly to stop spam
	if(isliving(L)) //is your target living? Living people can resist your advances if they want to via moving.
		if(iscarbon(L))
			src.visible_message("<span class='notice'>[src] is about to kiss [L]!</span>", \
								"<span class='notice'>You're attempting to kiss [L]!</span>", \
								"<span class='notice'>You're attempting to kiss with something!</span>")
			if(!do_mob(src, L, 2 SECONDS))	//I think two seconds is enough time to pull away if its unwanted.
				return
			SEND_SIGNAL(L, COMSIG_ADD_MOOD_EVENT, "kissed", /datum/mood_event/kiss) //how cute, affection is nice.
	//Well done you kissed it/them!
	src.visible_message("<span class='notice'>[src] kisses [L]!</span>", \
						"<span class='notice'>You kiss [L]!</span>", \
						"<span class='notice'>You kiss something!</span>")

/mob/living/carbon/human/proc/climaxalone()
	//we dont need hands to climax alone, its hands free!
	var/obj/item/organ/genital/picked_organ
	picked_organ = pick_climax_genitals()
	if(picked_organ)
		src << browse(null, "window=arousal") //closes the window
		mob_climax_outside(picked_organ)
		return
	else //They either lack organs that can masturbate, or they didn't pick one.
		to_chat(src, "<span class='warning'>You cannot climax without choosing genitals.</span>")
		return


/mob/living/carbon/human/proc/climaxwith(mob/living/T)

	var/mob/living/carbon/human/L = pick_partner()
	var/obj/item/organ/genital/picked_organ
	picked_organ = pick_climax_genitals()
	if(picked_organ)
		var/mob/living/partner = L
		if(partner)
			src << browse(null, "window=arousal") //alls fine, we can close the window now.
			var/obj/item/organ/genital/penis/P = picked_organ
			var/spillage = "No" //default to no, just incase player has items on to prevent climax
			if(!P.condom == 1&&!P.sounding == 1) //you cant climax with a condom on or sounding in.
				spillage = input(src, "Would your fluids spill outside?", "Choose overflowing option", "Yes") as anything in list("Yes", "No")
			if(spillage == "Yes")
				mob_climax_partner(picked_organ, partner, TRUE, FALSE, FALSE)
			else
				mob_climax_partner(picked_organ, partner, FALSE, FALSE, FALSE)
		else
			to_chat(src, "<span class='warning'>You cannot do this alone.</span>")
			return
	else //They either lack organs that can masturbate, or they didn't pick one.
		to_chat(src, "<span class='warning'>You cannot climax without choosing genitals.</span>")
		return

/mob/living/carbon/human/proc/climaxover(mob/living/T)

	var/mob/living/carbon/human/L = T
	var/obj/item/organ/genital/picked_organ
	picked_organ = pick_climax_genitals()
	if(picked_organ)
		src << browse(null, "window=arousal") //alls fine, we can close the window now.
		var/mob/living/partner = L
		if(partner)
			var/obj/item/organ/genital/penis/P = picked_organ
			if(P.condom == 1)
				to_chat(src, "<span class='warning'>You cannot do this action with a condom on.</span>")
				return
			if(P.sounding == 1)
				to_chat(src, "<span class='warning'>You cannot do this action with a sounding in.</span>")
				return
			mob_climax_partner(picked_organ, partner, FALSE, FALSE, TRUE)
		else
			to_chat(src, "<span class='warning'>You cannot do this alone.</span>")
			return
	else //They either lack organs that can masturbate, or they didn't pick one.
		to_chat(src, "<span class='warning'>You cannot climax without choosing genitals.</span>")
		return

/mob/living/carbon/human/proc/impregwith(mob/living/T)

	var/mob/living/carbon/human/L = pick_partner()
	var/obj/item/organ/genital/picked_organ
	picked_organ = src.getorganslot("penis") //Impregnation must be done with a penis.
	if(picked_organ)
		var/mob/living/partner = L
		if(partner)
			if(!partner.breedable)//check if impregable.
				to_chat(src, "<span class='warning'>Your partner cannot be impregnated.</span>")//some fuckary happening, you shouldnt even get to this point tbh.
				return
			var/obj/item/organ/genital/penis/P = picked_organ
			 //you cant impreg with a condom on or sounding in.
			if(P.condom == 1)
				to_chat(src, "<span class='warning'>You cannot do this action with a condom on.</span>")
				return
			if(P.sounding == 1)
				to_chat(src, "<span class='warning'>You cannot do this action with a sounding in.</span>")
				return
			src << browse(null, "window=arousal") //alls fine, we can close the window now.
			//Keeping this for messy fun
			var/spillage = input(src, "Would your fluids spill outside?", "Choose overflowing option", "Yes") as anything in list("Yes", "No")
			if(spillage == "Yes")
				mob_climax_partner(picked_organ, partner, TRUE, TRUE, FALSE)
			else
				mob_climax_partner(picked_organ, partner, FALSE, TRUE, FALSE)
		else
			to_chat(src, "<span class='warning'>You cannot do this alone.</span>")
			return
	else //no penis :(
		to_chat(src, "<span class='warning'>You cannot impregnate without a penis.</span>")
		return

/mob/living/carbon/human/proc/cumcontainer(mob/living/T)
	//We'll need hands and no restraints.
	if(restrained(TRUE)) //TRUE ignores grabs
		to_chat(src, "<span class='warning'>You can't do that while restrained!</span>")
		return
	var/free_hands = get_num_arms()
	if(!free_hands)
		to_chat(src, "<span class='warning'>You need at least one free arm.</span>")
		return
	for(var/helditem in held_items)//how many hands are free
		if(isobj(helditem))
			free_hands--
	if(free_hands <= 0)
		to_chat(src, "<span class='warning'>You're holding too many things.</span>")
		return
	//We got hands, let's pick an organ
	var/obj/item/organ/genital/picked_organ
	src << browse(null, "window=arousal")
	picked_organ = pick_climax_genitals() //Gotta be climaxable, not just masturbation, to fill with fluids.
	if(picked_organ)
		//Good, got an organ, time to pick a container
		var/obj/item/reagent_containers/fluid_container = pick_climax_container()
		if(fluid_container)
			mob_fill_container(picked_organ, fluid_container)
			return
		else
			to_chat(src, "<span class='warning'>You cannot do this without anything to fill.</span>")
			return
	else //They either lack organs that can climax, or they didn't pick one.
		to_chat(src, "<span class='warning'>You cannot fill anything without choosing genitals.</span>")
		return

/atom/proc/add_cum_overlay() //This can go in a better spot, for now its here.
	cum_splatter_icon = icon(initial(icon), initial(icon_state), , 1)
	cum_splatter_icon.Blend("#fff", ICON_ADD)
	cum_splatter_icon.Blend(icon('hyperstation/icons/effects/cumoverlay.dmi', "cum_obj"), ICON_MULTIPLY)
	add_overlay(cum_splatter_icon)

/atom/proc/wash_cum()
	cut_overlay(mutable_appearance('hyperstation/icons/effects/cumoverlay.dmi', "cum_normal"))
	cut_overlay(mutable_appearance('hyperstation/icons/effects/cumoverlay.dmi', "cum_large"))
	if(cum_splatter_icon)
		cut_overlay(cum_splatter_icon)
	return TRUE