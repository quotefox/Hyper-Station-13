/datum/element/trash
	element_flags = ELEMENT_DETACH

/datum/element/trash/Attach(datum/target)
	. = ..()
	RegisterSignal(target, COMSIG_ITEM_ATTACK, .proc/UseFromHand)

/datum/element/trash/proc/UseFromHand(obj/item/source, mob/living/M, mob/living/user)
	if((M == user || M.client?.prefs.cit_toggles & TRASH_FORCEFEED) && ishuman(user))
		var/mob/living/carbon/human/H = M
		if(HAS_TRAIT(H, TRAIT_TRASHCAN))
			playsound(H.loc,'sound/items/eatfood.ogg', rand(10,50), 1)
			if(H.vore_selected)
				if(M != user)
					H.visible_message("<span class='warning'>[user] forces the [source] into [H]'s [H.vore_selected]</span>",
						"<span class='warning'>[user] forces the [source] into your [H.vore_selected]</span>")
				else
					H.visible_message("<span class='notice'>[H] [H.vore_selected.vore_verb]s the [source] into their [H.vore_selected]</span>",
						"<span class='notice'>You [H.vore_selected.vore_verb] the [source] into your [H.vore_selected]</span>")
				source.forceMove(H.vore_selected)
			else
				H.visible_message("<span class='notice'>[H] consumes the [source].")
				qdel(source)
