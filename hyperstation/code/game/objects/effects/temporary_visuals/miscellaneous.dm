//Via LC13

/obj/effect/temp_visual/saw_effect
	name = "saw"
	icon_state = "claw"
	duration = 4

/obj/effect/temp_visual/green_noon_reload
	name = "recharging field"
	icon = 'hyperstation/icons/mobs/48x48.dmi'
	icon_state = "green_bot_reload_effect"
	layer = BELOW_MOB_LAYER
	pixel_x = -8
	//base_pixel_x = -8
	duration = 8

/obj/effect/temp_visual/green_noon_reload/Initialize()
	..()
	animate(src, alpha = 0, transform = transform*1.5, time = duration)
