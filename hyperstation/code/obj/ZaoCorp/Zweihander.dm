/obj/item/twohanded/required/zao/zweihander
	name = "Zao sword"
	desc = "A ZaoCorp class Zweihander. A massive sword with stun baton capabilities, due to it's size however it appears to be unwieldy by normal means."
	icon = 'hyperstation/icons/obj/weapons.dmi'
	icon_state = "zaohander_off"
	lefthand_file = 'hyperstation/icons/mob/inhands/zaohander_left.dmi'
	righthand_file = 'hyperstation/icons/mob/inhands/zaohander_right.dmi'
	block_chance = 100
	flags_1 = CONDUCT_1
	item_flags = NEEDS_PERMIT
	slot_flags = ITEM_SLOT_BACK
	force = 18 //Blade isn't sharpened for 'safety' reasons
	var/force_on = 8
	w_class = WEIGHT_CLASS_BULKY
	throwforce = 14
	throw_speed = 2
	throw_range = 5
	materials = list(MAT_METAL=13000)
	attack_verb = list("attacked", "chopped", "cleaved", "torn", "cut")
	hitsound = "swing_hit"
	sharpness = IS_BLUNT
	actions_types = list(/datum/action/item_action/zaohander)
	var/on = FALSE
	var/throw_hit_chance = 40
	var/cooldown = 0

	var/stunforce = 140

//Might add a powercell to this once I know more about coding, or if someone wants to help with this, who knows!

/obj/item/twohanded/required/zao/zweihander/proc/check_martial_counter(mob/living/carbon/human/target, mob/living/carbon/human/user)
	if(target.check_block())
		target.visible_message("<span class='danger'>[target.name] blocks [src] and twists [user]'s arm behind [user.p_their()] back!</span>",
					"<span class='userdanger'>You block the attack!</span>")
		user.Stun(40)
		return TRUE

/datum/action/item_action/zaohander
	name = "interact with the pommel"

/obj/item/twohanded/required/zao/zweihander/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..()
	//Only mob/living types have stun handling
	if(on && prob(throw_hit_chance) && iscarbon(hit_atom))
		zwei_stun(hit_atom)

/obj/item/twohanded/required/zao/zweihander/pickup(mob/user)
	if((HAS_TRAIT(user, ZAOCORP_AUTHORIZATION)) || !on)
		return
	if(on)
		var/mob/living/carbon/human/L = user //Ill advised to pick up something sparking
		L.electrocute_act(5, src, safety = 1)
		playsound(get_turf(L), 'sound/magic/lightningbolt.ogg', 50, 1, -1)
		L.adjustStaminaLoss(24, STAMINA) //BAD TOUCH
		L.visible_message("<span class='danger'>[src] electrocutes [L]!</span>","<span class='userdanger'>[src] electrocutes you!</span>")
		return
	else
		on = FALSE
		icon_state = "zaohander_off"
		if(src == user.get_active_held_item()) //update inhands
			user.update_inv_hands()
		return

/obj/item/twohanded/required/zao/zweihander/attack_self(mob/user)
	if(!HAS_TRAIT(user, ZAOCORP_AUTHORIZATION))
		to_chat(user, "<span class='notice'>Error! Blade not synced with user, please aquire overcoat and full uniform to activate.</span>")
		return
	else
		on = !on	
		to_chat(user, "<span class='notice'>As interact with the pommel of the [src], [on ? "it begins to spark to life!" : "the electricity begins to die out."]</span>")
		playsound(loc, "sparks", 75, 1, -1)
		force = on ? force_on : initial(force)
		//throwforce = on ? force_on : initial(force)
		icon_state = "zaohander_[on ? "on" : "off"]"

		if(on)
			hitsound = "swing_hit"
		else
			hitsound = 'sound/weapons/rapierhit.ogg'

		if(src == user.get_active_held_item()) //update inhands
			user.update_inv_hands()
		for(var/X in actions)
			var/datum/action/A = X
			A.UpdateButtonIcon()

