//I'll be honest I have no clue where to put lambent aspects, so this will just be here for now. I'm not the best at modularization, nor coding.
//This will be finished lader.

//Innate powers, without attuning to a specific aspect
/datum/action/innate/lambent
	name = "Dahl's a dumbass"
	desc = "Yell at her if you see this"

	background_icon_state = "bg_agent"

	icon_icon = 'icons/mob/actions/actions_spells.dmi' //Using this for now until I sprite some action buttons
	button_icon_state = "spell_default"

	var/mob/living/carbon/human/holder

	//check_flags = AB_CHECK_STUN|AB_CHECK_CONSCIOUS

	//cooldown_time = 10

/datum/action/innate/lambent/Grant(mob/user)
	. = ..()
	holder = user
/*
//FLIGHT
/datum/action/innate/lambent/flight(mob/user)
	name = "Toggle free-flight"
	desc = "Displace the weave locally to propell yourself in any direction."
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_STUN

	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "flight"


/datum/action/innate/lambent/flight/Trigger()
	switch(active)
		if(0) //Start off
			Activate()
			active = 1
			return
		if(1)
			Deactivate()
			active = 0
			return  //can't help but feel like I'm doing things terribly wrong.

/datum/action/innate/lambent/flight/Activate()
	holder.movement_type |= FLYING
	holder.override_float = TRUE
	holder.pass_flags |= PASSTABLE
	holder.visible_message("Reality begins to distort around [holder], bringing them into the air!")

/datum/action/innate/lambent/flight/Deactivate()
	holder.movement_type &= ~FLYING
	holder.override_float = FALSE
	holder.pass_flags &= ~PASSTABLE
	holder.visible_message("Flickering reality fades as [holder] settles to the ground.")
*/

/* Finish this when I understand the code a bit more
/datum/action/cooldown/lambent/locate
	name = "Weave Locate"
	desc = "Plunge into the weave to teleport to a target of your choosing. Be aware of your end result."
	button_icon_state = "emp"
	cooldown_time = 120

	/var/mob/living/carbon/human/target_human = target
*/
/*
/datum/action/innate/lambent/dash
	name = "Surge Dash"
	desc = "Imbue yourself with weave energy to dash forwards."
	
	var/current_charges = 3
	var/max_charges = 3
	var/charge_rate = 250

	var/dash_sound = 'sound/magic/blink.ogg'
	var/recharge_sound = 'sound/magic/charge.ogg'

	var/phasein = /obj/effect/temp_visual/dir_setting/ninja/phase
	var/phaseout = /obj/effect/temp_visual/dir_setting/ninja/phase/out
	var/beam_effect = "blur"

	var/obj/item/lambent/dash

/obj/item/lambent/dash
	name = "condensed Weave energy"
	desc = "Bundling energy straight from the Weave. It hurts your head just to comprehend."
	block_chance = 50
	w_class = WEIGHT_CLASS_HUGE
	force = 0 
	throwforce = 0
	attack_verb = list("resonated", "harmonized")
	var/datum/action/innate/lambent/dash/ability

	icon_state = "energy_katana" //PH

	interaction_flags_item = 0 //Prevent it from being clicked on, just in case.
	//item_flags = DROPDEL //Deletes itself when dropped, but I may need to call some code and qdel instead.

/obj/item/lambent/dash/Initialize()
	. = ..()
	ability = new(src)

/obj/item/lambent/dash/attack_self(mob/user)
	visible_message("<span class='notice'>[user] dissipates a flickering energy in their palm.</span>")
	src.dropped()

/obj/item/lambent/dash/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	ability.Teleport(user, target)

/obj/item/lambent/dash/pickup(mob/living/user)
	. = ..()
	ability.Grant(user)
	user.update_icons()

/obj/item/lambent/dash/dropped(mob/user)
	. = ..()
	ability.Remove(user)
	user.update_icons()
	QDEL_IN(src, 1)

//datum/action/innate/lambent/dash/ability //This is what poor planning with code gets you. Use a proc_holder next time -Dahl

/datum/action/innate/lambent/dash/Trigger()
	//This is effectively an on/off state of the ability.
	holder.visible_message("PH Trigger Initial")
	if(holder.get_active_held_item() == null)
		if(var/active == 0) //Start off
			holder.visible_message("PH Trigger to Activate")
			Activate()
			active = 1 //set to 1 so we can toggle off
			return
		if(var/active == 1)
			holder.visible_message("PH Trigger to Deactivate")
			Deactivate()
			active = 0 //set to 0 so we can toggle on
			return
	holder.visible_message("PH active held item return")
	return


/datum/action/innate/lambent/dash/Activate()
	holder.visible_message("PH Activation")
	holder.equip_to_slot_if_possible(new/obj/item/lambent/dash(null), SLOT_HANDS)

/datum/action/innate/lambent/dash/Deactivate()
	holder.visible_message("PH Deactivation")
	if(holder.get_item_by_slot(SLOT_HANDS) == /obj/item/lambent/dash)
		holder.dropItemToGround(/obj/item/lambent/dash)


/* Leaving this here as a toggled ability to reference later.
/datum/action/innate/lambent/dash/Trigger()
	holder.visible_message("PH Trigger Initial")
	switch(active)
		if(0) //Start off
			holder.visible_message("PH Trigger to Activate")
			Activate()
			active = 1 //set to 1 so we can toggle off
		if(1)
			holder.visible_message("PH Trigger to Deactivate")
			Deactivate()
			active = 0 //set to 0 so we can toggle on

/datum/action/innate/lambent/dash/Activate()
	holder.visible_message("PH Activation")

/datum/action/innate/lambent/dash/Deactivate()
	holder.visible_message("PH Deactivation")
*/

/*
/datum/action/innate/lambent/dash/IsAvailable()
	if(current_charges > 0)
		return TRUE
	else
		return FALSE
*/

//something something dash.Teleport(user,)


/datum/action/innate/lambent/dash/proc/Teleport(mob/user, atom/target)
	if(!IsAvailable())
		return
	var/turf/T = get_turf(target)
	if(target in view(user.client.view, user))
		var/obj/spot1 = new phaseout(get_turf(user), user.dir)
		user.forceMove(T)
		playsound(T, dash_sound, 25, 1)
		var/obj/spot2 = new phasein(get_turf(user), user.dir)
		spot1.Beam(spot2,beam_effect,time=20)
		current_charges--
		holder.update_action_buttons_icon()
		addtimer(CALLBACK(src, .proc/charge), charge_rate)

/datum/action/innate/lambent/dash/proc/charge()
	current_charges = CLAMP(current_charges + 1, 0, max_charges)
	holder.update_action_buttons_icon()
	if(recharge_sound)
		playsound(holder, recharge_sound, 50, 1)
	to_chat(holder, "<span class='notice'>[src] now has [current_charges]/[max_charges] charges.</span>")
*/
