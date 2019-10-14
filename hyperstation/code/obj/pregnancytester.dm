/obj/item/pregnancytest
	name 				= "pregnancy test"
	desc 				= "a one time use small device, used to determine if someone is pregnant or not. Also comes with a force feature to freak out your ex (alt click)."
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


/obj/item/pregnancytest/AltClick(mob/living/user)
	if(QDELETED(src))
		return
	if(!isliving(user))
		return
	if(isAI(user))
		return
	if(user.stat > 0)//unconscious or dead
		return //Already been used once, pregnancy tests only work once.
	if(status == 1)
		return
	force(user)

/obj/item/pregnancytest/proc/force(mob/living/user)
	//just for fun or roleplay, force it.
	results = "positive"
	icon_state 	= "positive"
	status = 1
	name = "[results] pregnancy test"
	to_chat(user, "<span class='notice'>You force the device to read possive.</span>")



/obj/item/pregnancytest/proc/test(mob/living/user)
//This is where the pregancy checker would be, if and when pregnancy is coded. SO we can always assume the person is not pregnant because there is no code for it.
	results = "negative"
	icon_state 	= "negative"
	name = "[results] pregnancy test"
	status = 1
	to_chat(user, "<span class='notice'>You use the pregnancy test, after a pause one pink line lights up on the display, reading negative.</span>")
