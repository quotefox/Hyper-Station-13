// Micro Holders - Extends /obj/item/holder... TO:DO, just use most of the already-set procs in inhand_holder.dm

/obj/item/clothing/head/mob_holder/micro
	name = "micro"
	desc = "Another person, small enough to fit in your hand."
	icon = null
	icon_state = ""
	slot_flags = ITEM_SLOT_FEET | ITEM_SLOT_HEAD | ITEM_SLOT_ID | ITEM_SLOT_BACK | ITEM_SLOT_NECK
	w_class = WEIGHT_CLASS_NORMAL
	can_head = TRUE

/obj/item/clothing/head/mob_holder/micro/Initialize(mapload, mob/living/M, _worn_state, alt_worn, lh_icon, rh_icon, _can_head_override = FALSE)
	. = ..()

	if(M)
		M.setDir(SOUTH)
		held_mob = M
		M.forceMove(src)
		appearance = M.appearance
		name = M.name
		desc = M.desc
		assimilate(M)

	if(_can_head_override)
		can_head = _can_head_override
	if(alt_worn)
		alternate_worn_icon = alt_worn
	if(_worn_state)
		item_state = _worn_state
		icon_state = _worn_state
	if(lh_icon)
		lefthand_file = lh_icon
	if(rh_icon)
		righthand_file = rh_icon

/obj/item/clothing/head/mob_holder/micro/proc/assimilate(mob/living/M)
	switch(M.mob_size)
		if(MOB_SIZE_TINY)
			w_class = WEIGHT_CLASS_TINY
		if(MOB_SIZE_SMALL)
			w_class = WEIGHT_CLASS_SMALL
		if(MOB_SIZE_LARGE)
			w_class = WEIGHT_CLASS_HUGE


/obj/item/clothing/head/mob_holder/micro/Destroy()
	if(held_mob)
		release()
	return ..()

/obj/item/clothing/head/mob_holder/micro/dropped()
	..()
	if(isturf(loc))//don't release on soft-drops
		release()

/obj/item/clothing/head/mob_holder/micro/relaymove(mob/user)
	return

//TODO: add a timer to escape someone's grip dependant on size diff
/obj/item/clothing/head/mob_holder/micro/container_resist()
	if(isliving(loc))
		var/mob/living/L = loc
		visible_message("<span class='warning'>[src] escapes [L]!</span>")
	release()

/mob/living/proc/mob_pickup_micro(mob/living/L)
	var/obj/item/clothing/head/mob_holder/micro/holder = generate_mob_holder()
	if(!holder)
		return
	drop_all_held_items()
	L.put_in_hands(holder)
	return

//shoehorned (get it?) and lazy way to do instant foot pickups cause haha funny.
/mob/living/proc/mob_pickup_micro_feet(mob/living/L)
	var/obj/item/clothing/head/mob_holder/micro/holder = generate_mob_holder()
	if(!holder)
		return
	drop_all_held_items()
	L.equip_to_slot(holder, SLOT_SHOES)
	return

/mob/living/proc/mob_try_pickup_micro(mob/living/user)
	if(!ishuman(user) || !src.Adjacent(user) || user.incapacitated() || !can_be_held)
		return FALSE
	if(abs(user.get_effective_size()/src.get_effective_size()) < 2.0 )
		to_chat(user, "<span class='warning'>They're too big to pick up!</span>")
		return FALSE
	if(user.get_active_held_item())
		to_chat(user, "<span class='warning'>Your hands are full!</span>")
		return FALSE
	if(buckled)
		to_chat(user, "<span class='warning'>[src] is buckled to something!</span>")
		return FALSE
	if(src == user)
		to_chat(user, "<span class='warning'>You can't pick yourself up.</span>")
		return FALSE
	visible_message("<span class='warning'>[user] starts picking up [src].</span>", \
					"<span class='userdanger'>[user] starts picking you up!</span>")
	if(!do_after(user, 20, target = src))
		return FALSE

	if(user.get_active_held_item()||buckled)
		return FALSE

	visible_message("<span class='warning'>[user] picks up [src]!</span>", \
					"<span class='userdanger'>[user] picks you up!</span>")
	to_chat(user, "<span class='notice'>You pick [src] up.</span>")
	mob_pickup_micro(user)
	return TRUE

/mob/living/AltClick(mob/user)
	. = ..()
	if(mob_try_pickup_micro(user))
		return TRUE

/obj/item/clothing/head/mob_holder/micro/assume_air(datum/gas_mixture/env)
	var/atom/location = loc
	if(!loc)
		return //null
	var/turf/T = get_turf(loc)
	while(location != T)
		location = location.loc
		if(ismob(location))
			return location.loc.assume_air(env)
	return location.assume_air(env)

/obj/item/clothing/head/mob_holder/micro/remove_air(amount)
	var/atom/location = loc
	if(!loc)
		return //null
	var/turf/T = get_turf(loc)
	while(location != T)
		location = location.loc
		if(ismob(location))
			return location.loc.remove_air(amount)
	return location.remove_air(amount)

/obj/item/clothing/head/mob_holder/micro/examine(var/mob/user)
	for(var/mob/living/M in contents)
		M.examine(user)

/obj/item/clothing/head/mob_holder/micro/MouseDrop(mob/M as mob)
	..()
	if(M != usr) return
	if(usr == src) return
	if(!Adjacent(usr)) return
	if(istype(M,/mob/living/silicon/ai)) return
	for(var/mob/living/carbon/human/O in contents)
		O.show_inv(usr)

/obj/item/clothing/head/mob_holder/micro/attack_self(var/mob/living/user)
	for(var/mob/living/carbon/human/M in contents)
		M.help_shake_act(user)

/obj/item/clothing/head/mob_holder/micro/attacked_by(obj/item/I, mob/living/user)
	for(var/mob/living/carbon/human/M in contents)
		M.attacked_by(I, user) 
