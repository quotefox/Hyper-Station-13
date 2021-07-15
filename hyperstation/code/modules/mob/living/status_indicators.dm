//Ported from virgo, with some touch ups to make it work with our code.

/mob/living
	var/list/status_indicators = null // Will become a list as needed.

/mob/living/proc/add_status_indicator(mutable_appearance/thing)
	if(get_status_indicator(thing))
		return

	if(!istype(thing, /mutable_appearance))
		thing = mutable_appearance('hyperstation/icons/mob/status_indicators.dmi', icon_state = thing)

	LAZYADD(status_indicators, thing)
	handle_status_indicators()

/mob/living/proc/remove_status_indicator(mutable_appearance/thing)
	thing = get_status_indicator(thing)

	cut_overlay(thing)
	LAZYREMOVE(status_indicators, thing)
	handle_status_indicators()

/mob/living/proc/get_status_indicator(mutable_appearance/thing)
	if(!istype(thing, /mutable_appearance))
		for(var/mutable_appearance/I in status_indicators)
			if(I.icon_state == thing)
				return I
	return LAZYACCESS(status_indicators, LAZYFIND(status_indicators, thing))

/mob/living/proc/handle_status_indicators()
	// First, get rid of all the overlays.
	for(var/thing in status_indicators)
		cut_overlay(thing)

	if(!LAZYLEN(status_indicators))
		return

	if(stat == DEAD)
		return

	// Now the indicator row can actually be built.
	for(var/thing in status_indicators)
		var/mutable_appearance/I = thing

		I.appearance_flags = PIXEL_SCALE|KEEP_APART
		I.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
		I.plane = HUD_PLANE
		I.layer = ABOVE_FLY_LAYER
		I.pixel_y = 18
		I.pixel_x = 18
		add_overlay(I)
