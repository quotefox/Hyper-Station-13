//Small Sprite for borgs --Cyanosis
//Basically the same as /small_sprite, but i'm screaming for modularization
/datum/action/cyborg_small_sprite
	name = "Toggle Giant Sprite"
	desc = "Others will continue to see you giant."
	icon_icon = 'icons/obj/plushes.dmi'
	button_icon_state = "securityk9"
	background_icon_state = "bg_default_on"	//looks techy enough
	var/designated_module as text
	var/small = FALSE
	var/small_icon = null
	var/small_icon_state = null
	var/image/icon_image
	var/i_am_wide = FALSE	//transform stuff so we appear in the middle of a tile instead of between two WHEN PLUSHIE

/datum/action/cyborg_small_sprite/k9	//turns you into a marketable plushie
	designated_module = "Security K-9 Unit"
	small_icon = 'icons/obj/plushes.dmi'
	small_icon_state = "securityk9"
	i_am_wide = TRUE

/datum/action/cyborg_small_sprite/medihound
	designated_module = "MediHound"
	small_icon = 'icons/obj/plushes.dmi'
	small_icon_state = "medihound"
	i_am_wide = TRUE

/datum/action/cyborg_small_sprite/scrubpup
	designated_module = "Scrub Pup"
	small_icon = 'icons/obj/plushes.dmi'
	small_icon_state = "scrubpuppy"
	i_am_wide = TRUE

/datum/action/cyborg_small_sprite/Grant(mob/M)
	..()
	if(!owner)
		return
	update_image()
	RegisterSignal(owner, COMSIG_CYBORG_MODULE_CHANGE, .proc/update_image)

/datum/action/cyborg_small_sprite/Remove(mob/M)
	UnregisterSignal(owner, COMSIG_CYBORG_MODULE_CHANGE)
	..()

/datum/action/cyborg_small_sprite/Trigger()
	if(!icon_image)
		update_image()
	if(!small)
		owner.add_alt_appearance(/datum/atom_hud/alternate_appearance/basic, "cyborg_smallsprite", icon_image)
	else
		owner.remove_alt_appearance("cyborg_smallsprite")
	small = !small
	return TRUE

/datum/action/cyborg_small_sprite/proc/update_image()
	var/image/I
	if(small_icon && small_icon_state)
		I = image(icon=small_icon,icon_state=small_icon_state,loc=owner,layer=owner.layer,pixel_x=owner.pixel_x,pixel_y=owner.pixel_y)
	else
		I = image(icon=owner.icon,icon_state=owner.icon_state,loc=owner,layer=owner.layer,pixel_x=owner.pixel_x,pixel_y=owner.pixel_y)
		I.overlays = owner.overlays
	var/matrix/M = matrix()	//I don't understand why, I don't want to know why, but this matrix is needed
	M.Scale(0.5)		//If you ever change the borg's size, be sure to change this too
	M.Translate(8*i_am_wide, -8)	//x position is for WIDE borgs. If they're not wide, this doesn't matter
	I.transform = M		//also why do images have transforms
	I.override = TRUE
	icon_image = I
