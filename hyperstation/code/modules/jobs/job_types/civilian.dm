/datum/job/barista
	title = "Barista"
	flag = BARISTA
	department_head = list("Head of Personnel")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#bbe291"

	outfit = /datum/outfit/job/barista

	access = list(ACCESS_HYDROPONICS, ACCESS_BARISTA, ACCESS_KITCHEN, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_BARISTA, ACCESS_MINERAL_STOREROOM)

/datum/outfit/job/barista
	name = "Barista"
	jobtype = /datum/job/barista

	belt = /obj/item/pda/bar
	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/lawyer/blacksuit
	suit = /obj/item/clothing/suit/toggle/lawyer/black
	backpack_contents = list(/obj/item/book/granter/action/drink_fling=1, /obj/item/clothing/accessory/waistcoat)
	shoes = /obj/item/clothing/shoes/laceup

/datum/job/barber
	title = "Barber"
	flag = BARBER
	department_head = list("Head of Personnel")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 2
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#bbe291"

	outfit = /datum/outfit/job/barber

	access = list(ACCESS_BARBER)
	minimal_access = list(ACCESS_BARBER)

/datum/outfit/job/barber
	name = "Barber"
	jobtype = /datum/job/barber

	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/headset_srv
	belt = /obj/item/pda
	uniform = /obj/item/clothing/under/barber
	shoes = /obj/item/clothing/shoes/laceup
