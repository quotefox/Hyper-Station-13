/obj/item/ammo_box/magazine/m10mm/rifle
	name = "rifle magazine (10mm)"
	desc = "A well-worn magazine fitted for the surplus rifle."
	icon_state = "75-8"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = "10mm"
	max_ammo = 10

/obj/item/ammo_box/magazine/m10mm/rifle/update_icon()
	if(ammo_count())
		icon_state = "75-8"
	else
		icon_state = "75-0"

/obj/item/ammo_box/magazine/m556
	name = "toploader magazine (5.56mm)"
	icon_state = "5.56m"
	ammo_type = /obj/item/ammo_casing/a556
	caliber = "a556"
	max_ammo = 30
	multiple_sprites = 2

//braton
/obj/item/ammo_box/magazine/bratonmag
	name = "toploader magazine (braton)"
	icon_state = "bratonmag"
	ammo_type = /obj/item/ammo_casing/bratonmag
	caliber = "bratonb"
	max_ammo = 60

//FAL
/obj/item/ammo_box/magazine/falMag
	name = "FAL Magazine (20rnd.)"
	icon_state = "fal-mag"
	ammo_type = /obj/item/ammo_casing/fal762
	caliber = "762fal"
	max_ammo = 20
	multiple_sprites = 2