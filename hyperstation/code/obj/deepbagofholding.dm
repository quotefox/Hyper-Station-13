/obj/item/deepbackpack
	name = "deep bag of holding"
	desc = "A bluespace bag infused with astrogen, increasing the size of it's pocket dimension. It's huge!" 
	// Alternative descriptions: "Enslaved Tardis", "It's bigger on the inside", "Mobile ERP den", "Mobile dormitory", "Mini drug lab", e.t.c
	icon = 'icons/obj/storage.dmi'
	icon_state = "backpack"
	item_state = "backpack"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	resistance_flags = NONE
	max_integrity = 300

	var/datum/map_template/deepbluespace/linkedDimTemp
	var/datum/turf_reservation/linkedDim

	var/turf/open/entry

/obj/item/deepbackpack/Initialize()
	. = ..()

	// Sets up the minidimension and spawns it
	linkedDimTemp = new()
	linkedDim = SSmapping.RequestBlockReservation(linkedDimTemp.width, linkedDimTemp.height)
	linkedDimTemp.load(locate(linkedDim.bottom_left_coords[1], linkedDim.bottom_left_coords[2], linkedDim.bottom_left_coords[3]))
	var/area/deepbluespace/currentArea = get_area(locate(linkedDim.bottom_left_coords[1], linkedDim.bottom_left_coords[2], linkedDim.bottom_left_coords[3]))

	// Links the minidimension to the bag and vis-versa
	for(var/turf/open/indestructible/deepBluespaceExit/exit in currentArea)
		exit.parent = src
	entry =	locate(linkedDim.bottom_left_coords[1] + linkedDimTemp.landingZoneRelativeX, \
		    	  linkedDim.bottom_left_coords[2] + linkedDimTemp.landingZoneRelativeY, \
		   		  linkedDim.bottom_left_coords[3])

	// Start processing air and shit
	START_PROCESSING(SSobj, src)

// Called when we attack the bag with an item
/obj/item/deepbackpack/attackby(obj/item/I, mob/user, params)

	// Checks if this item has no drop, so you can't cheese it off your hand
	if(HAS_TRAIT(I, TRAIT_NODROP))
		to_chat(user, "<span class='warning'>\the [I] is stuck to your hand, you can't put it in \the [src]!</span>")
		return FALSE

	// Tells everyone about it
	for(var/mob/viewing in viewers(user, null))
		if(user == viewing)
			to_chat(user, "<span class='notice'>You put [I] into [src].</span>")
		else if(in_range(user, viewing)) //If someone is standing close enough, they can tell what it is...
			viewing.show_message("<span class='notice'>[user] puts [I] into [src].</span>", 1)
		else if(I && I.w_class >= 3) //Otherwise they can only see large or normal items from a distance...
			viewing.show_message("<span class='notice'>[user] puts [I] into [src].</span>", 1)

	// Inserting the item
	mobinsert(I, user)

// Called when we attack something with the bag
/obj/item/deepbackpack/afterattack(atom/movable/A, mob/user, proximity)

	// If we are not next to the item, or the atom isn't a movable type, then let's forget this ever happened
	if(!(proximity) || !isatom(A))
		return

	if(!(A.can_be_z_moved) || A.anchored)
		return

	// If this is a mob, we'll have a progress bar to make sure you're not spamming this everywhere and stuffing them into the bag
	if (ismob(A))
		var/mob/M = A
		user.visible_message("<span class='warning'>[user] tries to stuff [M] into [src].</span>", \
				 	 		 "<span class='warning'>You try to stuff [M] into [src].</span>")
		if(!do_mob(user, M)) // If they don't succeed, fuck 'em and return from this proc
			return
		user.visible_message("<span class='notice'>[user] stuffs [M] into [src].</span>", \
				 	 		 "<span class='notice'>You stuff [M] into [src].</span>")

		// Oh, and if they're holding the bag, drop it. Because otherwise you essentially trap yoruself
		if(src in M.contents)
			src.forceMove(M.loc)

	// Inserting the item
	mobinsert(A, user)

// Use this if a mob is inserting an item into the bag. This adds some animations and shit for the sake of it.
/obj/item/deepbackpack/proc/mobinsert(atom/movable/A, mob/user)
	playsound(src, "rustle", 50, 1, -5)
	do_jiggle()
	add_fingerprint(user)
	insert(A)

// Use this if you just want to put an item into the bag. This is the mechanical part.
/obj/item/deepbackpack/proc/insert(atom/movable/A)

	 // If this is in a mobs inventory, drop it.
	var/mob/M
	var/obj/item/I

	if(ismob(A.loc) && isitem(A))
		M = A.loc
		I = A

	// Move it to the dimension
	A.forceMove(entry)

	// Calling dropped after the move to make micros work. Life's tough ):
	if(ismob(M) && isitem(A))
		I.dropped(M)

/*/obj/item/deepbackpack/process()
	var/turf/T = get_turf(src)
	T.air.share(entry/air)*/


/turf/open/indestructible/deepBluespaceExit
    name = "Bluespace Tunnel"
    icon_state = "hoteldoor"
    explosion_block = INFINITY
    blocks_air = TRUE
    opacity = TRUE
    var/parent

/turf/open/indestructible/deepBluespaceExit/Entered(atom/movable/A)
    . = ..()
    A.forceMove(get_turf(parent))

/datum/map_template/deepbluespace
    name = "Deep Bluespace"
    mappath = '_maps/templates/deepbluespace.dmm'
    var/landingZoneRelativeX = 4
    var/landingZoneRelativeY = 7

/area/deepbluespace
    name = "Deep Bluespace"
    icon_state = "hilbertshotel"
    requires_power = TRUE
    has_gravity = TRUE
    noteleport = TRUE
    hidden = TRUE
