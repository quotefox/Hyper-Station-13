/obj/structure/lunaraltar
	name = "lunar altar"
	desc = "Judging by the symbols, millenia ago, it seems that the creatures of this world used to offer something precious to the icy moon that orbits this hellish planet. You... Wouldn't do that, would you?"
	icon = 'icons/obj/hand_of_god_structures.dmi' //Placeholder.
	icon_state = "convertaltar-blue" //Placeholder.
	anchored = TRUE
	density = TRUE
	light_color = LIGHT_COLOR_FIRE
	var/used = FALSE

/obj/structure/lunaraltar/Initialize()
	. = ..()
	set_light(2)

/obj/structure/lunaraltar/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(used)
		to_chat(user, "<span class='notice'>The altar seems shattered.</span>")
		return
	if(istype(user, /mob/living/carbon/human/))
		var/part = pick("r_arm","l_arm","r_leg","l_leg")
		var/mob/living/carbon/human/H = user
		var/obj/item/bodypart/bodypart
		var/paralysistype
		switch(part)
			if("l_leg")
				bodypart = H.get_bodypart(BODY_ZONE_L_LEG)
				paralysistype = TRAIT_PARALYSIS_L_LEG
			if("r_leg")
				bodypart = H.get_bodypart(BODY_ZONE_R_LEG)
				paralysistype = TRAIT_PARALYSIS_R_LEG
			if("l_arm")
				bodypart = H.get_bodypart(BODY_ZONE_L_ARM)
				paralysistype = TRAIT_PARALYSIS_L_ARM
			if("r_arm")
				bodypart = H.get_bodypart(BODY_ZONE_R_ARM)
				paralysistype = TRAIT_PARALYSIS_R_ARM
		if(!bodypart)
			to_chat(user, "<span class='notice'>The altar does nothing.</span>")
			return
		to_chat(user,"<span class='warning'>You begin placing your hand on the altar.</span>")
		playsound(src, 'sound/weapons/slice.ogg', 50, 1, 5)
		if(do_after(user, 100, target=src))
			if(used)
				return
			visible_message("<span class='danger'>[user]'s [bodypart] is momentarily enveloped by shadows before they are gruesomely twisted and dismembered!</span>", \
									"<span class='userdanger'>Your [bodypart] is momentarily enveloped by shadows before it's gruesomely twisted and dismembered!</span>")
			bodypart.dismember()
			bodypart.Destroy()
			ADD_TRAIT(H, paralysistype, "trauma_paralysis")
			H.update_disabled_bodyparts()
			H.bleed_rate += 5
			H.emote("scream")
			var/obj/item/lunar = pick(/obj/item/helfiretincture,
									/obj/item/instrument/guitar/biggerukulele)
			new lunar(src.loc)
			visible_message("<span class='warning'>As you blink, cracks appear on the altar and a flash of lunar light reaches its surface. A gift?</span>")
			message_admins("[ADMIN_LOOKUPFLW(user)] has sacrificed their [bodypart] on the lunar altar at [AREACOORD(src)].")
			icon_state = "sacrificealtar-blue"
			set_light(0)
			update_icon()
			used = TRUE

/obj/item/helfiretincture
	name = "helfire tincture" //"Hel" not Hell. Intended.
	icon = 'hyperstation/icons/obj/lunar.dmi'
	icon_state = "helfire_tincture"
	desc = "Burn everyone nearby... Including you."
	var/cooldowntime = 45 SECONDS
	var/used = FALSE

/obj/item/helfiretincture/attack_self(mob/user)
	if(!used)
		used = TRUE
		visible_message("<span class='danger'>[user] draws from the power of a Hellfire Tincture!</span>", \
								"<span class='userdanger'>You draw the power of the Hellfire Tincture!</span>")
		for(var/mob/living/H in spiral_range(8, user))
			H.adjustFireLoss(10)
			H.adjust_fire_stacks(5)
			H.IgniteMob()
		playsound(src.loc, 'hyperstation/sound/misc/helfire_use.ogg', 100, 1, extrarange = 8)
		icon_state = "helfire_tincture_used"
		update_icon()
		addtimer(CALLBACK(src, .proc/restore, user), cooldowntime)
	else
		to_chat(user, "<span class='warning'>It's too soon to use this again!</span>")

/obj/item/helfiretincture/proc/restore(mob/user)
	used = FALSE
	icon_state = "helfire_tincture"
	update_icon()
	to_chat(user, "<span class='warning'>The tincture vibrates with power once again.</span>")


/obj/item/instrument/guitar/biggerukulele
	name = "bigger ukulele"
	desc = "...and his music was electric."
	icon_state = "biggerukulele"
	item_state = "guitar"
	instrumentExt = "ogg"
	attack_verb = list("played a sick solo on", "electrified", "crashed", "smashed")
	hitsound = 'sound/weapons/stringsmash.ogg'
	instrumentId = "guitar"
	siemens_coefficient = -1
	hit_reaction_chance = 100
	var/tesla_power = 25000
	var/tesla_range = 20
	var/tesla_flags = TESLA_MOB_DAMAGE | TESLA_OBJ_DAMAGE
	var/legacy = FALSE
	var/legacy_dmg = 30
	var/reactive_cooldown_duration = 20
	var/reactive_cooldown = 0
	var/firstpickup = TRUE

/obj/item/instrument/guitar/biggerukulele/dropped(mob/user)
	..()
	if(istype(user))
		user.flags_1 &= ~TESLA_IGNORE_1

/obj/item/instrument/guitar/biggerukulele/pickup(mob/user)
	..()
	if(istype(user))
		user.flags_1 |= TESLA_IGNORE_1
	if(firstpickup)
		SEND_SOUND(user, sound('hyperstation/sound/misc/biggerukulelepickup.ogg', volume = 100))
		firstpickup = FALSE

/obj/item/instrument/guitar/biggerukulele/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(owner.flags_1 & TESLA_IGNORE_1)
		//Do literally nothing. Checking for absence of flags doesn't work for whatever reason, so if !TESLA_IGNORE_1 is not an option.
	else if (owner.flags_1)
		owner.flags_1 |= TESLA_IGNORE_1 //Sometimes picking up the item doesn't grant the user the flag. This is a way to go around that. Thank you, DM Code.
	if(prob(hit_reaction_chance))
		if(world.time < reactive_cooldown)
			var/datum/effect_system/spark_spread/sparks = new /datum/effect_system/spark_spread
			sparks.set_up(1, 1, src)
			sparks.start()
			owner.visible_message("<span class='danger'>The electric strings of [owner]'s bigger ukulele! The instrument merely emits some sparks.</span>")
			return
		owner.visible_message("<span class='danger'>[src] blocks [attack_text], sending out arcs of lightning!</span>")
		if(!legacy)
			tesla_zap(owner, tesla_range, tesla_power, tesla_flags)
			playsound(src.loc, 'sound/weapons/emitter2.ogg', 100, 1, extrarange = 10)
		else
			for(var/mob/living/M in view(7, owner))
				if(M == owner)
					continue
				owner.Beam(M,icon_state="purple_lightning",icon='icons/effects/effects.dmi',time=5)
				M.adjustFireLoss(legacy_dmg)
				playsound(M, 'sound/machines/defib_zap.ogg', 50, 1, -1)
		reactive_cooldown = world.time + reactive_cooldown_duration
		return TRUE
