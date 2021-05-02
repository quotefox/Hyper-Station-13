//This action is technically a duplicate of /action/small_sprite
//However, we do our own things...

/datum/action/sizecode_resize
	name = "Toggle Giant Sprite"
	desc = "Others will continue to see you giant."
	icon_icon = 'icons/mob/screen_gen_old.dmi'
	button_icon_state = "health1"		//You can change this if you want
	background_icon_state = "bg_alien"	//But keep this as a distinct background
	var/small = FALSE
	var/image/small_icon

/datum/action/sizecode_resize/Grant(mob/M, safety=FALSE)
	if(ishuman(M) && !safety)	//this probably gets called before a person gets overlays on roundstart, so try again
		if(!LAZYLEN(M.overlays))
			addtimer(CALLBACK(src, .proc/Grant, M, TRUE), 5)	//https://www.youtube.com/watch?v=QQ-aYZzlDeo
			return

	..()
	if(!owner)
		return
	var/image/I = image(icon=owner.icon,icon_state=owner.icon_state,loc=owner,layer=owner.layer,pixel_x=owner.pixel_x,pixel_y=owner.pixel_y)
	I.overlays += owner.overlays
	I.override = TRUE
	small_icon = I

/datum/action/sizecode_resize/Trigger()
	..()
	if(!small)
		owner.add_alt_appearance(/datum/atom_hud/alternate_appearance/basic, "sizecode_smallsprite", small_icon)
	else
		owner.remove_alt_appearance("sizecode_smallsprite")
	small = !small
	return TRUE
