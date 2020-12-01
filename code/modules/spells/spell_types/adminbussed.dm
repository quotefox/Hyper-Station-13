// Testing things
/obj/effect/proc_holder/spell/self/Alteration_Mechanical
	name = "Alter figure"
	desc = "Change and alter your physical form."  
	human_req = 1
	clothes_req = 0
	charge_max = 100
	cooldown_min = 50
	action_icon = 'icons/mob/actions/actions_changeling.dmi'
	action_icon_state = "ling_transform"
	action_background_icon_state = "bg_spell"
	still_recharging_msg = "<span class='notice'>Your reagents are still recharging.</span>"
	invocation = null //what is uttered when the wizard casts the spell
	invocation_emote_self = null
	school = null
	sound = 'sound/effects/pop.ogg'
	var/datum/effect_system/spark_spread/sparks = new /datum/effect_system/spark_spread
	var/pshoom_or_beepboopblorpzingshadashwoosh = 'sound/items/rped.ogg'

/obj/effect/proc_holder/spell/self/Alteration_Mechanical/cast(mob/living/carbon/human/user)
	var/mob/living/carbon/human/H = user
	var/list/reagent_options = sortList(GLOB.chemical_reagents_list)
	H.visible_message("<span class='notice'> [user] gains a look of \
	concentration while standing perfectly still.\
	Their body seems to shift and starts reshaping itself.</span>",
	"<span class='notice'>You focus intently on altering your body while \
	standing perfectly still...</span>")
	var/select_alteration = input(user, "Select what part of your form to alter", "Form Alteration", "cancel") in list("Genitals", "Penis", "Vagina", "Penis Length", "Breast Size", "Penis Production", "Breast Production", "Alter Height",  "Cancel")
	do_sparks(5, FALSE, user.loc)
	if (select_alteration == "Genitals")
		var/list/organs = list()
		var/operation = input("Select organ operation.", "Organ Manipulation", "cancel") in list("add sexual organ", "remove sexual organ", "cancel")
		switch(operation)
			if("add sexual organ")
				var/new_organ = input("Select sexual organ:", "Organ Manipulation") in list("Penis", "Testicles", "Breasts", "Vagina", "Womb", "Cancel")
				if(new_organ == "Penis")
					H.give_penis()
				else if(new_organ == "Testicles")
					H.give_balls()
				else if(new_organ == "Breasts")
					H.give_breasts()
				else if(new_organ == "Vagina")
					H.give_vagina()
				else if(new_organ == "Womb")
					H.give_womb()
				else
					return
			if("remove sexual organ")
				for(var/obj/item/organ/genital/X in H.internal_organs)
					var/obj/item/organ/I = X
					organs["[I.name] ([I.type])"] = I
				var/obj/item/organ = input("Select sexual organ:", "Organ Manipulation", null) in organs
				organ = organs[organ]
				if(!organ)
					return
				var/obj/item/organ/genital/O
				if(isorgan(organ))
					O = organ
					O.Remove(H)
				organ.forceMove(get_turf(H))
				qdel(organ)
				H.update_genitals()
    
	else if (select_alteration == "Penis")
		for(var/obj/item/organ/genital/penis/X in H.internal_organs)
			qdel(X)
		var/new_shape
		new_shape = input(user, "Choose your character's dong", "Genital Alteration") as null|anything in GLOB.cock_shapes_list
		if(new_shape)
			H.dna.features["cock_shape"] = new_shape
		H.update_genitals()
		H.give_balls()
		H.give_penis()
		H.apply_overlay()

	else if (select_alteration == "Vagina")
		for(var/obj/item/organ/genital/vagina/X in H.internal_organs)
			qdel(X)
		var/new_shape
		new_shape = input(user, "Choose your character's pussy", "Genital Alteration") as null|anything in GLOB.vagina_shapes_list
		if(new_shape)
			H.dna.features["vag_shape"] = new_shape
		H.update_genitals()
		H.give_womb()
		H.give_vagina()
		H.apply_overlay()

	else if (select_alteration == "Penis Length")
		for(var/obj/item/organ/genital/penis/X in H.internal_organs)
			qdel(X)
		var/new_length
		new_length = input(user, "Penis length in inches:\n([COCK_SIZE_MIN]-[COCK_SIZE_MAX])", "Genital Alteration") as num|null
		if(new_length)
			H.dna.features["cock_length"] = max(min( round(text2num(new_length)), COCK_SIZE_MAX),COCK_SIZE_MIN)
		H.update_genitals()
		H.apply_overlay()
		H.give_balls()
		H.give_penis()

	else if (select_alteration == "Breast Size")
		for(var/obj/item/organ/genital/breasts/X in H.internal_organs)
			qdel(X)
		var/new_size
		new_size = input(user, "Breast Size", "Genital Alteration") as null|anything in GLOB.breasts_size_list
		if(new_size)
			H.dna.features["breasts_size"] = new_size
		H.update_genitals()
		H.apply_overlay()
		H.give_breasts()

	else if (select_alteration == "Penis Production")
		if(!H.getorganslot("testicles"))
			to_chat(user, "You need functioning breasts for this to work.")
		else
			for(var/obj/item/organ/genital/testicles/X in H.internal_organs)
				var/new_fluid_penis
				switch(alert(usr, "Choose a method.", "Add Reagents", "Enter ID", "Choose ID"))
					if("Enter ID")
						var/valid_id
						while(!valid_id)
							new_fluid_penis = stripped_input(usr, "Enter the ID of the reagent you want to add to your testicles.")
							if(!new_fluid_penis) //Get me out of here!
								break
							for(var/ID in reagent_options)
								if(ID == new_fluid_penis)
									valid_id = 1
							if(!valid_id)
								to_chat(usr, "<span class='warning'>A reagent with that ID doesn't exist!</span>")
					if("Choose ID")
						new_fluid_penis = input(usr, "Choose a reagent to add to your testicles.", "Choose a reagent.") as null|anything in reagent_options
				if(new_fluid_penis)
					X.fluid_id = new_fluid_penis

	else if(select_alteration == "Breast Production")   
		if(!H.getorganslot("breasts"))
			to_chat(user, "You need functioning breasts for this to work.")
		else
			for(var/obj/item/organ/genital/breasts/X in H.internal_organs)
				var/new_fluid_breasts
				switch(alert(usr, "Choose a method.", "Add Reagents", "Enter ID", "Choose ID"))
					if("Enter ID")
						var/valid_id
						while(!valid_id)
							new_fluid_breasts = stripped_input(usr, "Enter the ID of the reagent you want to add to your breasts.")
							if(!new_fluid_breasts) //Get me out of here!
								break
							for(var/ID in reagent_options)
								if(ID == new_fluid_breasts)
									valid_id = 1
							if(!valid_id)
								to_chat(usr, "<span class='warning'>A reagent with that ID doesn't exist!</span>")
					if("Choose ID")
						new_fluid_breasts = input(usr, "Choose a reagent to add to your breasts.", "Choose a reagent.") as null|anything in reagent_options
				if(new_fluid_breasts)
					X.fluid_id = new_fluid_breasts

	else if (select_alteration == "Alter Height")
		var/altered_height
		altered_height = input(user, "Choose your desired sprite size:\n([MIN_BODYSIZE]-400%)", "Height Alteration") as num|null
		if(altered_height)
			H.size_multiplier = (max(min( round(text2num(altered_height)),400),MIN_BODYSIZE))/100
			playsound(user.loc, pshoom_or_beepboopblorpzingshadashwoosh, 40, 1)
			do_sparks(5, FALSE, user.loc)
			H.visible_message("<span class='danger'>[pick("[H] shifts in size!", "[H] alters in height!", "[H] reshapes into a new stature!")]</span>")

	else
		return