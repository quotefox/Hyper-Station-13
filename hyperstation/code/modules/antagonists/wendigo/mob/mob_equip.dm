/mob/living/carbon/wendigo/can_equip(obj/item/I, slot, disable_warning)
	switch(slot)
		if(SLOT_HANDS)
			if(get_empty_held_indexes())
				return TRUE
			return FALSE
		if(SLOT_GLASSES)
			if(glasses)
				return FALSE
			if(!(I.slot_flags & ITEM_SLOT_EYES))
				return FALSE
			return TRUE
		if(SLOT_NECK)
			if(wear_neck)
				return FALSE
			if(!(I.slot_flags & ITEM_SLOT_NECK))
				return FALSE
			return TRUE
		if(SLOT_EARS)
			if(ears)
				return FALSE
			if(!(I.slot_flags & ITEM_SLOT_EARS))
				return FALSE
			return TRUE
		if(SLOT_GLOVES)
			if(gloves)
				return FALSE
			if(!(I.slot_flags & ITEM_SLOT_GLOVES))
				return FALSE
			return TRUE
		if(SLOT_BACK)
			if(back)
				return FALSE
			if(!(I.slot_flags & ITEM_SLOT_BACK))
				return FALSE
			return TRUE
		if(SLOT_IN_BACKPACK)
			if(back)
				if(SEND_SIGNAL(back, COMSIG_TRY_STORAGE_CAN_INSERT, I, src, TRUE))
					return TRUE
			return FALSE
		if(SLOT_HEAD)
			if(head)
				return FALSE
			if(!(I.slot_flags & ITEM_SLOT_HEAD))
				return FALSE
			return TRUE
		if(SLOT_BELT)
			if(belt)
				return FALSE
			if(!(I.slot_flags & ITEM_SLOT_BELT))
				return FALSE
			return TRUE
	return FALSE

/mob/living/carbon/wendigo/equip_to_slot(obj/item/I, slot)
	if(!..())
		return
	switch(slot)
		if(SLOT_GLASSES)
			glasses = I
			update_inv_glasses()
		if(SLOT_EARS)
			ears = I
			update_inv_ears()
		if(SLOT_GLOVES)
			gloves = I
			update_inv_gloves()
	return TRUE

/mob/living/carbon/wendigo/doUnEquip(obj/item/I, force, newloc, no_move, invdrop = TRUE)
	. = ..()
	if(!. || !I)
		return
	
	else if(I == gloves)
		gloves = null
		if(!QDELETED(src))
			update_inv_gloves()
	else if(I == glasses)
		glasses = null
		var/obj/item/clothing/glasses/G = I
		if(G.tint)
			update_tint()
		if(G.vision_correction)
			if(HAS_TRAIT(src, TRAIT_NEARSIGHT))
				overlay_fullscreen("nearsighted", /obj/screen/fullscreen/impaired, 1)
			adjust_eye_damage(0)
		if(G.vision_flags || G.darkness_view || G.invis_override || G.invis_view || !isnull(G.lighting_alpha))
			update_sight()
		if(!QDELETED(src))
			update_inv_glasses()
	else if(I == ears)
		ears = null
		if(!QDELETED(src))
			update_inv_ears()
	else if(I == belt)
		belt = null
		if(!QDELETED(src))
			update_inv_belt()
