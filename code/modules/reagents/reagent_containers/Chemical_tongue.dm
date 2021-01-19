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
	var/list/fun_ids = list(/datum/reagent/growthchem, /datum/reagent/shrinkchem, /datum/reagent/drug/aphrodisiac, /datum/reagent/drug/aphrodisiacplus, /datum/reagent/fermi/penis_enlarger, /datum/reagent/fermi/breast_enlarger, /datum/reagent/drug/space_drugs, /datum/reagent/lithium)

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
				deepkiss.adjustOxyLoss(5)
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
			reagents.reaction(M, TOUCH, fraction)
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

obj/item/reagent_containers/chemical_tongue/afterattack(obj/target, mob/user, proximity)
	. = ..()
	if(target.is_refillable()) //Something like a glass. Player probably wants to transfer TO it.
		if(!reagents.total_volume)
			to_chat(user, "<span class='warning'>[src] is empty!</span>")
			return

		if(target.reagents.holder_full())
			to_chat(user, "<span class='warning'>[target] is full.</span>")
			return

		var/trans = reagents.copy_to(target, amount_per_transfer_from_this)
		to_chat(user, "<span class='notice'>You transfer [trans] unit\s of the solution to [target] by drooling into it.</span>")

/obj/item/reagent_containers/chemical_tongue/attack_self(mob/user)
	var/chosen_reagent
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
			switch(operation_selection)
				if("Select reagent")
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
						reagents.add_reagent(chosen_reagent, 20, null)

				if("Clear reagents")
					reagents.clear_reagents()

				if("Select transfer amount")
					var/transfer_select = input(user, "Select the amount of reagents you'd like to transfer.", "Transfer amount") as num|null
					if(transfer_select)
						amount_per_transfer_from_this = max(min(round(text2num(transfer_select)),20),1)

		else
			return
