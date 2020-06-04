/obj/item/pregnancytest
	name 				= "Pregnancy Tester"
	desc 				= "A one time use small device that tells the user whether or not they're pregnant."
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
	if(user.stat > 0)//unconscious or dead
		return
	if(status == 1)
		return //Already been used once, pregnancy tests only work once.
	test(user)

/obj/item/pregnancytest/proc/force(mob/living/user)
	//Force it negative
	icon_state 	= "negative"
	name = "[results] pregnancy test"
	status = 1
	to_chat(user, "<span class='notice'>You use the pregnancy test, the display reads negative!</span>")


/obj/item/pregnancytest/proc/test(mob/living/user)

	var/obj/item/organ/genital/womb/W = user.getorganslot("womb")
	if(W.pregnant == 1)
		results = "positive"
		icon_state 	= "positive"
		name = "[results] pregnancy test"
		status = 1
		to_chat(user, "<span class='notice'>You use the pregnancy test, the display reads positive!</span>")
	else
		force(user)
