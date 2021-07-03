/datum/gear/med_briefcase
	name = "Medical Briefcase"
	category = SLOT_HANDS
	path = /obj/item/storage/briefcase/medical
	restricted_roles = list("Medical Doctor", "Chief Medical Officer")

/datum/gear/stethoscope
	name = "Stethoscope"
	category = SLOT_NECK
	path = /obj/item/clothing/neck/stethoscope
	restricted_roles = list("Medical Doctor", "Chief Medical Officer")

/datum/gear/bluescrubs
	name = "Blue Scrubs"
	category = SLOT_W_UNIFORM
	path = /obj/item/clothing/under/rank/medical/blue
	restricted_roles = list("Medical Doctor", "Chief Medical Officer", "Geneticist", "Chemist", "Virologist")
	restricted_desc = "Medical"

/datum/gear/greenscrubs
	name = "Green Scrubs"
	category = SLOT_W_UNIFORM
	path = /obj/item/clothing/under/rank/medical/green
	restricted_roles = list("Medical Doctor", "Chief Medical Officer", "Geneticist", "Chemist", "Virologist")
	restricted_desc = "Medical"

/datum/gear/purplescrubs
	name = "Purple Scrubs"
	category = SLOT_W_UNIFORM
	path = /obj/item/clothing/under/rank/medical/purple
	restricted_roles = list("Medical Doctor", "Chief Medical Officer", "Geneticist", "Chemist", "Virologist")
	restricted_desc = "Medical"

/datum/gear/coat_med
	name = "Medical winter coat"
	category = SLOT_WEAR_SUIT
	path = /obj/item/clothing/suit/hooded/wintercoat/medical
	restricted_roles = list("Medical Doctor", "Chief Medical Officer", "Geneticist", "Chemist", "Virologist")
	restricted_desc = "Medical"

/datum/gear/coat_cmo
	name = "Chief Medical Officer's winter coat"
	category = SLOT_WEAR_SUIT
	path = /obj/item/clothing/suit/hooded/wintercoat/cmo
	restricted_roles = list("Chief Medical Officer")

/datum/gear/coat_viro
	name = "Virology winter coat"
	category = SLOT_WEAR_SUIT
	path = /obj/item/clothing/suit/hooded/wintercoat/viro
	restricted_roles = list("Virologist")

/datum/gear/coat_chem
	name = "Chemistry winter coat"
	category = SLOT_WEAR_SUIT
	path = /obj/item/clothing/suit/hooded/wintercoat/chemistry
	restricted_roles = list("Chemist")
