//Farm things
/turf/open/floor/
	var/farm_quality = 0 //all tiles have a farm quality, which is for farm animals to enjoy. 0 = worse 100 = best!

//Grass quality
/turf/open/floor/grass
	farm_quality = 50

/turf/open/floor/grass/fairy
	farm_quality = 70

//Hay
/obj/item/stack/tile/hay
	name = "hay bedding tile"
	singular_name = "hay bedding tile"
	desc = "A patch of bundled hay."
	icon  = 'hyperstation/icons/obj/tiles.dmi'
	icon_state = "tile_hay"
	item_state = "tile_hay"
	turf_type = /turf/open/floor/grass/hay
	resistance_flags = FLAMMABLE

/turf/open/floor/grass/hay //like grass
	name = "hay bedding"
	icon = 'hyperstation/icons/obj/hydroponics/harvest.dmi'
	desc = "A patch of bundled hay, to help keep animals happy."
	icon_state = "hay"
	farm_quality = 100 //the best for farming!
	floor_tile = /obj/item/stack/tile/hay

//Carpets
/obj/item/stack/tile/carpet/kinaris
	name = "gilded carpet"
	icon = 'hyperstation/icons/obj/tiles.dmi'
	icon_state = "tile-carpet-kinaris"
	turf_type = /turf/open/floor/carpet/kinaris
	tableVariant = /obj/structure/table/wood/fancy/kinaris
