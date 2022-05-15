mob/living/silicon
//Commented out, as you can utilise both sleepers /and/ the menu. This stops others from actually doing anything of the latter, AI or otherwise.
// Even more interestingly, there's stuff /for/ them doing the act, so this is vestigial. If I'm not mistaken, anyhow.
//	no_vore = TRUE

/mob/living/silicon/robot
	var/dogborg = FALSE

/mob/living/silicon/robot/lay_down()
	..()
	update_canmove()

/mob/living/silicon/robot/update_canmove()
	..()
	if(client && stat != DEAD && dogborg == TRUE)
		if(resting)
			cut_overlays()
			icon_state = "[module.cyborg_base_icon]-rest"
		else
			icon_state = "[module.cyborg_base_icon]"
	update_icons()

/mob/living/silicon/robot/adjustStaminaLossBuffered(amount, updating_stamina = 1)
	if(istype(cell))
		cell.charge -= amount*5
