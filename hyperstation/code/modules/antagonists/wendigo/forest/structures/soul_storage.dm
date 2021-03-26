/obj/structure/soul_storage
	name = "soul storage"
	desc = "Stores souls!"
	var/list/souls = list()

//This is a big WIP. I don't even want it having the name "soul storage" but it'll do for now

/obj/structure/soul_storage/Initialize()
	. = ..()
	GLOB.wendigo_soul_storages += src

/obj/structure/soul_storage/Destroy()
	GLOB.wendigo_soul_storages -= src
	return ..()
