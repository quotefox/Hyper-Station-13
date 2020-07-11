//I am not a coder. Please fucking tear apart my code, and insult me for how awful I am at coding. Please and thank you. -Dahlular
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
	src.update_mobsize() //Doesn't work yet

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
	if(ishuman(src))
		var/mob/living/carbon/human/H = src

		//Both small.
		if(H.get_effective_size() <= RESIZE_A_SMALLTINY && tmob.get_effective_size() <= RESIZE_A_SMALLTINY)
			now_pushing = 0
			H.forceMove(tmob.loc)
			return 1

		//Doing messages
		if(abs(get_effective_size()/tmob.get_effective_size()) >= 2) //if the initiator is twice the size of the micro
			now_pushing = 0
			H.forceMove(tmob.loc)

			//Smaller person being stepped on
			if(get_effective_size() > tmob.get_effective_size() && iscarbon(src))
				if(istype(H) && H.dna.features["taur"] == "Naga" || H.dna.features["taur"] == "Tentacle")
					to_chat(H,"<span class='notice'>You carefully slither around [tmob].</span>")
					to_chat(tmob,"<span class='notice'>[H]'s huge tail slithers beside you!</span>")
				else
					to_chat(H,"<span class='notice'>You carefully step over [tmob].</span>")
					to_chat(tmob,"<span class='notice'>[H] steps over you carefully!</span>")
				return 1

			//Smaller person stepping under a larger person
			if(abs(tmob.get_effective_size()/get_effective_size()) <= 2)
				H.forceMove(tmob.loc)
				now_pushing = 0
				micro_step_under(tmob)
				return 1

//Stepping on disarm intent -- TO DO, OPTIMIZE ALL OF THIS SHIT
/mob/living/proc/handle_micro_bump_other(var/mob/living/tmob)
	ASSERT(isliving(tmob))
	if(ishuman(src))
		var/mob/living/carbon/human/H = src

	//Both small
		if(H.get_effective_size() <= RESIZE_A_SMALLTINY && tmob.get_effective_size() <= RESIZE_A_SMALLTINY)
			now_pushing = 0
			H.forceMove(tmob.loc)
			return 1

		if(abs(get_effective_size()/tmob.get_effective_size()) >= 2)
			if(H.a_intent == "disarm" && H.canmove && !H.buckled)
				now_pushing = 0
				H.forceMove(tmob.loc)
				sizediffStamLoss(tmob)
				if(get_effective_size() > tmob.get_effective_size() && iscarbon(H))
					if(istype(H) && H.dna.features["taur"] == "Naga" || H.dna.features["taur"] == "Tentacle")
						to_chat(H,"<span class='danger'>You carefully roll over [tmob] with your tail!</span>")
						to_chat(tmob,"<span class='danger'>[H]'s huge tail rolls over you!</span>")
					else
						to_chat(H,"<span class='danger'>You painfully but harmlessly step on [tmob]!<span>")
						to_chat(tmob,"<span class='danger'>[H] steps onto you with force!</span>")
					return 1

			if(H.a_intent == "harm" && H.canmove && !H.buckled)
				now_pushing = 0
				H.forceMove(tmob.loc)
				sizediffStamLoss(tmob)
				sizediffBruteloss(tmob)
				if(get_effective_size() > tmob.get_effective_size() && iscarbon(H))
					if(istype(H) && H.dna.features["taur"] == "Naga" || H.dna.features["taur"] == "Tentacle")
						to_chat(H,"<span class='danger'>You grind [tmob] into the floor with your tail!</span>")
						to_chat(tmob,"<span class='danger'>[H]'s massive tail plows you into the floor!</span>")
					else
						to_chat(H,"<span class='danger'>You pound [tmob] into the floor underfoot!</span>")
						to_chat(tmob,"<span class='danger'>[H] slams you into the ground, crushing you!</span>")
					return 1

			if(H.a_intent == "grab" && H.canmove && !H.buckled)
				now_pushing = 0
				H.forceMove(tmob.loc)
				sizediffStamLoss(tmob)
				sizediffStun(tmob)
				if(get_effective_size() > tmob.get_effective_size() && iscarbon(H))
					var/feetCover = (H.wear_suit && (H.wear_suit.body_parts_covered & FEET)) || (H.w_uniform && (H.w_uniform.body_parts_covered & FEET) || (H.shoes && (H.shoes.body_parts_covered & FEET)))
					if(feetCover)
						if(istype(H) && H.dna.features["taur"] == "Naga" || H.dna.features["taur"] == "Tentacle")
							to_chat(H,"<span class='danger'>You pin [tmob] underneath your tail!</span>")
							to_chat(tmob,"<span class='danger'>[H]'s plows you into the ground, pinning you helplessly!</span>")
						else
							to_chat(H,"<span class='danger'>You pin [tmob] helplessly to the floor with your foot!</span>")
							to_chat(tmob,"<span class='danger'>[H] weightfully pins you to the ground!</span>")
						return 1
					else
						if(istype(H) && H.dna.features["taur"] == "Naga" || H.dna.features["taur"] == "Tentacle")
							to_chat(H,"<span class='danger'>You curl [tmob] up in the coils of your tail!</span>")
							to_chat(tmob,"<span class='danger'>[H]'s tail winds around you and snatches you in its coils!</span>")
							tmob.mob_pickup_micro_feet(H)
						else
							to_chat(H,"<span class='danger'>You stomp your foot into [tmob], curling your toes and picking them up!</span>")
							to_chat(tmob,"<span class='danger'>[H]'s toes pin you down and curl around you, picking you up!</span>'")
							tmob.mob_pickup_micro_feet(H)
						return 1

			if(abs(tmob.get_effective_size()/get_effective_size()) <= 2)
				H.forceMove(tmob.loc)
				now_pushing = 0
				micro_step_under(tmob)
				return 1

//smaller person stepping under another person... TO DO, fix and allow special interactions with naga legs to be seen
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

//Proc for scaling stuns on size difference (for grab intent)
/mob/living/proc/sizediffStun(var/mob/living/tmob)
	var/T = (get_effective_size()/tmob.get_effective_size()*15) //Macro divided by micro, times 15
	tmob.Stun(T)

//Proc for scaling brute damage on size difference
/mob/living/proc/sizediffBruteloss(var/mob/living/tmob)
	var/B = (get_effective_size()/tmob.get_effective_size()*2) //macro divided by micro, times 2
	tmob.adjustBruteLoss(B) //final result in brute loss

//Proc for changing mob_size to be grabbed for item weight classes
/mob/living/proc/update_mobsize()
	if(size_multiplier <= 0.50)
		mob_size = MOB_SIZE_TINY
	if(size_multiplier <= 1)
		mob_size = MOB_SIZE_SMALL
	if(size_multiplier >= 2)
		mob_size = MOB_SIZE_LARGE
			
//Proc for instantly grabbing valid size difference. Code optimizations soon(TM)
/*
/mob/living/proc/sizeinteractioncheck(var/mob/living/tmob)
	if(abs(get_effective_size()/tmob.get_effective_size())>=2.0 && get_effective_size()>tmob.get_effective_size())
		return 0
	else
		return 1
*/
//Clothes coming off at different sizes, and health/speed/stam changes as well
