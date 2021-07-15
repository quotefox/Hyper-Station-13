/*
Holds things like antag datums, game modes, abilities, and everything
related to the antag that could be a datum
*/

//ANTAGONIST
/datum/antagonist/wendigo
	name = "wendigo"
	antagpanel_category = "Wendigo"

/datum/antagonist/wendigo/on_gain()
	if(istype(owner.current, /mob/living/carbon/human))
		var/mob/living/carbon/wendigo/new_owner = new/mob/living/carbon/wendigo(get_turf(owner.current))
		var/mob/current_body = owner.current
		current_body.transfer_ckey(new_owner)
		current_body.Destroy()
		owner = new_owner.mind
		owner.current = new_owner
	..()
		

//HUD
//Contents: Intentions, Hands, Dropping/Throwing/Pulling, Inventory Equip
//		Health + Souls on the bottom of screen
//TODO: Health doll, Soul counter (not devil)

/datum/hud/wendigo/New(mob/living/carbon/wendigo/owner)
	..()
	var/obj/screen/using
	var/obj/screen/inventory/inv_box

	var/widescreenlayout = FALSE	//adds support for different hud layouts depending on widescreen pref
	if(owner.client && owner.client.prefs && owner.client.prefs.widescreenpref)
		widescreenlayout = FALSE
	
	//CRAFTING
	using = new /obj/screen/craft
	using.icon = ui_style
	if(!widescreenlayout)
		using.screen_loc = ui_boxcraft
	static_inventory += using

	//LANG MENU
	using = new/obj/screen/language_menu
	using.icon = ui_style
	if(!widescreenlayout)
		using.screen_loc = ui_boxlang
	static_inventory += using

	//AREA EDITOR
	using = new /obj/screen/area_creator
	using.icon = ui_style
	if(!widescreenlayout)
		using.screen_loc = ui_boxarea
	static_inventory += using

	using = new /obj/screen/voretoggle()
	using.icon = tg_ui_icon_to_cit_ui(ui_style)
	using.screen_loc = ui_voremode
	if(!widescreenlayout)
		using.screen_loc = ui_boxvore
	static_inventory += using

	//INTENTS & ACTIONS
	action_intent = new /obj/screen/act_intent/segmented
	action_intent.icon_state = mymob.a_intent
	static_inventory += action_intent

	using = new /obj/screen/human/equip()
	using.icon = ui_style
	using.screen_loc = ui_equip_position(mymob)
	static_inventory += using

	using = new /obj/screen/mov_intent
	using.icon = tg_ui_icon_to_cit_ui(ui_style)
	using.icon_state = (mymob.m_intent == MOVE_INTENT_RUN ? "running" : "walking")
	using.screen_loc = ui_movi
	static_inventory += using

	using = new /obj/screen/resist()
	using.icon = ui_style
	using.screen_loc = ui_overridden_resist
	hotkeybuttons += using

	using = new /obj/screen/restbutton()
	using.icon = tg_ui_icon_to_cit_ui(ui_style)
	using.screen_loc = ui_pull_resist
	static_inventory += using

	using = new /obj/screen/combattoggle()
	using.icon = tg_ui_icon_to_cit_ui(ui_style)
	using.screen_loc = ui_combat_toggle
	static_inventory += using

	using = new /obj/screen/drop()
	using.icon = ui_style
	using.screen_loc = ui_drop_throw
	static_inventory += using

	pull_icon = new /obj/screen/pull()
	pull_icon.icon = ui_style
	pull_icon.update_icon(mymob)
	pull_icon.screen_loc = ui_pull_resist
	static_inventory += pull_icon

	throw_icon = new /obj/screen/throw_catch()
	throw_icon.icon = ui_style
	throw_icon.screen_loc = ui_drop_throw
	hotkeybuttons += throw_icon

//////
	//INVENTORY
