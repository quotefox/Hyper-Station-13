/obj/item/toy/plush/mammal/winfre
	desc = "An adorable stuffed toy of a pissed hyena. She looks unamused."
	icon = 'hyperstation/icons/obj/plushes.dmi'
	icon_state = "winfre"
	item_state = "winfre"
	attack_verb = list("cackled", "swirlie'd", "stepped on")

/obj/item/toy/plush/mammal/marilyn
	desc = "A cute stuffed fox toy. Now, about that sponge bath..."
	icon = 'hyperstation/icons/obj/plushes.dmi'
	icon_state = "marilyn"
	item_state = "marilyn"

/obj/item/toy/plush/slimeplushie/tania
	desc = "An adorable stuffed toy of a slimegirl. She seems oddly damp..." // Milky slime
	icon = 'hyperstation/icons/obj/plushes.dmi'
	icon_state = "tania"
	item_state = "tania"
	attack_verb = list("hugged", "cuddled", "embraced")
	squeak_override = list('sound/weapons/thudswoosh.ogg' = 1)

/obj/item/toy/plush/slimeplushie/tania/love(obj/item/toy/plush/Kisser, mob/living/user)
	/* if (istype(Kisser, /obj/item/toy/plush/vladin) ) // Vladin plushie isn't real, Vladin plushie cannot hug you ;-;
		..()
	else */
	user.show_message("<span class='notice'>[src] hugs [Kisser]!</span>", 1,
					  "<span class='notice'>[src] hugs [Kisser]!</span>", 0)

// Patreon program means I cannot add the rest of the plushies I sprited :'(

/*
/obj/item/toy/plush/vladin
	desc = "An adorable stuffed toy of a chief medical officer. He's tightly grasping his defib paddles!"
	icon = 'hyperstation/icons/obj/plushes.dmi'
	gender = MALE
	icon_state = "vladin"
	item_state = "vladin"
	attack_verb = list("defibbed", "synthfleshed", "dosed")
	squeak_override = list('sound/machines/defib_charge.ogg' = 1)
	

/obj/item/toy/plush/vladin/love(obj/item/toy/plush/Kisser, mob/living/user) // This is a closed marriage ):<
	if (istype(Kisser, /obj/item/toy/plush/slimeplushie/tania))
		..()
	else
		user.show_message("<span class='notice'>[src] rejects the advances of [Kisser]!</span>", 1,
			"<span class='notice'>That didn't feel like it worked.</span>", 0)

/obj/item/toy/plush/slimeplushie/squish
	icon = 'hyperstation/icons/obj/plushes.dmi'
	icon_state = "squish"
	item_state = "squish"

/obj/item/toy/plush/mothplushie/bib
	desc = "An adorable stuffed toy of a moth person. He has his own little lamp!" // Bib only worships the L O M P
	icon = 'hyperstation/icons/obj/plushes.dmi'
	gender = MALE
	icon_state = "bib"
	item_state = "bib"
	attack_verb = list("lamped", "fluttered", "shone")

/obj/item/toy/plush/bird/vivi
	icon = 'hyperstation/icons/obj/plushes.dmi'
	gender = MALE
	icon_state = "vivi"
	item_state = "vivi"

/obj/item/toy/plush/lizardplushie/chris
	desc = "An adorable stuffed toy of an angry ashwalker. He even comes with his own little crusher!" // CHRIS CHRIS CHRIS!
	icon = 'hyperstation/icons/obj/plushes.dmi'
	gender = MALE
	icon_state = "chris"
	item_state = "chris"
	squeak_override = list('sound/weapons/plasma_cutter.ogg' = 1) // The sound the crusher uses is the same as the plasma cutter :P

	// Part of the code needed for the wishful thinkers who desire to make Chris clash with bubblegum

/*	var/clashing
	var/is_invoker = TRUE


/obj/item/toy/plush/lizard/chris/Moved()
	. = ..()
	var/obj/item/toy/plush/bubbleplush/P = locate() in range(1, src)
	if(P && istype(P.loc, /turf/open) && !P.clash_target && !clashing)
		P.clash_of_the_plushies(src)
*/

/obj/item/toy/plush/borgplushie/mediborg
	desc = "An adorable stuffed toy of a BootyF medical cyborg. It's holding a cookie for you!"
	icon = 'hyperstation/icons/obj/plushes.dmi'
	gender = FEMALE
	icon_state = "mediborg"
	item_state = "mediborg"

/obj/item/toy/plush/lizardplushie/kami
	icon = 'hyperstation/icons/obj/plushes.dmi'
	gender = FEMALE
	icon_state = "kami"
	item_state = "kami"

/obj/item/toy/plush/xeno/xe
	icon = 'hyperstation/icons/obj/plushes.dmi'
	gender = FEMALE
	icon_state = "xe"
	item_state = "xe"
*/
