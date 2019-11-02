/obj/item/emagrecharge
	name = "electromagnet charging device"
	desc = "A small cell with two prongs lazily jabbed into it. It looks like it's made for charging the small batteries found in electromagnetic devices."
	icon = 'icons/obj/module.dmi'
	icon_state = "cell_mini"
	item_flags = NOBLUDGEON
	var/uses = 5	//Dictates how many charges the device adds to compatible items

/obj/item/emagrecharge/examine(mob/user)
	. = ..()
	if(uses)
		to_chat(user, "<span class='notice'>It can add up to [uses] charges to compatible devices</span>")
	else
		to_chat(user, "<span class='warning'>It has a small, red, blinking light coming from inside of it. It's spent.</span>")

/obj/item/card/emag
	var/uses = 10

/obj/item/card/emag/examine(mob/user)
	. = ..()
	to_chat(user, "<span class='notice'>It has <b>[uses ? uses : "no"]</b> charges left.</span>")

/obj/item/card/emag/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/emagrecharge))
		var/obj/item/emagrecharge/ER = W
		if(ER.uses)
			uses += ER.uses
			to_chat(user, "<span class='notice'>You have added [ER.uses] charges to [src]. It now has [uses] charges.</span>")
			playsound(src, "sparks", 100, 1)
			ER.uses = 0
		else
			to_chat(user, "<span class='warning'>[ER] has no charges left.</span>")
		return
	. = ..()
