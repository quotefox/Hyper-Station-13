/datum/design/ipc_liver
	name = "IPC Reagent Processor"
	id = "ipc_liver"
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 2000, MAT_GLASS = 1000)
	build_path = /obj/item/organ/liver/ipc
	category = list("Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL
	construction_time = 100

/datum/design/ipc_eyes
	name = "IPC Eyes"
	id = "ipc_eyes"
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 1000, MAT_GLASS = 2000)
	build_path = /obj/item/organ/eyes/ipc
	category = list("Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL
	construction_time = 100

/datum/design/ipc_tongue
	name = "Positronic Voicebox"
	id = "ipc_tongue"
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 2000, MAT_GLASS = 1000)
	build_path = /obj/item/organ/tongue/robot/ipc
	category = list("Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL
	construction_time = 100

/datum/design/ipc_stomach
	name = "Micro-cell"
	id = "ipc_stomach"
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 2000, MAT_GLASS = 1000, MAT_PLASMA = 200)
	build_path = /obj/item/organ/stomach/cell
	category = list("Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL
	construction_time = 100

/datum/design/synthliz_stomach
	name = "Synthetic Lizardperson Stomach"
	id = "synthliz_stomach"
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 2000, MAT_GLASS = 1000)
	build_path = /obj/item/organ/stomach/synthliz
	category = list("Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL
	construction_time = 100

/datum/design/power_cord
	name = "IPC Power Cord"
	id = "power_cord"
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 2000, MAT_GLASS = 1000)
	build_path = /obj/item/organ/cyberimp/arm/power_cord
	category = list("Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL
	construction_time = 100


/datum/techweb_node/ipc_organs
	id = "ipc_organs"
	display_name = "IPC Parts"
	description = "We have the technology to replace him."
	prereq_ids = list("cyber_organs","robotics")
	design_ids = list("ipc_liver", "ipc_eyes", "ipc_tongue", "ipc_stomach", "synthliz_stomach", "power_cord")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1500)
	export_price = 5000
