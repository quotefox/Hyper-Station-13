//his isn't a subtype of the syringe gun because the syringegun subtype is made to hold syringes
//this is meant to hold reagents/obj/item/gun/syringe
/obj/item/gun/chem
	name = "reagent gun"
	desc = "A Kinaris syringe gun, modified to automatically synthesise chemical darts, and instead hold reagents."
	icon_state = "chemgun"
	item_state = "chemgun"
	w_class = WEIGHT_CLASS_NORMAL
	throw_speed = 3
	throw_range = 7
	force = 4
	materials = list(MAT_METAL=2000)
	clumsy_check = FALSE
	fire_sound = 'sound/items/syringeproj.ogg'
	var/time_per_syringe = 250
	var/syringes_left = 4
	var/max_syringes = 4
	var/last_synth = 0

/obj/item/gun/chem/Initialize()
	. = ..()
	chambered = new /obj/item/ammo_casing/chemgun(src)
	START_PROCESSING(SSobj, src)
	create_reagents(100, OPENCONTAINER)

/obj/item/gun/chem/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/gun/chem/can_shoot()
	return syringes_left

/obj/item/gun/chem/process_chamber()
	if(chambered && !chambered.BB && syringes_left)
		chambered.newshot()

/obj/item/gun/chem/process()
	if(syringes_left >= max_syringes)
		return
	if(world.time < last_synth+time_per_syringe)
		return
	to_chat(loc, "<span class='warning'>You hear a click as [src] synthesizes a new dart.</span>")
	syringes_left++
	if(chambered && !chambered.BB)
		chambered.newshot()
	last_synth = world.time

//Chemlight was here, adding dumb busing things

/obj/item/gun/chem/debug
	name = "experimental reagent gun"
	desc =	"a reagent gun seemingly made to be a part of the user, suggesting the individual generates reagents in their body for it to work."
	icon_state = "syringe_pistol"
	item_state = "gun" //Smaller inhand
	suppressed = TRUE //Softer fire sound
	can_unsuppress = FALSE //Permanently silenced
	time_per_syringe = 150		
	syringes_left = 6
	max_syringes = 6
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/infinite = FALSE

/obj/item/gun/chem/debug/Initialize()
	. = ..()
	chambered = new /obj/item/ammo_casing/chemgun_debug(src)
	START_PROCESSING(SSobj, src)
	create_reagents(100, OPENCONTAINER | NO_REACT)

/obj/item/gun/chem/debug/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/gun/chem/debug/attack_self(mob/user)
	var/choose_operation = input(user, "Select an option", "Reagent fabricator", "cancel") in list("Select reagent", "Enable production", "Cancel")
	if (choose_operation == "Select reagent")
		reagents.clear_reagents()
		var/chosen_reagent
		switch(alert(usr, "Choose a method.", "Add Reagents", "Search", "Choose from a list", "I'm feeling lucky"))
			if("Search")
				var/valid_id
				while(!valid_id)
					chosen_reagent = input(usr, "Enter the ID of the reagent you want to add.", "Search reagents") as null|text
					if(isnull(chosen_reagent)) //Get me out of here!
						break
					if(!ispath(text2path(chosen_reagent)))
						chosen_reagent = pick_closest_path(chosen_reagent, make_types_fancy(subtypesof(/datum/reagent)))
						if(ispath(chosen_reagent))
							valid_id = TRUE
					else
						valid_id = TRUE
					if(!valid_id)
						to_chat(usr, "<span class='warning'>A reagent with that ID doesn't exist!</span>")
			if("Choose from a list")
				chosen_reagent = input(usr, "Choose a reagent to add.", "Choose a reagent.") as null|anything in subtypesof(/datum/reagent)
			if("I'm feeling lucky")
				chosen_reagent = pick(subtypesof(/datum/reagent))
		if(chosen_reagent)
			reagents.add_reagent(chosen_reagent, 100, null)

	else if (choose_operation == "Enable production")
		if(!infinite)
			infinite = TRUE
			to_chat(user, "Now constantly generating reagents.")
		else
			infinite = FALSE
			to_chat(user, "Reagents generation now off.")

	else
		return
