/datum/supply_pack/service/stripperpole
	name = "Stripper Pole Crate"
	desc = "No private bar is complete without a stripper pole, show off the goods! Comes with a ready-to-assemble stripper pole, and a complementary wrench to get things set up!"
	cost = 3550
	contains = list(/obj/item/polepack/,
					/obj/item/wrench/)
	crate_name = "stripper pole crate"

/datum/supply_pack/organic/donkpockets
    name = "Donkpocket Shipment"
    desc = "We at Donk corp provide a wide five selection of holovid ready dinner pockets for all your dietary needs from extra-cheese to vegan to even mothpeople. Product of Donk co."
    cost = 1500
    contains = list()
    crate_name = "Donk Crate"
    crate_type = /obj/structure/closet/crate/freezer
    var/num_contained = 5
    //Put the types you want to contain inside this list below.
    var/can_contain = list( /obj/item/storage/box/donkpockets,
                            /obj/item/storage/box/donkpockets/donkpockettaco,
                            /obj/item/storage/box/donkpockets/donkpocketplasma,
                            /obj/item/storage/box/donkpockets/donkpocketbreakfast,
                            /obj/item/storage/box/donkpockets/donkpocketmoth,
                            /obj/item/storage/box/donkpockets/donkpocketvegan,
                            /obj/item/storage/box/donkpockets/donkpocketspicy,
                            /obj/item/storage/box/donkpockets/donkpocketteriyaki,
                            /obj/item/storage/box/donkpockets/donkpocketpizza,
                            /obj/item/storage/box/donkpockets/donkpocketberry,
                            /obj/item/storage/box/donkpockets/donkpockethonk
    )

/datum/supply_pack/organic/donkpockets/fill(obj/structure/closet/crate/C)
    contains = list()
    for(var/i = 0; i < num_contained; i++)
        contains += pick(can_contain)
    . = ..()