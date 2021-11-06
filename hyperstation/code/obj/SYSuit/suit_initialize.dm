/obj/item/clothing/under/syclothing/proc/toggle_on_off()
	if(s_busy)
		to_chat(loc, "<span class='userdanger'>ERROR</span>: You cannot use this function at this time.")
		return FALSE
	if(s_initialized)
		deinitialize()
	else
		ninitialize()
	. = TRUE

/obj/item/clothing/under/syclothing/proc/ninitialize(delay = s_delay, mob/living/carbon/human/U = loc)
	if(!U.mind)
		return //Not sure how this could happen.
	s_busy = TRUE
	to_chat(U, "<span class='notice'>Now initializing...</span>")
	addtimer(CALLBACK(src, .proc/ninitialize_two, delay, U), delay)

/obj/item/clothing/under/syclothing/proc/ninitialize_two(delay, mob/living/carbon/human/U)
	if(!lock_suit(U))//To lock the suit onto wearer.
		s_busy = FALSE
		return
	to_chat(U, "<span class='notice'>Analyzing body composition and data...\nSecuring external locking mechanism...</span>")
	addtimer(CALLBACK(src, .proc/ninitialize_three, delay, U), delay)

/obj/item/clothing/under/syclothing/proc/ninitialize_three(delay, mob/living/carbon/human/U)
	to_chat(U, "<span class='notice'>Preparing for psionic link...\nNow monitoring brain activity...</span>")
	addtimer(CALLBACK(src, .proc/ninitialize_four, delay, U), delay)

/obj/item/clothing/under/syclothing/proc/ninitialize_four(delay, mob/living/carbon/human/U)
	if(U.stat == DEAD|| U.health <= 0)
		to_chat(U, "<span class='danger'><B>FÄAL ï¿½Rrï¿½R</B>: 344--93#ï¿½&&21 BRï¿½ï¿½N |/|/aVï¿½ PATT$RN <B>RED</B>\nA-A-aBï¿½rTï¿½NG...</span>")
		unlock_suit()
		s_busy = FALSE
		return
	to_chat(U, "<span class='notice'>Psionic link processing...\nPattern</span>\green <B>GREEN</B><span class='notice'>, continuing operation.</span>")
	addtimer(CALLBACK(src, .proc/ninitialize_five, delay, U), delay)

/obj/item/clothing/under/syclothing/proc/ninitialize_five(delay, mob/living/carbon/human/U)
	to_chat(U, "<span class='notice'>PHASE-shift device status: <B>ONLINE</B>.\nInertial dampeners: <B>ONLINE</B>.</span>")
	addtimer(CALLBACK(src, .proc/ninitialize_six, delay, U), delay)

/obj/item/clothing/under/syclothing/proc/ninitialize_six(delay, mob/living/carbon/human/U)
	to_chat(U, "<span class='notice'>Primary system status: <B>ONLINE</B>.\nBackup system status: <B>ONLINE</B>.\nDownscaling for application...</span>")
	do_sparks(5, FALSE, U.loc)
	addtimer(CALLBACK(src, .proc/ninitialize_seven, delay, U), delay)

/obj/item/clothing/under/syclothing/proc/ninitialize_seven(delay, mob/living/carbon/human/U)
	to_chat(U, "<span class='notice'>All systems operational. Welcome to <B>SYTech OS</B>, [U.real_name].</span>")
	s_initialized = TRUE
	s_busy = FALSE
	U.size_multiplier = 0.25

/obj/item/clothing/under/syclothing/proc/deinitialize(delay = s_delay)
	if(affecting==loc)
		var/mob/living/carbon/human/U = affecting
		if(alert("Are you certain you wish to remove the suit? This will take time and remove all abilities, as well as keep you small!",,"Yes","No")=="No")
			return
		s_busy = TRUE
		addtimer(CALLBACK(src, .proc/deinitialize_two, delay, U), delay)

/obj/item/clothing/under/syclothing/proc/deinitialize_two(delay, mob/living/carbon/human/U)
	to_chat(U, "<span class='notice'>Now de-initializing...</span>")
	addtimer(CALLBACK(src, .proc/deinitialize_three, delay, U), delay)

/obj/item/clothing/under/syclothing/proc/deinitialize_three(delay, mob/living/carbon/human/U)
	to_chat(U, "<span class='notice'>Logging off, [U.real_name]. Shutting down <B>SYTech OS</B>.</span>")
	addtimer(CALLBACK(src, .proc/deinitialize_four, delay, U), delay)

/obj/item/clothing/under/syclothing/proc/deinitialize_four(delay, mob/living/carbon/human/U)
	to_chat(U, "<span class='notice'>Primary system status: <B>OFFLINE</B>.\nBackup system status: <B>OFFLINE</B>.</span>")
	addtimer(CALLBACK(src, .proc/deinitialize_five, delay, U), delay)

/obj/item/clothing/under/syclothing/proc/deinitialize_five(delay, mob/living/carbon/human/U)
	to_chat(U, "<span class='notice'>PHASE-shift device status: <B>OFFLINE</B>.\nInertial dampeners: <B>OFFLINE</B>.</span>")
	addtimer(CALLBACK(src, .proc/deinitialize_six, delay, U), delay)

/obj/item/clothing/under/syclothing/proc/deinitialize_six(delay, mob/living/carbon/human/U)
	to_chat(U, "<span class='notice'>Disconnecting psionic-link...</span>\green<B>Success</B><span class='notice'>.</span>")
	addtimer(CALLBACK(src, .proc/deinitialize_seven, delay, U), delay)

/obj/item/clothing/under/syclothing/proc/deinitialize_seven(delay, mob/living/carbon/human/U)
	to_chat(U, "<span class='notice'>Disengaging body analysis and brain-monitoring...</span>\green<B>Success</B><span class='notice'>.</span>")
	addtimer(CALLBACK(src, .proc/deinitialize_eight, delay, U), delay)

/obj/item/clothing/under/syclothing/proc/deinitialize_eight(delay, mob/living/carbon/human/U)
	to_chat(U, "<span class='notice'>Unsecuring external locking mechanism...\nTechnology engram secured.\nOperation status: <B>FINISHED</B>.</span>")
	unlock_suit()
	s_initialized = FALSE
	s_busy = FALSE