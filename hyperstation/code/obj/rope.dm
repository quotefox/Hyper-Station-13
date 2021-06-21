//Jay
//TODO: Better sprites
//Rope
/obj/item/restraints/handcuffs/rope/ //Fun
	name = "soft rope"
	desc = "A comfortable rope that would be easy to slip out of if you needed. Kinky."
	breakouttime = 10 //Easy to break out. It's not for gaming.
	icon = 'hyperstation/icons/obj/rope.dmi'
	icon_state = "rope"
	item_state = "rope" //This sprite is in restraints.dmi until I figure out how to refrence somewhere else
	cuffsound = 'sound/weapons/cablecuff.ogg'
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	price = 2

/mob/living/proc/rope_add(source) //Check to see if the rope is on, and then add effects
	var/mob/living/carbon/M = source
	if(M.handcuffed)
		var/rope_message = pick("The rope is tightly tied onto you!")
		to_chat(M, "<span class='userlove'>[rope_message]</span>")
		M.min_arousal = 33
		M.arousal_rate += 2
	update_stat()

/mob/living/proc/rope_remove(list/sources, temp_min_arousal, temp_max_arousal, temp_arousal_rate) //Check to see it the rope is gone, and reset effects
	var/mob/living/carbon/M = sources
	if (!M.handcuffed)
		var/rope_message = pick("The rope has been removed!")
		to_chat(M, "<span class='notice'>[rope_message]</span>")
		M.min_arousal = temp_min_arousal
		M.max_arousal = temp_max_arousal
		M.arousal_rate = temp_arousal_rate
	update_stat()

/obj/item/restraints/handcuffs/rope/attack(mob/living/carbon/C, mob/living/user)
	. = ..()
	var/temp_min_arousal = C.min_arousal //Temp variables to hold original arousal values
	var/temp_max_arousal = C.max_arousal
	var/temp_arousal_rate = C.arousal_rate
	var/datum/callback/Cback = new(user, /mob/living/proc/rope_add, C)//Put the rope on
	addtimer(Cback, 6, TIMER_UNIQUE)//We are going to call this proc six seconds after the click. The rope tying takes 5 seconds
	var/datum/callback/Cback2 = new(user, /mob/living/proc/rope_remove, C, temp_min_arousal, temp_max_arousal, temp_arousal_rate)
	while(1) //Loop until break - Because I can't figure out any better way to do it.
		var/rope_emote = pick("moan", "blush")
		sleep(50) //5 second wait
		addtimer(Cback2, 1, TIMER_UNIQUE) //Just keep calling this timer proc
		if (prob(10))
			C.emote(rope_emote)
		if (!C.handcuffed)
			return //Break when the rope is removed

/datum/crafting_recipe/rope
	name = "Soft Rope"
	result = /obj/item/restraints/handcuffs/rope
	time = 40
	reqs = list(/obj/item/stack/sheet/cloth = 5)
	category = CAT_MISC
