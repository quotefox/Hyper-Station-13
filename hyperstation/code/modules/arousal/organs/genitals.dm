/obj/item/organ/genital/proc/get_fluid_source()
	if(producing)
		return src.reagents
	if(linked_organ && linked_organ.producing)
		return linked_organ.reagents
	return null