//Add this component to things to make them 'glowy'
//(smh my head it just gives them an outline and randomizes the shit out of its animation)

/datum/component/glow_harmless
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS
	var/color = "#39ff1430" //Defaults to this color if a color is not given by addcomponent

/datum/component/glow_harmless/Initialize(_color)
	if(!istype(parent, /atom))
		CRASH("Something that wasn't an atom was given /datum/component/glow_harmless")

	//Let's make er glow
	//This relies on parent not being a turf or something. IF YOU CHANGE THAT, CHANGE THIS
	var/atom/movable/master = parent
	if(_color)
		color = _color
	master.add_filter("glow_harmless", 2, list("type" = "outline", "color" = color, "size" = 2))
	addtimer(CALLBACK(src, .proc/glow_loop, master), rand(1,19))//Things should look uneven
	START_PROCESSING(SSradiation, src)

/datum/component/glow_harmless/process()
	if(!prob(50))
		return

/datum/component/glow_harmless/Destroy()
	STOP_PROCESSING(SSradiation, src)
	var/atom/movable/master = parent
	master.remove_filter("glow_harmless")
	return ..()

/datum/component/glow_harmless/proc/glow_loop(atom/movable/master)
	var/filter = master.get_filter("glow_harmless")
	if(filter)
		animate(filter, alpha = 110, time = 15, loop = -1)
		animate(alpha = 40, time = 25)
		addtimer(CALLBACK(src, .proc/glow_loop, master), rand(1,19))