/obj/item/twohanded/required/zao/zweihander/attack(mob/M, mob/living/carbon/human/user) //Stealing this from Stun Batons THEN adding my own twist
	if(!HAS_TRAIT(user, ZAOCORP_AUTHORIZATION))
		to_chat(user, "<span class='warning'>The blade seems a bit too cumbersome to use.</span>")
		return
	if(on && HAS_TRAIT(user, TRAIT_CLUMSY) && prob(50))
		clowning_around(user)
		return

	if(user.getStaminaLoss() >= STAMINA_SOFTCRIT)//CIT CHANGE - makes it impossible to baton in stamina softcrit
		to_chat(user, "<span class='danger'>You're too exhausted for that.</span>")//CIT CHANGE - ditto
		return //CIT CHANGE - ditto

	if(ishuman(M))
		var/mob/living/carbon/human/L = M
		if(check_martial_counter(L, user))
			return

	if(M.stat)
		to_chat(user, "<span class='warning'>It would be dishonorable to attack a foe while they cannot retaliate.</span>")
		return
	
	if(user.a_intent == INTENT_HELP)
		if(on)
			M.visible_message("<span class='warning'>[user] holds out the powered up blade infront of [M]. Gesturing them to keep their distance.</span>", \
							"<span class='warning'>[user] holds up their sword to you! Having it be mere inches away</span>")
			return		
		else
			M.visible_message("<span class='warning'>[user] has prodded [M] with [src]. Luckily it was off.</span>", \
							"<span class='warning'>[user] has prodded you with [src]. Luckily it was off</span>")
			return
	if(user.a_intent == INTENT_DISARM)
		if(on)
			if(zwei_stun(M, user))
				var/mob/living/carbon/human/H = M
				user.do_attack_animation(H)
				user.adjustStaminaLossBuffered(getweight())
				H.adjustStaminaLoss(8, STAMINA)
				return
		else
			M.visible_message("<span class='warning'>[user] has prodded [M] with [src]. Luckily it was off.</span>", \
							"<span class='warning'>[user] has prodded you with [src]. Luckily it was off</span>")
			return
	if(user.a_intent == INTENT_GRAB)
		if((on) && (cooldown < world.time))
			var/atom/throw_target = get_edge_target_turf(M, user.dir)
			if(zwei_stun(M, user))
				user.do_attack_animation(M)
				user.adjustStaminaLossBuffered(getweight())//CIT CHANGE - makes stunbatonning others cost stamina
			if(!M.anchored)
				M.throw_at(throw_target, rand(2,3), 2, user)
			cooldown = world.time + 100
			M.dropItemToGround(M.get_active_held_item())
			M.dropItemToGround(M.get_inactive_held_item())
			zwei_hardstun(M)
			return
		if((on) && (cooldown > world.time))
			user.visible_message("<span class='warning'>The [src] needs time to charge in order to use this again</span>")
			return
		else
			M.visible_message("<span class='warning'>[user] has prodded [M] with [src]. Luckily it was off.</span>", \
							"<span class='warning'>[user] has prodded you with [src]. Luckily it was off</span>")
			return
	else
		..()


/obj/item/twohanded/required/zao/zweihander/proc/zwei_stun(mob/living/L, mob/user) //Stealing this from stun batons
	if(L.check_shields(src, 0, "[user]'s [name]", MELEE_ATTACK)) //No message; check_shields() handles that
		playsound(L, 'sound/weapons/genhit.ogg', 50, 1)
		return FALSE
	var/stunpwr = stunforce
	/*var/obj/item/stock_parts/cell/our_cell = get_cell()
	if(!our_cell)
		switch_status(FALSE)
		return FALSE
	var/stuncharge = our_cell.charge
	deductcharge(hitcost, FALSE)
	if(QDELETED(src) || QDELETED(our_cell)) //it was rigged
		return FALSE
	if(stuncharge < hitcost)
		if(stuncharge < (hitcost * STUNBATON_CHARGE_LENIENCY))
			L.visible_message("<span class='warning'>[user] has prodded [L] with [src]. Luckily it was out of charge.</span>", \
							"<span class='warning'>[user] has prodded you with [src]. Luckily it was out of charge.</span>")
			return FALSE
		stunpwr *= round(stuncharge/hitcost, 0.1)*/


	L.Knockdown(80)
	L.adjustStaminaLoss(stunpwr*0.1, affected_zone = (istype(user) ? user.zone_selected : BODY_ZONE_CHEST))//CIT CHANGE - makes stunbatons deal extra staminaloss. Todo: make this also deal pain when pain gets implemented.
	L.apply_effect(EFFECT_STUTTER, stunforce)
	SEND_SIGNAL(L, COMSIG_LIVING_MINOR_SHOCK)
	if(user)
		L.lastattacker = user.real_name
		L.lastattackerckey = user.ckey
		L.visible_message("<span class='danger'>[user] has stunned [L] with [src]!</span>", \
								"<span class='userdanger'>[user] has stunned you with [src]!</span>")
		log_combat(user, L, "stunned")

	playsound(loc, 'sound/weapons/egloves.ogg', 50, 1, -1)

	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.forcesay(GLOB.hit_appends)


	return TRUE

/obj/item/twohanded/required/zao/zweihander/proc/zwei_hardstun(mob/living/L, mob/user) //Stealing this from stun batons
	if(L.check_shields(src, 0, "[user]'s [name]", MELEE_ATTACK)) //No message; check_shields() handles that
		playsound(L, 'sound/weapons/genhit.ogg', 50, 1)
		return FALSE
	L.Stun(5)

	return TRUE

/obj/item/twohanded/required/zao/zweihander/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(!HAS_TRAIT(owner, ZAOCORP_AUTHORIZATION) || !owner.in_throw_mode) //Throw mode only for this one
		final_block_chance = 0
		return
	if(attack_type == UNARMED_ATTACK)
		final_block_chance = 100 //How easy is it to block a hand?
	if(attack_type == PROJECTILE_ATTACK)
		final_block_chance = 95 //With the suit it helps against bullets
	if(attack_type == THROWN_PROJECTILE_ATTACK)
		final_block_chance = 100 //Sometimes you may be off guard
	if(attack_type == LEAP_ATTACK)
		final_block_chance = 100 //BRACE
	return ..()

/obj/item/twohanded/required/zao/zweihander/proc/clowning_around(mob/living/user)
	user.visible_message("<span class='danger'>[user] accidentally hits [user.p_them()]self with [src]!</span>", \
						"<span class='userdanger'>You accidentally hit yourself with [src]!</span>")
	SEND_SIGNAL(user, COMSIG_LIVING_MINOR_SHOCK)
	user.Knockdown(stunforce*3)
	playsound(get_turf(src), 'sound/effects/woodhit.ogg', 75, 1, -1)
