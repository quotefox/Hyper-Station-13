/obj/machinery/reagentgrinder/reagentblender
	name = "Stand mixer"
	desc = "a stationary electric mixer for heavy-duty mixing various foods and other reagents."
	icon = 'hyperstation/icons/obj/machinery/reagentblender.dmi'
	icon_state = "mixer1"

/obj/machinery/reagentgrinder/reagentblender/update_icon()
	if(beaker)
		icon_state = "mixer1"
	else
		icon_state = "mixer0"