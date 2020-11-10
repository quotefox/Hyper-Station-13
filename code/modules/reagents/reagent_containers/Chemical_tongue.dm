// This is more or less my funny tongue being being coded in. - Ken

/obj/item/reagent_containers/chemical_tongue
	name = "synthetic reagent tongue"
	desc = "A cybernetic organ with the ability to produce reagents, neat!"
	icon = 'icons/mob/dogborg.dmi'
	icon_state = "synthtongue"
	amount_per_transfer_from_this = 5
	volume = 200
	possible_transfer_amounts = list()
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	spillable = FALSE
	splashable = FALSE
	reagent_flags = OPENCONTAINER | NO_REACT
	var/list/fun_ids = list("growthchem", "shrinkchem", "aphro", "aphro+", "penis_enlarger", "breast_enlarger", "space_drugs", "lithium")

/obj/item/reagent_containers/chemical_tongue/attack(mob/M, mob/user, obj/target)
	if(user.a_intent == INTENT_HARM && user.zone_selected == BODY_ZONE_PRECISE_MOUTH)
		if(M != user)
			M.visible_message("<span class='danger'>[user] locks their lips with [M], attempting to give a deep kiss to [M].</span>", \
						"<span class='userdanger'>[user] locks their lips with yours, you feel what might be a tongue pushing past your lips then towards your throat!</span>")
			if(!do_mob(user, M, 80))
				return
			playsound(M.loc,'sound/effects/attackblob.ogg', rand(10,50), 1)
			if(isliving(M))
				var/mob/living/deepkiss = M
				deepkiss.adjustOxyLoss(10)
			if(!reagents || !reagents.total_volume)
				M.visible_message("<span class='warning'>[user] pulls away from the kiss as their tongue in [M]'s mouth soon follows, slurping back into [user]'s muzzle.</span>", \
							"<span class='userwarning'>[user] thrusts their tongue down your throat! Pulling it back up as it slithers up then out from your mouth.</span>")
				return // The drink might be empty after the delay, such as by spam-feeding
			M.visible_message("<span class='warning'>[user] pulls away from the kiss as their tongue in [M]'s mouth soon follows, slurping back into [user]'s muzzle, leaving a long strand of liquid from their lips to [M]'s own before wiping it away.</span>", \
							"<span class='userwarning'>[user] thrusts their tongue down your throat! Pulling it back up as it slithers up then out from your mouth. You feel a strange liquid in your throat!</span>")
			log_combat(user, M, "fed", reagents.log_list())
			var/fraction = min(5/reagents.total_volume, 1)
			reagents.reaction(M, INGEST, fraction)
			addtimer(CALLBACK(reagents, /datum/reagents.proc/copy_to, M, 10), 5)
		
	if(user.a_intent == INTENT_GRAB && user.zone_selected == BODY_ZONE_PRECISE_MOUTH)
		if(M != user)
			M.visible_message("<span class='warning'>[user] lightly places their lips on [M]'s providing a kiss.</span>", \
						"<span class='userwarning'>[user] lightly places their lips against your, you can feel tongue pushing against your lips in the kiss.</span>")
			if(!do_mob(user, M, 40))
				return
			playsound(M.loc,'sound/effects/attackblob.ogg', rand(10,50), 1)
			if(!reagents || !reagents.total_volume)
				M.visible_message("<span class='warning'>[user] breaks away from the kiss with [M]'s.</span>", \
						"<span class='userwarning'>[user] rolls their tongue around the inside of your mouth, before pulling away.</span>")
				return // The drink might be empty after the delay, such as by spam-feeding
			M.visible_message("<span class='warning'>[user] breaks away from the kiss with [M]'s.</span>", \
						"<span class='userwarning'>[user] rolls their tongue around the inside of your mouth, before pulling away. You can almost taste something as [user]'s tongue was laced in something.</span>")
			log_combat(user, M, "fed", reagents.log_list())
			var/fraction = min(5/reagents.total_volume, 1)
			reagents.reaction(M, INGEST, fraction)
			addtimer(CALLBACK(reagents, /datum/reagents.proc/copy_to, M, 5), 5)

	if(user.a_intent == INTENT_DISARM && user.zone_selected == BODY_ZONE_PRECISE_MOUTH)
		if(M != user)
			M.visible_message("<span class='warning'>[user] attempts nuzzles into [M]'s.</span>", \
						"<span class='userwarning'>[user] attempts to bump his snout against yours.</span>")
			if(!do_mob(user, M, 10))
				return
			playsound(M.loc,'sound/effects/attackblob.ogg', rand(10,50), 1)
			if(!reagents || !reagents.total_volume)
				M.visible_message("<span class='warning'>[user] playfully licks over [M]'s lips.</span>", \
							"<span class='userwarning'>[user] playfully licks over your lips.</span>")
				return // The drink might be empty after the delay, such as by spam-feeding
			M.visible_message("<span class='warning'>[user] playfully licks over [M]'s lips.</span>", \
							"<span class='userwarning'>[user] playfully licks over your lips, leaving some chemicals along it.</span>")
			log_combat(user, M, "fed", reagents.log_list())
			var/fraction = min(5/reagents.total_volume, 1)
			reagents.reaction(M, INGEST, fraction)
			addtimer(CALLBACK(reagents, /datum/reagents.proc/copy_to, M, 1), 5)

	if(user.a_intent == INTENT_HELP)
		if(M != user && user.zone_selected == BODY_ZONE_PRECISE_MOUTH)
			M.visible_message("<span class='notice'>[user] affectionately licks [M]'s lips.</span>", \
						"<span class='userwarning'>[user] affectionately licks over your lips.</span>")
			playsound(M.loc,'sound/effects/attackblob.ogg', rand(10,50), 1)

		else
			if(M != user)
				M.visible_message("<span class='notice'>[user] affectionately licks [M].</span>", \
							"<span class='userwarning'>[user] affectionately licks over you.</span>")
				playsound(M.loc,'sound/effects/attackblob.ogg', rand(10,50), 1)
	else
		return

