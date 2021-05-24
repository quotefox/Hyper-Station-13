/obj/item/storage/backpack/gigantic
    name = "enormous backpack"
    desc = "An absolutely massive backpack for particularly large crewmen."
    icon_state = "explorerpack"
    item_state = "explorerpack"

/obj/item/storage/backpack/gigantic/ComponentInitialize()
    . = ..()
    var/datum/component/storage/STR = GetComponent(/datum/component/storage)
    STR.allow_big_nesting = TRUE
    STR.max_combined_w_class = 35
    STR.max_w_class = WEIGHT_CLASS_HUGE

/obj/item/storage/backpack/gigantic/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning, bypass_equip_delay_self)
    if(!..()) 
        return FALSE
    if(M.size_multiplier >= 2.0)
        return ..()
    else
        return FALSE

/obj/item/storage/backpack/gigantic/proc/fallOff(mob/living/wearer)
    wearer.dropItemToGround(src, TRUE)
    playsound(src.loc, 'sound/items/handling/cloth_drop.ogg', 50, TRUE)
    playsound(src.loc, 'sound/items/handling/toolbelt_drop.ogg', 50, TRUE)
    wearer.visible_message("<span class='warning'>The [src.name] slips off [wearer]'s now too-small body and falls to the ground!'</span>", "<span class='warning'>The [src.name] slips off your now too-small body and falls to the ground!'</span>")

/obj/item/storage/backpack/gigantic/equipped(mob/equipper, slot)
    . = ..()
    if(slot == SLOT_BACK)
        RegisterSignal(equipper, COMSIG_MOBSIZE_CHANGED, .proc/fallOff)
    else
        UnregisterSignal(equipper, COMSIG_MOBSIZE_CHANGED)

    
/obj/item/storage/backpack/gigantic/dropped(mob/user, silent)
    UnregisterSignal(user, COMSIG_MOBSIZE_CHANGED)


/obj/item/storage/backpack/gigantic/satchel
    name = "enormous satchel"
    desc = "An absolutely massive satchel for particularly large crewmen."
    icon_state = "satchel-explorer"
    item_state = "securitypack"
