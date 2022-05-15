//This file is empty right now, but leaves room for people to put shit here in the future for those who are lazy
/mob/living/silicon/robot
	var/datum/action/cyborg_small_sprite/small_sprite_action	//This gets replaced every time the cyborg changes modules --Cyanosis

//Main code edits

/mob/living/silicon/robot
	var/obj/item/pda/ai/aiPDA //TODO: Refractor the whole PDA system to be on /mob/living/silicon and add the pda functions of all the other silicons from /tg/

/mob/living/silicon/robot/Initialize(mapload)
	. = ..()
	if(!shell)
		aiPDA = new/obj/item/pda/ai(src)
		aiPDA.owner = real_name
		aiPDA.ownjob = "Cyborg"
		aiPDA.name = real_name + " (" + aiPDA.ownjob + ")"

/mob/living/silicon/robot/replace_identification_name(oldname, newname)
	if(aiPDA && !shell)
		aiPDA.owner = newname
		aiPDA.name = newname + " (" + aiPDA.ownjob + ")"
