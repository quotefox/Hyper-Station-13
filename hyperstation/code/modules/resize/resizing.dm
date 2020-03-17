//LETS GET THIS FUCKING SIZECONTENT GAMERS
var/const/RESIZE_MACRO = 6
var/const/RESIZE_HUGE = 4
var/const/RESIZE_BIG = 2
var/const/RESIZE_NORMAL = 1
var/const/RESIZE_SMALL = 0.75
var/const/RESIZE_TINY = 0.50
var/const/RESIZE_MICRO = 0.25

//averages
var/const/RESIZE_A_MACROHUGE = (RESIZE_MACRO + RESIZE_HUGE) / 2
var/const/RESIZE_A_HUGEBIG = (RESIZE_HUGE + RESIZE_BIG) / 2
var/const/RESIZE_A_BIGNORMAL = (RESIZE_BIG + RESIZE_NORMAL) / 2
var/const/RESIZE_A_NORMALSMALL = (RESIZE_NORMAL + RESIZE_SMALL) / 2
var/const/RESIZE_A_SMALLTINY = (RESIZE_SMALL + RESIZE_TINY) / 2
var/const/RESIZE_A_TINYMICRO = (RESIZE_TINY + RESIZE_MICRO) / 2

//Scale up a mob's icon by the size_multiplier
/mob/living/update_transform()
	ASSERT(!iscarbon(src)) //the source isnt carbon should always be true
	var/matrix/M = matrix() //matrix (M) variable
	M.Scale(size_multiplier)
	M.Translate(0, 16*(size_multiplier-1)) //translate by 16 * size_multiplier - 1 on Y axis
	src.transform = M //the source of transform is M


/mob/proc/get_effective_size()
	return 100000

mob/living/get_effective_size()
	return src.size_multiplier

/mob/living/proc/resize(var/new_size, var/animate = TRUE)
	if(size_multiplier == new_size)
		return 1

	size_multiplier = new_size //Change size_multiplier so that other items can interact with them
	src.update_transform() //WORK DAMN YOU

//handle the big steppy, except nice
/mob/living/proc/handle_micro_bump_helping(var/mob/living/tmob)

	//Both small.
	if(src.get_effective_size() <= RESIZE_A_SMALLTINY && tmob.get_effective_size() <= RESIZE_A_SMALLTINY)
		now_pushing = 0
		src.forceMove(tmob.loc)
		return 1

	//Doing messages
	if(abs(get_effective_size()/tmob.get_effective_size()) >= 2) //if the initiator is twice the size of the micro
		now_pushing = 0
		src.forceMove(tmob.loc)

		//Smaller person being stepped on
		if(get_effective_size() > tmob.get_effective_size() && iscarbon(src))
			if(istype(tmob) && istype(tmob, /datum/sprite_accessory/taur/naga))
				to_chat(src,"<span class='notice'>You carefully slither around [tmob].</span>")
				to_chat(tmob,"<span class='notice'>[src]'s huge tail slithers beside you!</span>")
			else
				to_chat(src,"<span class='notice'>You carefully step over [tmob].</span>")
				to_chat(tmob,"<span class='notice'>[src] steps over you carefully!</span>")
			return 1

	//Smaller person stepping under a larger person
	if(tmob.get_effective_size() > get_effective_size())
		micro_step_under(tmob)
		src.forceMove(tmob.loc)
		now_pushing = 0
		return 1

//Stepping on disarm intent
/mob/living/proc/handle_micro_bump_other(var/mob/living/tmob)
	ASSERT(isliving(tmob))

	//Both small
	if(src.get_effective_size() <= RESIZE_A_SMALLTINY && tmob.get_effective_size() <= RESIZE_A_SMALLTINY)
		now_pushing = 0
		src.forceMove(tmob.loc)
		return 1

	if(abs(get_effective_size()/tmob.get_effective_size()) >= 2)
		if(src.a_intent == "disarm" && src.canmove && !src.buckled)
			now_pushing = 0
			src.forceMove(tmob.loc)
			if(get_effective_size() > tmob.get_effective_size() && iscarbon(src))
				if(istype(tmob) && istype(tmob, /datum/sprite_accessory/taur/naga))
					to_chat(src,"<span class='danger'>You carefully roll over [tmob] with your tail!</span>")
					to_chat(tmob,"<span class='danger'>[src]'s huge tail rolls over you!</span>")
					sizediffStamLoss(tmob)
				else
					to_chat(src,"<span class='danger'>You painfully but harmlessly step on [tmob]!<span>")
					to_chat(tmob,"<span class='danger'>[src] steps onto you with force!</span>")
					sizediffStamLoss(tmob)
				return 1

		if(src.a_intent == "harm" && src.canmove && !src.buckled)
			now_pushing = 0
			src.forceMove(tmob.loc)
			if(get_effective_size() > tmob.get_effective_size() && iscarbon(src))
				if(istype(tmob) && istype(tmob, /datum/sprite_accessory/taur/naga))
					to_chat(src,"<span class='danger'>You grind [tmob] into the floor with your tail!</span>")
					to_chat(tmob,"<span class='danger'>[src]'s massive tail plows you into the floor!</span>")
					sizediffStamLoss(tmob)
					sizediffBruteloss(tmob)
				else
					to_chat(src,"<span class='danger'>You pound [tmob] into the floor underfoot!</span>")
					to_chat(tmob,"<span class='danger'>[src] slams you into the ground, crushing you!</span>")
					sizediffStamLoss(tmob)
					sizediffBruteloss(tmob)
				return 1

//		if(src.a_inent == "grab"... goes here

	if(tmob.get_effective_size() > get_effective_size())
		micro_step_under(tmob)
		src.forceMove(tmob.loc)
		now_pushing = 0
		return 1

//smaller person stepping under another person
/mob/living/proc/micro_step_under(var/mob/living/tmob)
	if(istype(tmob) && istype(tmob, /datum/sprite_accessory/taur/naga))
		to_chat(src,"<span class='notice'>You jump over [tmob]'s thick tail.</span>")
		to_chat(tmob,"<span class='notice'>[src] bounds over your tail.</span>")
	else
		to_chat(src,"<span class='notice'>You run between [tmob]'s legs.</span>")
		to_chat(tmob,"<span class='notice'>[src] runs between your legs.</span>")

//Proc for scaling stamina damage on size difference
/mob/living/proc/sizediffStamLoss(var/mob/living/tmob)
	var/S = (get_effective_size()/tmob.get_effective_size()*25) //macro divided by micro, times 25
	tmob.Knockdown(S) //final result in stamina knockdown

//Proc for scaling brute damage on size difference
/mob/living/proc/sizediffBruteloss(var/mob/living/tmob)
	var/B = (get_effective_size()/tmob.get_effective_size()*2) //macro divided by micro, times 2
	tmob.adjustBruteLoss(B) //final result in brute loss

//Proc for picking up people. WIP.
/*
/mob/living/proc/attempt_to_scoop(var/mob/living/M)
	var/sizediv = get_effective_size()/M.get_effective_size()
	if(!holder_default && holder_type)
		holder_default = holder_type
	if(!istype(M))
		return 0
	if(buckled)
		to_chat(src,"<span class='notice'>You have to unbuckle them before you can pick them up.</span>")
		return 0
	if(sizediv >= 2)
		holder_type = /obj/item/holder/micro
		var/obj/item/holder/m_holder = get_scooped(M)
		holder_type = holder_default
		if (m_holder)
			return 1
		else
			return 0
*/

//Clothes coming off at different sizes, and health/speed/stam changes as well
