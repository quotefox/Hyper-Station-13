// Citadel's Vtech Controller
/obj/effect/proc_holder/silicon/cyborg/vtecControl
	name = "vTec Control"
	desc = "Allows finer-grained control of the vTec speed boost."
	action_icon = 'icons/mob/actions.dmi'
	action_icon_state = "Chevron_State_0"

	var/currentState = 0
	var/iteration = FALSE


/obj/effect/proc_holder/silicon/cyborg/vtecControl/Click(mob/living/silicon/robot/user = usr)
	currentState = (currentState + 1) % 3

	if(usr)
		if (!user.cell) //If we run out of power, make the module not work.
			to_chat(user, "<span class='warning'>You cannot cycle through your VTEC upgrade while you don't have power!</span>")
			currentState = 0
		if (user.cell) if (user.cell.charge <= 200)
			to_chat(user, "<span class='warning'>You cannot cycle through your VTEC upgrade while you don't have power!</span>")
			currentState = 0
			user.cell.charge = 0
		
		switch(currentState)
			if (0)
				user.add_movespeed_modifier(MOVESPEED_ID_SILICON_VTEC, override=TRUE, multiplicative_slowdown = (user.emagged*1.5))
			if (1)
				user.add_movespeed_modifier(MOVESPEED_ID_SILICON_VTEC, override=TRUE, multiplicative_slowdown = -0.15*((user.emagged/2)+1))
			if (2)
				user.add_movespeed_modifier(MOVESPEED_ID_SILICON_VTEC, override=TRUE, multiplicative_slowdown = -0.325*((user.emagged/2)+1))

	action.button_icon_state = "Chevron_State_[currentState]"
	action.UpdateButtonIcon()

	return

/obj/effect/proc_holder/silicon/cyborg/vtecControl/proc/useCharge(mob/living/silicon/robot/user)
	if (!user) return
	if (user.emagged && currentState && prob(20) && user.cell && user.cell.charge > 200)
		currentState = 2	//Sets to 0 after Click() is called
		Click(user)
		if (!iteration)
			to_chat(user, "<span class='warning'>Your VTEC upgrade malfunctions!</span>")
		iteration = !iteration	//So we don't spam the player with warnings
	
	if (user.cell)
		if (user.cell.charge <= 200)
			user.add_movespeed_modifier(MOVESPEED_ID_SILICON_VTEC, override=TRUE, multiplicative_slowdown = (user.emagged*1.5))
			user.cell.charge = 0
			action.button_icon_state = "Chevron_State_0"
			action.UpdateButtonIcon()
			return
		user.cell.charge -= round(15*(rand((currentState*2)+user.emagged, (currentState*2)+(1.1*(user.emagged+1)))))//rand(5.0, 6.2)
		return
	action.button_icon_state = "Chevron_State_0"
	action.UpdateButtonIcon()
