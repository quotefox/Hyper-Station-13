//hyperstation 13 nail polish

/obj/item/nailpolish
	name = "nail polish"
	desc = "Paint with a fine brush to do your nails, or someone elses."
	icon = 'hyperstation/icons/obj/cosmetic.dmi'
	icon_state = "nailcap"
	item_state = "nailpolish"
	w_class = WEIGHT_CLASS_SMALL
	var/paint = "black"
	price = 5
	var/mutable_appearance/bottle //show the colour on the bottle.

/obj/item/nailpolish/red
	name = "red nail polish"
	paint = "red"

/obj/item/nailpolish/blue
	name = "blue nail polish"
	paint = "blue"

/obj/item/nailpolish/aqua
	name = "cyan nail polish"
	paint = "aqua"

/obj/item/nailpolish/black
	name = "black nail polish"
	paint = "black"

/obj/item/nailpolish/white
	name = "white nail polish"
	paint = "white"

/obj/item/nailpolish/navy
	name = "navy nail polish"
	paint = "navy"

/obj/item/nailpolish/yellow
	name = "yellow nail polish"
	paint = "yellow"

/obj/item/nailpolish/purple
	name = "purple nail polish"
	paint = "purple"

/obj/item/nailpolish/Initialize()
	. = ..()
	bottle = mutable_appearance('hyperstation/icons/obj/cosmetic.dmi', "nailpolish")
	bottle.color = paint
	add_overlay(bottle)


/obj/item/nailpolish/attack(mob/M, mob/user)
	if(!ismob(M))
		return

	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H == user)
			user.visible_message("<span class='notice'>[user] does [user.p_their()] nails with \the [src].</span>", \
								 "<span class='notice'>You take a moment to apply \the [src]. Perfect!</span>")
			H.nail_style = "nails"
			H.nail_color = paint
			H.update_body()
		else
			user.visible_message("<span class='warning'>[user] begins to do [H]'s nails with \the [src].</span>", \
								 "<span class='notice'>You begin to apply \the [src] on [H]'s nails...</span>")
			if(do_after(user, 20, target = H))
				user.visible_message("[user] does [H]'s nails with \the [src].", \
									 "<span class='notice'>You apply \the [src] on [H]'s nails.</span>")
				H.nail_style = "nails"
				H.nail_color = paint
				H.update_body()
	else
		to_chat(user, "<span class='warning'>Where are the nail on that?</span>")