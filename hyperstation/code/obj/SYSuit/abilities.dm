//Condensed location for abilities of the SYSuit
//Lord forgive me because I'm mostly referencing the ninja suit, and it's kind of messy.


/obj/item/clothing/under/syclothing/proc/lock_suit(mob/living/carbon/human/H)
    //there is certainly a better way to do this, but again, referencing ninja code for now
    //First we make the checks for correct clothing being present
	if(!istype(H))
		return FALSE
	if(!istype(H.head, /obj/item/clothing/head/sycap))
		to_chat(H, "<span class='userdanger'>ERROR</span>: 100113 UNABLE TO LOCATE HEAD GEAR\nABORTING...")
		return FALSE
	if(!istype(H.glasses, /obj/item/clothing/glasses/hud/toggle/syvisor))
		to_chat(H, "<span class='userdanger'>ERROR</span>: 90211 UNABLE TO LOCATE EYE GEAR\nABORTING...")
		return FALSE
	if(!istype(H.shoes, /obj/item/clothing/shoes/syshoes))
		to_chat(H, "<span class='userdanger'>ERROR</span>: 122011 UNABLE TO LOCATE FOOT GEAR\nABORTING...")
		return FALSE
	if(!istype(H.gloves, /obj/item/clothing/gloves/sygloves))
		to_chat(H, "<span class='userdanger'>ERROR</span>: 110223 UNABLE TO LOCATE HAND GEAR\nABORTING...")
		return FALSE
    //Now we prevent them from being removed
	affecting = H
	ADD_TRAIT(src, TRAIT_NODROP, SYTECH_SUIT_TRAIT) //apply to the suit itself
	sy_cap = H.head
	ADD_TRAIT(sy_cap, TRAIT_NODROP, SYTECH_SUIT_TRAIT)
	sy_visor = H.glasses
	ADD_TRAIT(sy_visor, TRAIT_NODROP, SYTECH_SUIT_TRAIT)
	sy_shoes = H.shoes
	ADD_TRAIT(sy_shoes, TRAIT_NODROP, SYTECH_SUIT_TRAIT)
	sy_gloves = H.gloves
	ADD_TRAIT(sy_gloves, TRAIT_NODROP, SYTECH_SUIT_TRAIT)
	return TRUE

//this hurts my eyes to look at
/obj/item/clothing/under/syclothing/proc/unlock_suit()
    affecting = null
    REMOVE_TRAIT(src, TRAIT_NODROP, SYTECH_SUIT_TRAIT)
    if(sy_cap)
        REMOVE_TRAIT(sy_cap, TRAIT_NODROP, SYTECH_SUIT_TRAIT)
    if(sy_visor)
        REMOVE_TRAIT(sy_visor, TRAIT_NODROP, SYTECH_SUIT_TRAIT)
    if(sy_shoes)
        REMOVE_TRAIT(sy_shoes, TRAIT_NODROP, SYTECH_SUIT_TRAIT)
    if(sy_gloves)
        REMOVE_TRAIT(sy_gloves, TRAIT_NODROP, SYTECH_SUIT_TRAIT)

/obj/item/clothing/under/syclothing/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/initialize_sysuit))
		toggle_on_off()
		return TRUE
	if(!s_initialized)
		to_chat(user, "<span class='warning'><b>ERROR</b>: suit offline.  Please activate suit.</span>")
		return FALSE