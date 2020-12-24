//This file is to show off what "interesting" things the seeds' mutatespecie() proc could do, done by DragonTrance

/obj/item/seeds/sample/chaos_mushroom
	name = "Chaos Mushroom"
	item_flags = ABSTRACT | DANGEROUS_POSSESSION	//Don't want people getting their hands on this from the xmas tree
	mutate_factor = PLANT_MUTATE_CANNOTMUTATE

/obj/item/seeds/sample/chaos_mushroom/mutatespecie()
	. = ..()
	message_admins(":)")
	ex_act(EXPLODE_HEAVY, src)
