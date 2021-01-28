/obj/item/projectile/sizelaser
	name = "sizeray laser"
	icon_state = "omnilaser"
	hitsound = null
	damage = 5
	damage_type = STAMINA
	flag = "laser"
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE

/obj/item/projectile/sizelaser/shrinkray
	icon_state="bluelaser"

/obj/item/projectile/sizelaser/growthray
	icon_state="laser"

/obj/item/projectile/sizelaser/shrinkray/on_hit(var/atom/target, var/blocked = 0)
	if(istype(target, /mob/living/carbon/human))
		var/mob/living/M = target
		switch(M.size_multiplier)
			if(RESIZE_MACRO to INFINITY)
				M.resize(RESIZE_HUGE)
			if(RESIZE_HUGE to RESIZE_MACRO)
				M.resize(RESIZE_BIG)
			if(RESIZE_BIG to RESIZE_HUGE)
				M.resize(RESIZE_NORMAL)
			if(RESIZE_NORMAL to RESIZE_BIG)
				M.resize(RESIZE_SMALL)
			if(RESIZE_SMALL to RESIZE_NORMAL)
				M.resize(RESIZE_TINY)
			if(RESIZE_TINY to RESIZE_SMALL)
				M.resize(RESIZE_MICRO)
			if((0 - INFINITY) to RESIZE_NORMAL)
				M.resize(RESIZE_MICRO)
		M.update_transform()
	return 1

/obj/item/projectile/sizelaser/growthray/on_hit(var/atom/target, var/blocked = 0 )
	if(istype(target, /mob/living/carbon/human))
		var/mob/living/M = target
		switch(M.size_multiplier)
			if(RESIZE_HUGE to RESIZE_MACRO)
				M.resize(RESIZE_MACRO)
			if(RESIZE_BIG to RESIZE_HUGE)
				M.resize(RESIZE_HUGE)
			if(RESIZE_NORMAL to RESIZE_BIG)
				M.resize(RESIZE_BIG)
			if(RESIZE_SMALL to RESIZE_NORMAL)
				M.resize(RESIZE_NORMAL)
			if(RESIZE_TINY to RESIZE_SMALL)
				M.resize(RESIZE_SMALL)
			if(RESIZE_MICRO to RESIZE_TINY)
				M.resize(RESIZE_TINY)
			if((0 - INFINITY) to RESIZE_MICRO)
				M.resize(RESIZE_MICRO)
		M.update_transform()
	return 1

/obj/item/ammo_casing/energy/laser/growthray
	projectile_type = /obj/item/projectile/sizelaser/growthray
	select_name = "Growth"

/obj/item/ammo_casing/energy/laser/shrinkray
	projectile_type = /obj/item/projectile/sizelaser/shrinkray
	select_name = "Shrink"

//Gun
/obj/item/gun/energy/laser/sizeray
	name = "size ray"
	icon_state = "bluetag"
	desc = "Debug size manipulator. You probably shouldn't have this!"
	item_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/laser/shrinkray, /obj/item/ammo_casing/energy/laser/growthray)
	selfcharge = EGUN_SELFCHARGE
	charge_delay = 5
	ammo_x_offset = 2
	clumsy_check = 1

	attackby(obj/item/W, mob/user)
		if(W==src)
			if(icon_state=="bluetag")
				icon_state="redtag"
				ammo_type = list(/obj/item/ammo_casing/energy/laser/growthray)
			else
				icon_state="bluetag"
				ammo_type = list(/obj/item/ammo_casing/energy/laser/shrinkray)
		return ..()
