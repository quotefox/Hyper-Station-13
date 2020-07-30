/obj/structure/trash_pile
	name = "trash pile"
	desc = "A pile of trash, perhaps something of use can be found?"
	icon = 'icons/obj/trash_piles.dmi'
	icon_state = "randompile"

	anchored = TRUE
	density = FALSE
	layer = BELOW_OBJ_LAYER

	var/hide_person_time = 30

	var/list/used_players = list()

/obj/structure/trash_pile/Initialize()
	. = ..()
	icon_state = "pile[rand(1,11)]"
	GLOB.trash_piles += src

/obj/structure/trash_pile/Destroy()
	GLOB.trash_piles -= src
	for(var/atom/movable/AM in src)
		AM.forceMove(src.loc)
	. = ..()

/obj/structure/trash_pile/attack_hand(mob/user)
	var/turf/T = get_turf(src)
	if(user in used_players)
		to_chat(user, "<span class='notice'>You already have looted [src].</span>")
		return
	if(!do_after(user, rand(2 SECONDS, 4 SECONDS), FALSE, src))
		return
	for(var/i=0, i<rand(1,4), i++)
		var/itemtype = pickweight(GLOB.maintenance_loot)
		new itemtype(T)
	used_players += user

/obj/structure/trash_pile/MouseDrop_T(atom/movable/O, mob/user)
	if(user == O && iscarbon(O))
		dive_in_pile(user)
		return
	. = ..()

/obj/structure/trash_pile/proc/eject_mob(var/mob/living/M)
	M.forceMove(src.loc)
	to_chat(M,"<span class='warning'>You've been found!</span>")
	playsound(M.loc, 'sound/machines/chime.ogg', 50, FALSE, -5)
	M.do_alert_animation(M)

/obj/structure/trash_pile/proc/do_dive(mob/user)
	if(contents.len)
		for(var/mob/M in contents)
			to_chat(user,"<span class='warning'>There's someone in the trash already!</span>")
			eject_mob(M)
			return FALSE
	return TRUE

/obj/structure/trash_pile/proc/dive_in_pile(mob/user)
	user.visible_message("<span class='warning'>[user] starts diving into [src].</span>", \
								"<span class='notice'>You start diving into [src]...</span>")
	var/adjusted_dive_time = hide_person_time
	if(user.restrained()) //hiding takes twice as long when restrained.
		adjusted_dive_time *= 2

	if(do_mob(user, user, adjusted_dive_time))
		if(src.loc) //Checking if structure has been destroyed
			if(do_dive(user))
				to_chat(user,"<span class='notice'>You hide in the trashpile.</span>")
				user.forceMove(src)

/obj/structure/trash_pile/container_resist(mob/user)
	user.forceMove(src.loc)
	
/obj/structure/trash_pile/relaymove(mob/user)
	container_resist(user)
