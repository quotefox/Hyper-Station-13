/obj/item/wallframe/light_fixture/fairy
	name = "fairy lights frame"
	icon_state = "fairy-construct-item"
	result_path = /obj/structure/light_construct/fairy
	materials = list(MAT_METAL=MINERAL_MATERIAL_AMOUNT)

/obj/structure/light_construct/fairy
	name = "fairy lights frame"
	icon_state = "fairy-construct-stage1"
	fixture_type = "fairy"
	sheets_refunded = 1

/obj/machinery/light/fairy
	icon_state = "fairy"
	base_state = "fairy"
	fitting = "fairy"
	brightness = 3
	desc = "Small fairy lights."
	//light_type = /obj/item/light/fairy

/obj/machinery/light/fairy/broken
	status = LIGHT_BROKEN
	icon_state = "fairy-broken"

/obj/machinery/light/fairy/built
	icon_state = "bulb-empty"

/obj/machinery/light/fairy/built/Initialize()
	. = ..()
	status = LIGHT_EMPTY
	update(0)
