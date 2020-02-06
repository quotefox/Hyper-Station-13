/obj/item/pregnancytest
	name = "pregnancy test"
	desc = "a one time use small device, used to determine if someone is pregnant or not."
	icon = 'modular_hyperstation/icons/obj/pregnancytest.dmi'
	icon_state = "ptest"
	throwforce= 0
	w_class = WEIGHT_CLASS_TINY
	var/used = FALSE

/obj/item/pregnancytest/attack_self(mob/living/user)
	if(QDELETED(src))
		return
	if(!istype(user) || isAI(user) || user.stat > CONSCIOUS)//unconscious or dead
		return
	if(used)
		return //Already been used once, pregnancy tests only work once.

	var/obj/item/organ/genital/womb/W = user.getorganslot("womb")
	if(W.pregnant)
		icon_state = "positive"
		name = "pregnancy test - positive"
		to_chat(user, "<span class='notice'>You use the pregnancy test, the display reads positive!</span>")
	else //Force it negative
		icon_state 	= "negative"
		name = "pregnancy test - negative"
		to_chat(user, "<span class='notice'>You use the pregnancy test, the display reads negative!</span>")
	used = TRUE
