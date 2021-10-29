/obj/item/reagent_containers/food/snacks/grown/coconut/hardened //Exclusively used by the selfcharging version
	name = "hardened coconut"
	desc = "just like a regular coconut, except this one was probably sitting in a freezer too."
	force = 5
	throwforce = 8

/obj/item/pneumatic_cannon/coconut //Basically almost a complete mirror of the pie cannon.
	name = "coconut cannon"
	desc = "Co co nut."
	force = 10
	gasPerThrow = 0
	pressureSetting = 2 //bonk
	checktank = FALSE
	range_multiplier = 3
	fire_mode = PCANNON_FIFO
	throw_amount = 1
	maxWeightClass = 180	//60 coconuts.
	clumsyCheck = FALSE
	var/static/list/coconut_typecache = typecacheof(/obj/item/reagent_containers/food/snacks/grown/coconut)

/obj/item/pneumatic_cannon/coconut/Initialize()
	. = ..()
	allowed_typecache = coconut_typecache

/obj/item/pneumatic_cannon/coconut/selfcharge
	desc = "Co co nut. This one seems to have an integrated bluespace coconut self-charging device."
	automatic = TRUE
	selfcharge = TRUE
	pressureSetting = 2	//bonk
	charge_type = /obj/item/reagent_containers/food/snacks/grown/coconut/hardened
	maxWeightClass = 60	//20 coconuts.
