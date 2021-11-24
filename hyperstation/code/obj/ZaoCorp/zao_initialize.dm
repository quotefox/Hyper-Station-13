/obj/item/clothing/suit/toggle/zao/proc/toggle_on_off()
	if(z_busy)
		to_chat(loc, "<span class='userdanger'>ERROR</span>: You cannot use this function at this time.")
		return FALSE
	if(z_initialized)
		deinitialize()
	else
		zinitialize()
	. = TRUE

/obj/item/clothing/suit/toggle/zao/proc/zinitialize(delay = z_delay, mob/living/carbon/human/U = loc)
	if(!U.mind)
		return //Not sure how this could happen.
	z_busy = TRUE
	to_chat(U, "<span class='notice'>Now initializing...</span>")
	addtimer(CALLBACK(src, .proc/zinitialize_two, delay, U), delay)

/obj/item/clothing/suit/toggle/zao/proc/zinitialize_two(delay, mob/living/carbon/human/U)
	if(!lock_suit(U))//To lock the suit onto wearer.
		z_busy = FALSE
		return
	to_chat(U, "<span class='notice'>Securing external locking mechanism...\nNeural-net established.</span>")
	addtimer(CALLBACK(src, .proc/zinitialize_three, delay, U), delay)

/obj/item/clothing/suit/toggle/zao/proc/zinitialize_three(delay, mob/living/carbon/human/U)
	to_chat(U, "<span class='notice'>Extending neural-net interface...\nNow monitoring brain wave pattern...</span>")
	addtimer(CALLBACK(src, .proc/zinitialize_four, delay, U), delay)

/obj/item/clothing/suit/toggle/zao/proc/zinitialize_four(delay, mob/living/carbon/human/U)
	if(U.stat == DEAD|| U.health <= 0)
		to_chat(U, "<span class='danger'><B>FÄAL ï¿½Rrï¿½R</B>: 344--93#ï¿½&&21 BRï¿½ï¿½N |/|/aVï¿½ PATT$RN <B>RED</B>\nA-A-aBï¿½rTï¿½NG...</span>")
		unlock_suit()
		z_busy = FALSE
		return
	to_chat(U, "<span class='notice'>Linking neural-net interface...\nPattern</span>\green <B>GREEN</B><span class='notice'>, continuing operation.</span>")
	addtimer(CALLBACK(src, .proc/zinitialize_five, delay, U), delay)

/obj/item/clothing/suit/toggle/zao/proc/zinitialize_five(delay, mob/living/carbon/human/U)
	to_chat(U, "<span class='notice'>Honor system status: <B>ONLINE</B>.\nSword-art status: <B>ONLINE</B>.</span>")
	addtimer(CALLBACK(src, .proc/zinitialize_six, delay, U), delay)

/obj/item/clothing/suit/toggle/zao/proc/zinitialize_six(delay, mob/living/carbon/human/U)
	to_chat(U, "<span class='notice'>Primary system status: <B>ONLINE</B>.\nBackup system status: <B>ONLINE</B>.</span>")
	addtimer(CALLBACK(src, .proc/zinitialize_seven, delay, U), delay)

/obj/item/clothing/suit/toggle/zao/proc/zinitialize_seven(delay, mob/living/carbon/human/U)
	to_chat(U, "<span class='notice'>All systems operational. Welcome to <B>ZaoCorp OS</B>, [U.real_name]. Secure the people, save the future.</span>")
	z_initialized = TRUE
	START_PROCESSING(SSprocessing, src)
	z_busy = FALSE



/obj/item/clothing/suit/toggle/zao/proc/deinitialize(delay = z_delay)
	if(affecting==loc)
		var/mob/living/carbon/human/U = affecting
		if(alert("Are you certain you wish to remove the suit? This will take time.",,"Yes","No")=="No")
			return
		z_busy = TRUE
		addtimer(CALLBACK(src, .proc/deinitialize_two, delay, U), delay)

/obj/item/clothing/suit/toggle/zao/proc/deinitialize_two(delay, mob/living/carbon/human/U)
	to_chat(U, "<span class='notice'>Now de-initializing...</span>")
	addtimer(CALLBACK(src, .proc/deinitialize_three, delay, U), delay)

/obj/item/clothing/suit/toggle/zao/proc/deinitialize_three(delay, mob/living/carbon/human/U)
	to_chat(U, "<span class='notice'>Logging off, [U.real_name]. Shutting down <B>ZaoCorp OS</B>.</span>")
	addtimer(CALLBACK(src, .proc/deinitialize_four, delay, U), delay)

/obj/item/clothing/suit/toggle/zao/proc/deinitialize_four(delay, mob/living/carbon/human/U)
	to_chat(U, "<span class='notice'>Primary system status: <B>OFFLINE</B>.\nBackup system status: <B>OFFLINE</B>.</span>")
	addtimer(CALLBACK(src, .proc/deinitialize_five, delay, U), delay)

/obj/item/clothing/suit/toggle/zao/proc/deinitialize_five(delay, mob/living/carbon/human/U)
	to_chat(U, "<span class='notice'>HONOR system status: <B>OFFLINE</B>.\nSword-art status: <B>OFFLINE</B>.</span>")
	addtimer(CALLBACK(src, .proc/deinitialize_six, delay, U), delay)

/obj/item/clothing/suit/toggle/zao/proc/deinitialize_six(delay, mob/living/carbon/human/U)
	to_chat(U, "<span class='notice'>Disconnecting neural-net interface...</span>\green<B>Success</B><span class='notice'>.</span>")
	addtimer(CALLBACK(src, .proc/deinitialize_seven, delay, U), delay)

/obj/item/clothing/suit/toggle/zao/proc/deinitialize_seven(delay, mob/living/carbon/human/U)
	to_chat(U, "<span class='notice'>Disengaging neural-net interface...</span>\green<B>Success</B><span class='notice'>.</span>")
	addtimer(CALLBACK(src, .proc/deinitialize_eight, delay, U), delay)

/obj/item/clothing/suit/toggle/zao/proc/deinitialize_eight(delay, mob/living/carbon/human/U)
	to_chat(U, "<span class='notice'>Unsecuring external locking mechanism...\nNeural-net abolished.\nOperation status: <B>FINISHED</B>.</span>")
	unlock_suit()
	U.regenerate_icons()
	z_initialized = FALSE
	STOP_PROCESSING(SSprocessing, src)
	z_busy = FALSE
