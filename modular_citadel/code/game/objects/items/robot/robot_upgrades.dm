// Citadel's Vtech Controller
/obj/effect/proc_holder/silicon/cyborg/vtecControl
	name = "vTec Control"
	desc = "Allows finer-grained control of the vTec speed boost."
	action_icon = 'icons/mob/actions.dmi'
	action_icon_state = "Chevron_State_0"

	var/currentState = 0
	var/iteration = FALSE


/obj/effect/proc_holder/silicon/cyborg/vtecControl/Click(mob/living/silicon/robot/user = usr)
	if(!user)
		return
	if(!user.cell)
		return

	if(user.cell.charge <= 0)
		to_chat(user, "<span class='warning'>You cannot cycle through your VTEC upgrade without power!</span>")
		return

	currentState = (currentState + 1) % 3
	switch(currentState)
		if (0)
			user.remove_movespeed_modifier(MOVESPEED_ID_SILICON_VTEC)
		if (1)
			user.add_movespeed_modifier(MOVESPEED_ID_SILICON_VTEC, override=TRUE, multiplicative_slowdown = -0.15)
		if (2)
			user.add_movespeed_modifier(MOVESPEED_ID_SILICON_VTEC, override=TRUE, multiplicative_slowdown = -0.325)

	action.button_icon_state = "Chevron_State_[currentState]"
	action.UpdateButtonIcon()
	return

/obj/effect/proc_holder/silicon/cyborg/vtecControl/proc/useCharge(mob/living/silicon/robot/user)
	if (!user || !user.cell || !iscyborg(user))	//sanity check
		return

	var/removed_charge = 15*currentState

	if (user.cell.charge > removed_charge)
		user.cell.charge -= removed_charge
		return

	user.cell.charge = 0
	user.remove_movespeed_modifier(MOVESPEED_ID_SILICON_VTEC)
	action.button_icon_state = "Chevron_State_0"
	action.UpdateButtonIcon()