//////
	build_hand_slots()

	using = new /obj/screen/human/toggle()
	using.icon = ui_style
	using.screen_loc = ui_inventory
	static_inventory += using

	using = new /obj/screen/swap_hand()
	using.icon = ui_style
	using.icon_state = "swap_1"
	using.screen_loc = ui_swaphand_position(owner,1)
	static_inventory += using

	using = new /obj/screen/swap_hand()
	using.icon = ui_style
	using.icon_state = "swap_2"
	using.screen_loc = ui_swaphand_position(owner,2)
	static_inventory += using

	inv_box = new /obj/screen/inventory()
	inv_box.name = "neck"
	inv_box.icon = ui_style
	inv_box.icon_state = "neck"
	inv_box.screen_loc = ui_neck
	inv_box.slot_id = SLOT_NECK
	toggleable_inventory += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "back"
	inv_box.icon = ui_style
	inv_box.icon_state = "back"
	inv_box.screen_loc = ui_back
	inv_box.slot_id = SLOT_BACK
	static_inventory += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "gloves"
	inv_box.icon = ui_style
	inv_box.icon_state = "gloves"
	inv_box.screen_loc = ui_gloves
	inv_box.slot_id = SLOT_GLOVES
	toggleable_inventory += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "eyes"
	inv_box.icon = ui_style
	inv_box.icon_state = "glasses"
	inv_box.screen_loc = ui_glasses
	inv_box.slot_id = SLOT_GLASSES
	toggleable_inventory += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "ears"
	inv_box.icon = ui_style
	inv_box.icon_state = "ears"
	inv_box.screen_loc = ui_ears
	inv_box.slot_id = SLOT_EARS
	toggleable_inventory += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "head"
	inv_box.icon = ui_style
	inv_box.icon_state = "head"
	inv_box.screen_loc = ui_head
	inv_box.slot_id = SLOT_HEAD
	toggleable_inventory += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "belt"
	inv_box.icon = ui_style
	inv_box.icon_state = "belt"
	inv_box.screen_loc = ui_belt
	inv_box.slot_id = SLOT_BELT
	static_inventory += inv_box

	//INFO DISPLAY

	internals = new /obj/screen/internals()
	infodisplay += internals

	healths = new /obj/screen/healths()
	infodisplay += healths

	healthdoll = new /obj/screen/healthdoll()
	infodisplay += healthdoll

	zone_select =  new /obj/screen/zone_sel()
	zone_select.icon = ui_style
	zone_select.update_icon(mymob)
	static_inventory += zone_select

	for(var/obj/screen/inventory/inv in (static_inventory + toggleable_inventory))
		if(inv.slot_id)
			inv.hud = src
			inv_slots[inv.slot_id] = inv
			inv.update_icon()

/datum/hud/wendigo/hidden_inventory_update(mob/viewer)
	if(!mymob)
		return
	var/mob/living/carbon/wendigo/W = mymob

	var/mob/screenmob = viewer || W

	if(screenmob.hud_used.inventory_shown && screenmob.hud_used.hud_shown)
		if(W.gloves)
			W.gloves.screen_loc = ui_gloves
			screenmob.client.screen += W.gloves
		if(W.ears)
			W.ears.screen_loc = ui_ears
			screenmob.client.screen += W.ears
		if(W.glasses)
			W.glasses.screen_loc = ui_glasses
			screenmob.client.screen += W.glasses
		if(W.wear_neck)
			W.wear_neck.screen_loc = ui_neck
			screenmob.client.screen += W.wear_neck
		if(W.head)
			W.head.screen_loc = ui_head
			screenmob.client.screen += W.head
	else
		if(W.gloves)	screenmob.client.screen -= W.gloves
		if(W.ears)		screenmob.client.screen -= W.ears
		if(W.glasses)	screenmob.client.screen -= W.glasses
		if(W.wear_neck)	screenmob.client.screen -= W.wear_neck
		if(W.head)		screenmob.client.screen -= W.head

/datum/hud/wendigo/persistent_inventory_update(mob/viewer)
	if(!mymob)
		return
	..()
	var/mob/living/carbon/wendigo/W = mymob

	var/mob/screenmob = viewer || W

	if(screenmob.hud_used)
		if(screenmob.hud_used.hud_shown)
			if(W.belt)
				W.belt.screen_loc = ui_belt
				screenmob.client.screen += W.belt
			if(W.back)
				W.back.screen_loc = ui_back
				screenmob.client.screen += W.back
		else
			if(W.belt)
				screenmob.client.screen -= W.belt
			if(W.back)
				screenmob.client.screen -= W.back

	if(hud_version != HUD_STYLE_NOHUD)
		for(var/obj/item/I in W.held_items)
			I.screen_loc = ui_hand_position(W.get_held_index_of_item(I))
			screenmob.client.screen += I
	else
		for(var/obj/item/I in W.held_items)
			I.screen_loc = null
			screenmob.client.screen -= I

/datum/hud/wendigo/show_hud(version = 0,mob/viewmob)
	. = ..()
	if(!.)
		return
	var/mob/screenmob = viewmob || mymob
	hidden_inventory_update(screenmob)
