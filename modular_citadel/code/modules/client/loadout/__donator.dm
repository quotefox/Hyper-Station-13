//This is the file that handles donator loadout items.


/datum/gear/pingcoderfailsafe
	name = "IF YOU SEE THIS, PING A CODER RIGHT NOW!"
	category = SLOT_IN_BACKPACK
	path = /obj/item/bikehorn/golden
	ckeywhitelist = list("This entry should never appear with this variable set.") //If it does, then that means somebody fucked up the whitelist system pretty hard

/datum/gear/testreward
	//Just so admins can test the recent rewards added.
	name = "Caveman Plush"
	category = SLOT_IN_BACKPACK
	path = /obj/item/toy/plush/mammal/grug
	ckeywhitelist = list("quotefox")

/datum/gear/testrewardtwo
	name = "Napoleonic Uniform"
	category = SLOT_IN_BACKPACK
	path = /obj/item/clothing/suit/napoleonic
	ckeywhitelist = list("quotefox")

/datum/gear/winterblooplush
	name = "Will Plush"
	category = SLOT_IN_BACKPACK
	path = /obj/item/toy/plush/mammal/winterbloo
	ckeywhitelist = list("wolfy_wolf967")

/datum/gear/winterblooplushextra
	//for some reason bloo has had issues with his plushie
	name = "Will Plush"
	category = SLOT_IN_BACKPACK
	path = /obj/item/toy/plush/mammal/winterbloo
	ckeywhitelist = list("wolfywolf967")

/datum/gear/helioplush
	name = "Chris Plushie"
	category = SLOT_IN_BACKPACK
	path = /obj/item/toy/plush/lizardplushie/chris
	ckeywhitelist = list("heliocintrini")

/datum/gear/seramarker
	name = "Blueberry Marker"
	category = SLOT_IN_BACKPACK
	path = /obj/item/pen/bluemarker
	ckeywhitelist = list("blooberri")

/datum/gear/hubertsuit
	name = "Napoleonic Uniform"
	category = SLOT_IN_BACKPACK
	path = /obj/item/clothing/suit/napoleonic
	ckeywhitelist = list("hackertdog")

/datum/gear/grug
	name = "Caveman Plushie"
	category = SLOT_IN_BACKPACK
	path = /obj/item/toy/plush/mammal/grug
	ckeywhitelist = list("herrdoktah")
