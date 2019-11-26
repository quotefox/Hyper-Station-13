/obj/item/bodypart/proc/break_bone(dam_type = BRUTE)
	if(!owner)
		return FALSE
	var/mob/living/carbon/C = owner
	if(!dismemberable)
		return FALSE
	if(broken == 0) //Its not broken.
		C.visible_message("<span class ='danger'><B>[C]'s [src.name] contorts in an unnatural way!</B></span>")
		C.emote("scream")
		broken = 1
		disabled = 1
