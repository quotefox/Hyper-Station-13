/datum/gear/coat_qm
	name = "Quartermaster's winter coat"
	category = SLOT_WEAR_SUIT
	path = /obj/item/clothing/suit/hooded/wintercoat/qm
	restricted_roles = list("Quartermaster")

/datum/gear/coat_cargo
	name = "Cargo winter coat"
	category = SLOT_WEAR_SUIT
	path = /obj/item/clothing/suit/hooded/wintercoat/cargo
	restricted_roles = list("Chief Medical Officer", "Shaft Miner", "Cargo Technician")
	restricted_desc = "Cargo"

/datum/gear/coat_miner
	name = "Mining winter coat"
	category = SLOT_WEAR_SUIT
	path = /obj/item/clothing/suit/hooded/wintercoat/miner
	restricted_roles = list("Quartermaster", "Miner")