/obj/item/reagent_containers/chemical_tongue/attack_self(mob/user)
	var/chosen_reagent
	var/list/reagent_ids = sortList(GLOB.chemical_reagents_list)
	var/quick_select = input(user, "Select an option", "Press start") in list("Quick Select", "Debug", "Cancel")
	switch (quick_select)
		if("Quick Select")
			reagents.clear_reagents()
			amount_per_transfer_from_this = 5
				chosen_reagent = input(user, "What reagent do you want to dispense?") as null|anything in fun_ids
			if(chosen_reagent)
				reagents.add_reagent(chosen_reagent, 20, null)

		if("Debug")
			var/operation_selection = input(user, "Select an option", "Reagent fabricator", "cancel") in list("Select reagent", "Clear reagents", "Select transfer amount", "Cancel")
			switch (operation_selection)
				if("Select reagent")
					switch(alert(usr, "Choose a method.", "Add Reagents", "Enter ID", "Choose ID"))
						if("Enter ID")
							var/valid_id
							while(!valid_id)
								chosen_reagent = stripped_input(usr, "Enter the ID of the reagent you want to add.")
								if(!chosen_reagent) //Get me out of here!
									break
								for(var/ID in reagent_ids)
									if(ID == chosen_reagent)
										valid_id = 1
								if(!valid_id)
									to_chat(usr, "<span class='warning'>A reagent with that ID doesn't exist!</span>")
						if("Choose ID")
							chosen_reagent = input(usr, "Choose a reagent to add.", "Choose a reagent.") as null|anything in reagent_ids	
					if(chosen_reagent)
						reagents.add_reagent(chosen_reagent, 20, null)

				if("Clear reagents")
					reagents.clear_reagents()

				if("Select transfer amount")
					var/transfer_select = input(user, "Select the amount of reagents you'd like to transfer.", "Transfer amount") as num|null
					if(transfer_select)
						amount_per_transfer_from_this = max(min(round(text2num(transfer_select)),20),1)

		else
			return