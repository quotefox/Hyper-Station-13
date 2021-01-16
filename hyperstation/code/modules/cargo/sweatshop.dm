//THE TOOLS

/obj/item/handsaw
	name = "handsaw"
	desc = "A shoddy tool used to process wood into smaller segments."
	icon = 'hyperstation/icons/obj/sweatshop.dmi'
	icon_state = "handsaw"
	slot_flags = ITEM_SLOT_BACK
	force = 8
	sharpness = TRUE
	w_class = WEIGHT_CLASS_HUGE
	materials = list(MAT_METAL=50)
	attack_verb = list("slashed", "sawed")

/obj/item/hammer
	name = "hammer"
	desc = "A tool used to manually bash nails into place."
	icon = 'hyperstation/icons/obj/sweatshop.dmi'
	icon_state = "hammer"
	slot_flags = ITEM_SLOT_BELT
	force = 7
	sharpness = FALSE
	w_class = WEIGHT_CLASS_NORMAL
	materials = list(MAT_METAL=100)
	attack_verb = list("bonked", "nailed")

/obj/item/glue
	name = "glue"
	desc = "Used to haphazardly stick things together; secured by the toughest Monkey Glue(TM)."
	icon = 'hyperstation/icons/obj/sweatshop.dmi'
	icon_state = "glue"
	force = 0
	sharpness = FALSE
	w_class = WEIGHT_CLASS_SMALL
	materials = list(MAT_PLASTIC=25)
	attack_verb = list("glued", "coughed")

/obj/item/borer
	name = "manual borer"
	desc = "An incredibly awful tool used to manually drill holes into something... Surely there's a better option."
	icon = 'hyperstation/icons/obj/sweatshop.dmi'
	icon_state = "borer"
	force = 3
	sharpness = TRUE
	w_class = WEIGHT_CLASS_SMALL
	materials = list(MAT_METAL=25)
	attack_verb = list("bored", "drilled")

/obj/item/sandpaper
	name = "sandpaper strip"
	desc = "A strip of sandpaper, commonly used for sanding down rough surfaces into a more smooth shape."
	icon = 'hyperstation/icons/obj/sweatshop.dmi'
	icon_state = "sandpaper"
	force = 1
	sharpness = FALSE
	w_class = WEIGHT_CLASS_TINY
	materials = list(MAT_GLASS=1) //lmao
	attack_verb = list("sanded", "licked")

/obj/item/nails
	name = "metal nails"
	desc = "A bunch of nails, used for hammering into things."
	icon = 'hyperstation/icons/obj/sweatshop.dmi'
	icon_state = "nails"
	force = 0
	sharpness = TRUE
	w_class = WEIGHT_CLASS_TINY
	materials = list(MAT_METAL=10)
	attack_verb = list("nailed", "screwed")

/obj/item/woodenplatform
	name = "wood platform"
	desc = "A somewhat sturdy cropping of a plank. This one is an alright foundation for chairs and stools."
	icon = 'hyperstation/icons/obj/sweatshop.dmi'
	icon_state = "wood-platform"
	force = 3
	sharpness = FALSE
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slapped", "thunked")

/obj/item/woodenblock
	name = "wood block"
	desc = "A chopped platform into a wooden block. This one can be used for sanded into pegs, or used as a base on it's own."
	icon = 'hyperstation/icons/obj/sweatshop.dmi'
	icon_state = "wood-block"
	force = 2
	sharpness = FALSE
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("slapped", "thunked")

/obj/item/woodenpeg
	name = "wood peg"
	desc = "A wooden peg. Useful for fitting into holes."
	icon = 'hyperstation/icons/obj/sweatshop.dmi'
	icon_state = "wood-peg"
	force = 1
	sharpness = FALSE
	w_class = WEIGHT_CLASS_TINY
	attack_verb = list("donked", "thunked")

//BASIC RECIPES - To do, add sound

/obj/item/stack/sheet/mineral/wood/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/handsaw))
		to_chat(user,"<span class='notice'> You begin to saw [src] in half...</span>")
		if(isturf(loc) && do_after(user, 40))
			new /obj/item/woodenplatform(loc)
			new /obj/item/woodenplatform(loc) //send help i dont know how to make two in the same line lmfao
			to_chat(user, "<span class='notice'> You saw [src] in half.</span>")
			qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a surface and hold still to saw it!</span>")
	else
		..()

/obj/item/woodenplatform/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/handsaw))
		to_chat(user,"<span class='notice'> You begin cut [src] into smaller pieces...</span>")
		if(isturf(loc) && do_after(user, 20))
			new /obj/item/woodenblock(loc)
			new /obj/item/woodenblock(loc)
			new /obj/item/woodenblock(loc)
			new /obj/item/woodenblock(loc)
			to_chat(user, "<span class='notice'> You cut [src] into four pieces.</span>")
			qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a surface and hold still to saw it!</span>")
	else
		..()

/obj/item/woodenblock/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/sandpaper))
		to_chat(user,"<span class='notice'> You carefully begin to sand down [src]...</span>")
		if(isturf(loc) && do_after(user, 50))
			new /obj/item/woodenpeg(loc)
			to_chat(user, "<span class='notice'> You smooth [src] into a peg.</span>")
			qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a surface and hold still to sand it!</span>")
	else
		..()

/obj/item/stack/rods/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/wirecutters))
		to_chat(user,"<span class='notice'> You tediously begin to cut [src] into several nails.</span>")
		if(isturf(loc) && do_after(user, 80))
			new /obj/item/nails(loc)
			to_chat(user, "<span class='notice'> You make some crude metal nails.</span>")
			qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a surface and hold still to cut it!</span>")
	else
		..()
