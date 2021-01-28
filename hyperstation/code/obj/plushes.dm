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

/obj/item/toy/plush/mammal/winterbloo
	name = "Will, the biggest dog"
	desc = "A plush made to look like a thick as hell shiba, looks a little bigger than average too."
	icon = 'hyperstation/icons/obj/plushes.dmi'
	icon_state = "winterbloo"
	item_state = "winterbloo"
	attack_verb = list("hugged", "cuddled", "embraced")

/obj/item/toy/plush/lizardplushie/chris
	name = "Chris Plushie"
	desc = "An adorable stuffed toy of an angry ashwalker. He even comes with his own little crusher!" // CHRIS CHRIS CHRIS!
	icon = 'hyperstation/icons/obj/plushes.dmi'
	gender = MALE
	icon_state = "chris"
	item_state = "chris"
	squeak_override = list('sound/weapons/plasma_cutter.ogg' = 1) // The sound the crusher uses is the same as the plasma cutter :P


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

/obj/item/toy/plush/mammal/grug
	name = "Grug S. Cavemannington Plushie"
	desc = " Everybody's favorite space faring caveman in plushie form. You feel an overwhelming urge to break things while holding it."
	icon = 'hyperstation/icons/obj/plushes.dmi'
	icon_state = "grug"
	item_state = "grug"
	attack_verb = list("thomped", "ook'd", "stoned")
	squeak_override = list('sound/voice/gorillaplush.ogg' = 1)

/obj/item/toy/plush/mammal/lyricalpaws
	name = "Winter Dawn Plushie"
	desc = "Winter Dawn in plushie form! Very cuddly."
	icon = 'hyperstation/icons/obj/plushes.dmi'
	icon_state = "lyricalpaws"
	item_state = "lyricalpaws"

/obj/item/toy/plush/mammal/chemlight
	desc = "An adorable stuffed toy of a mammal that seems to resemble a crew member! It looks to glow and sport four arms."
	gender = MALE	//he's a boy, right?
	icon = 'hyperstation/icons/obj/plushes.dmi'
	icon_state = "chemlight"
	item_state = "chemlight"
	light_color = "#CCFF33"
	light_power = 0.25
	light_range = 1.4
	attack_verb = list("bapped", "slapped", "bonked")

//Vladplush containment starts here
/obj/item/toy/plush/nukeplushie/vladin
	name = "elite operative plushie"
	desc = "A stuffed toy that resembles an elite syndicate nuclear operative. He has a little wedding band!"
	gender = MALE //he's a boy, there is no doubt here
	young = TRUE //he's not actually young, but i refuse to have a plush that is not loyal to his partner. this is the only way i could figure out.
	icon = 'hyperstation/icons/obj/plushes.dmi'
	icon_state = "vladin"
	item_state = "vladin"
	attack_verb = list("nuked", "detonated", "CQC'd", "robusted")
	squeak_override = list('sound/effects/hit_punch.ogg' = 1, 'sound/effects/hit_kick.ogg' = 1, 'sound/weapons/cqchit1.ogg' = 1, 'sound/weapons/cqchit2.ogg' = 1)
//I can't figure out how to make him loyal to a specific type of plush. If anyone figures that out, there will be more. Until then, this is the end of the vladplush.