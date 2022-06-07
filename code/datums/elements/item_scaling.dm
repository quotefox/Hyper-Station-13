/**
 * Element for making items change scaling depending on if they appear in the world or in a storage container.
 * 
 * For context, overworld items are anything on a turf, storage scaling includes anywhere that the item is used as a UI element.
 * Scaling should affect the target's icon and any affecting overlays
 */
/datum/element/item_scaling
	element_flags = ELEMENT_BESPOKE
	id_arg_index = 2
	/// Value to scale the target by when it's in the overworld (on a turf)
	var/overworld_scaling = 1
	/// Value to scale the target by when it's in a storage component or inventory slot
	var/storage_scaling = 1

/datum/element/item_scaling/Attach(datum/target, overworld_scaling = 1, storage_scaling = 1)
	. = ..()
	if(!isatom(target))
		return ELEMENT_INCOMPATIBLE

	src.overworld_scaling = overworld_scaling
	src.storage_scaling = storage_scaling
	
	scale(target, overworld_scaling)

	RegisterSignal(target, list(COMSIG_ITEM_DROPPED, COMSIG_STORAGE_EXITED), .proc/scale_overworld)
	RegisterSignal(target, list(COMSIG_ITEM_EQUIPPED, COMSIG_STORAGE_ENTERED), .proc/scale_storage)

/datum/element/item_scaling/proc/scale(atom/source, scaling)
	var/matrix/M = matrix()
	source.transform = M.Scale(scaling)

/// Signal handler for when the item is dropped
/datum/element/item_scaling/proc/scale_overworld(datum/source)
	scale(source, overworld_scaling)

/// Signal handler for when the item is picked up
/datum/element/item_scaling/proc/scale_storage(datum/source)
	scale(source, storage_scaling)
