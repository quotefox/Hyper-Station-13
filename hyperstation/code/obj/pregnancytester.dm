/obj/item/pregnancytest
	name 				= "pregnancy test"
	desc 				= "A one time use small device, used to determine whether someone is pregnant or not."
	icon 				= 'hyperstation/icons/obj/pregnancytest.dmi'
	throwforce			= 0
	icon_state 			= "ptest"
	var/status			= 0
	var/results 		= "null"
	w_class = WEIGHT_CLASS_TINY

/obj/item/pregnancytest/attack_self(mob/user)
	if(QDELETED(src))
		return
	if(!isliving(user))
		return
	if(isAI(user))
		return
	if(user.stat > CONSCIOUS)//unconscious or dead
		return
	Test(user)

/obj/item/pregnancytest/proc/Test(mob/living/user)
	if(status)
		return
	var/_result = FALSE
	var/obj/item/organ/genital/womb/W = user.getorganslot("womb")
	if(!W)
		return // no reason to waste the single-use on them
	if(W.pregnant)
		_result = TRUE
	UpdateResult(user, _result)

/obj/item/pregnancytest/proc/UpdateResult(mob/living/user, _result)
	var/result_text = _result ? "positive" : "negative"
	results = result_text
	icon_state = result_text
	name = "[results] preganancy test"
	status = TRUE
	if(user)
		to_chat(user, "<span class='notice'>You use the pregnancy test, the display reads [results]!</span>")	