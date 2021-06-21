/obj/item/ashtray
	name = "ashtray"
	icon = 'hyperstation/icons/obj/objects.dmi'
	icon_state = "ashtray"

/obj/item/ashtray/attackby(obj/item/I, mob/user, params)
	if (istype(I,/obj/item/clothing/mask/cigarette/))
		var/obj/item/clothing/mask/cigarette/cig = I
		if (cig.lit == 1)
			src.visible_message("[user] crushes [cig] in \the [src], putting it out.")
		else if (cig.lit == 0)
			to_chat(user, "You place [cig] in [src].")
		qdel(cig) //drop it in.

	if (istype(I,/obj/item/cigbutt))
		to_chat(user, "You place [I] in [src].")
		qdel(I) //drop it in.
