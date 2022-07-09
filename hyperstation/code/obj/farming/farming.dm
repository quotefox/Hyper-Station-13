/obj/item/reagent_containers/food/snacks/grown/wheat/
	var stacktype = /obj/item/stack/tile/hay
	var/tile_coefficient = 0.02 // same as grass

/obj/item/reagent_containers/food/snacks/grown/wheat/attack_self(mob/user)
	to_chat(user, "<span class='notice'>You prepare the hay bedding.</span>")
	var/grassAmt = 1 + round(seed.potency * tile_coefficient) // The grass we're holding
	for(var/obj/item/reagent_containers/food/snacks/grown/wheat/G in user.loc) // The grass on the floor
		if(G.type != type)
			continue
		grassAmt += 1 + round(G.seed.potency * tile_coefficient)
		qdel(G)
	new stacktype(user.drop_location(), grassAmt)
	qdel(src)


/obj/structure/nestbox
	name = "nest box"
	icon = 'hyperstation/icons/obj/hydroponics/farming.dmi'
	icon_state = "nestbox"
	desc = "A little nest box, for collecting eggs"
	density = FALSE
	anchored = TRUE

/obj/structure/nestbox/wrench_act(mob/living/user, obj/item/I)
	user.visible_message("<span class='warning'>[user] disassembles [src].</span>",
		"<span class='notice'>You start to disassemble [src]...</span>", "You hear clanking and banging noises.")
	if(I.use_tool(src, user, 20, volume=50))
		new /obj/item/stack/sheet/mineral/wood (loc, 4)
		qdel(src)