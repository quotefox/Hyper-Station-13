/obj/item/organ/genital/anus
	name 					= "anus"
	desc 					= ""
	zone 					= "groin"
	slot 					= "anus"
	w_class 				= 3
	size 					= 0
	var/statuscheck			= FALSE
	masturbation_verb 		= "massage"
	can_climax				= FALSE //no poo poo 4 u
	nochange				= TRUE


/obj/item/organ/genital/anus/Initialize()
	. = ..()

/obj/item/organ/genital/anus/on_life()
	if(QDELETED(src))
		return
	if(!owner)
		return




