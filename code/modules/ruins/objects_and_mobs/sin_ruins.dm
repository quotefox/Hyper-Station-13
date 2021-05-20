//These objects are used in the cardinal sin-themed ruins (i.e. Gluttony, Pride...)

/obj/structure/cursed_slot_machine //Greed's slot machine: Used in the Greed ruin. Deals clone damage on each use, with a successful use giving a d20 of fate.
	name = "greed's slot machine"
	desc = "High stakes, high rewards."
	icon = 'icons/obj/economy.dmi'
	icon_state = "slots1"
	anchored = TRUE
	density = TRUE
	var/win_prob = 5

/obj/structure/cursed_slot_machine/interact(mob/living/carbon/human/user)
	if(!istype(user))
		return
	if(obj_flags & IN_USE)
		return
	obj_flags |= IN_USE
	user.adjustCloneLoss(20)
	if(user.stat)
		to_chat(user, "<span class='userdanger'>No... just one more try...</span>")
		user.gib()
	else
		user.visible_message("<span class='warning'>[user] pulls [src]'s lever with a glint in [user.p_their()] eyes!</span>", "<span class='warning'>You feel a draining as you pull the lever, but you \
		know it'll be worth it.</span>")
	icon_state = "slots2"
	playsound(src, 'sound/lavaland/cursed_slot_machine.ogg', 50, 0)
	addtimer(CALLBACK(src, .proc/determine_victor, user), 50)

/obj/structure/cursed_slot_machine/proc/determine_victor(mob/living/user)
	icon_state = "slots1"
	obj_flags &= ~IN_USE
	if(prob(win_prob))
		playsound(src, 'sound/lavaland/cursed_slot_machine_jackpot.ogg', 50, 0)
		new/obj/structure/cursed_money(get_turf(src))
		if(user)
			to_chat(user, "<span class='boldwarning'>You've hit jackpot. Laughter echoes around you as your reward appears in the machine's place.</span>")
		qdel(src)
	else
		if(user)
			to_chat(user, "<span class='boldwarning'>Fucking machine! Must be rigged. Still... one more try couldn't hurt, right?</span>")


/obj/structure/cursed_money
	name = "bag of money"
	desc = "RICH! YES! YOU KNEW IT WAS WORTH IT! YOU'RE RICH! RICH! RICH!"
	icon = 'icons/obj/storage.dmi'
	icon_state = "moneybag"
	anchored = FALSE
	density = TRUE

/obj/structure/cursed_money/Initialize()
	. = ..()
	addtimer(CALLBACK(src, .proc/collapse), 600)

/obj/structure/cursed_money/proc/collapse()
	visible_message("<span class='warning'>[src] falls in on itself, \
		canvas rotting away and contents vanishing.</span>")
	qdel(src)

/obj/structure/cursed_money/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	user.visible_message("<span class='warning'>[user] opens the bag and \
		and removes a die. The bag then vanishes.</span>",
		"<span class='boldwarning'>You open the bag...!</span>\n\
		<span class='danger'>And see a bag full of dice. Confused, \
		you take one... and the bag vanishes.</span>")
	var/turf/T = get_turf(user)
	var/obj/item/dice/d20/fate/one_use/critical_fail = new(T)
	user.put_in_hands(critical_fail)
	qdel(src)

/obj/effect/gluttony //Gluttony's wall: Used in the Gluttony ruin. Only lets the overweight through.
	name = "gluttony's wall"
	desc = "Only those who truly indulge may pass."
	anchored = TRUE
	density = TRUE
	icon_state = "blob"
	icon = 'icons/mob/blob.dmi'
	color = rgb(145, 150, 0)

/obj/effect/gluttony/CanPass(atom/movable/mover, turf/target)//So bullets will fly over and stuff.
	if(ishuman(mover))
		var/mob/living/carbon/human/H = mover
		if(H.nutrition >= NUTRITION_LEVEL_FAT)
			H.visible_message("<span class='warning'>[H] pushes through [src]!</span>", "<span class='notice'>You've seen and eaten worse than this.</span>")
			return TRUE
		else
			to_chat(H, "<span class='warning'>You're repulsed by even looking at [src]. Only a pig could force themselves to go through it.</span>")
	if(istype(mover, /mob/living/simple_animal/hostile/morph))
		return TRUE
	else
		return FALSE

/obj/structure/mirror/magic/pride //Pride's mirror: Used in the Pride ruin.
	name = "pride's mirror"
	desc = "Pride cometh before the..."
	icon_state = "magic_mirror"

/obj/structure/mirror/magic/pride/curse(mob/user)
	user.visible_message("<span class='danger'><B>The ground splits beneath [user] as [user.p_their()] hand leaves the mirror!</B></span>", \
	"<span class='notice'>Perfect. Much better! Now <i>nobody</i> will be able to resist yo-</span>")

	var/turf/T = get_turf(user)
	var/list/levels = SSmapping.levels_by_trait(ZTRAIT_SPACE_RUINS)
	var/turf/dest
	if (levels.len)
		dest = locate(T.x, T.y, pick(levels))

	T.ChangeTurf(/turf/open/chasm)
	var/turf/open/chasm/C = T
	C.set_target(dest)
	C.drop(user)

//can't be bothered to do sloth right now, will make later

/obj/item/kitchen/knife/envy //Envy's knife: Found in the Envy ruin. Attackers take on the appearance of whoever they strike.
	name = "envy's knife"
	desc = "Their success will be yours."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "render"
	item_state = "knife"
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'
	force = 18
	throwforce = 10
	w_class = WEIGHT_CLASS_NORMAL
	hitsound = 'sound/weapons/bladeslice.ogg'

/obj/item/kitchen/knife/envy/afterattack(atom/movable/AM, mob/living/carbon/human/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(!istype(user))
		return
	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		if(user.real_name != H.dna.real_name)
			user.real_name = H.dna.real_name
			H.dna.transfer_identity(user, transfer_SE=1)
			user.updateappearance(mutcolor_update=1)
			user.domutcheck()
			user.size_multiplier = H.size_multiplier
			user.visible_message("<span class='warning'>[user]'s appearance shifts into [H]'s!</span>", \
			"<span class='boldannounce'>[H.p_they(TRUE)] think[H.p_s()] [H.p_theyre()] <i>sooo</i> much better than you. Not anymore, [H.p_they()] won't.</span>")

/obj/item/reagent_containers/chalice
	name = "Curse of Lust"
	desc = "You shouldn't see this! If you do, tell the gods something is wrong."
	icon = 'icons/obj/drinks.dmi'
	icon_state = "cumchalice"

/obj/item/reagent_containers/chalice/lust 
	name = "Golden Chalice of Lust"
	desc = "A beautiful golden chalice, centered with a gleaming pink jewel of unknown origin. It is still slightly damp with aphrodisiac. It smells faintly of strawberries and roofies."
	icon = 'icons/obj/drinks.dmi'
	icon_state = "cumchalice"
	w_class = WEIGHT_CLASS_SMALL
	force = 1
	throwforce = 1
	amount_per_transfer_from_this = 5
	volume = 15
	flags_1 = CONDUCT_1
	spillable = TRUE
	resistance_flags = INDESTRUCTIBLE
	reagent_flags = AMOUNT_VISIBLE

/obj/item/reagent_containers/chalice/lust/Initialize() //just in case
	beaker_weakness_bitflag &= ~PH_WEAK
	. = ..()

/obj/item/reagent_containers/chalice/lust/attack_self(mob/living/carbon/human/user)
	var/thecostofhorny = 0
	var/truecostofhorny = 0
	var/choicechem = /datum/reagent/water
	var/choice = "Water"
	var/free = src.reagents.maximum_volume - src.reagents.total_volume
	if(free <= 0)
		return

	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return

	choice = input(user, "Go ahead, pick your poison~", "Boon of Lust") as null|anything in list("Crocin", "Hexacrocin","Succubus Milk", "Incubus Draft", "Prospacillin", "Diminicillin", "Semen", "Femcum", "Milk", "Alien Honey")

	switch(choice)
		if("Crocin")
			choicechem = /datum/reagent/drug/aphrodisiac
			thecostofhorny = 5
		if("Hexacrocin")
			choicechem = /datum/reagent/drug/aphrodisiacplus
			thecostofhorny = 5
		if("Succubus Milk")
			choicechem = /datum/reagent/fermi/breast_enlarger
			thecostofhorny = 5
		if("Incubus Draft")
			choicechem = /datum/reagent/fermi/penis_enlarger
			thecostofhorny = 5
		if("Prospacillin")
			choicechem = /datum/reagent/growthchem
			thecostofhorny = 40 //Rare chem, should be very expensive
		if("Diminicillin")
			choicechem = /datum/reagent/shrinkchem
			thecostofhorny = 40 //Rare chem, should be very expensive
		if("Semen")
			choicechem = /datum/reagent/consumable/semen
			thecostofhorny = 1
		if("Femcum")
			choicechem = /datum/reagent/consumable/femcum
			thecostofhorny = 1
		if("Milk")
			choicechem = /datum/reagent/consumable/milk
			thecostofhorny = 3 //fuck you chef
		if("Alien Honey")
			choicechem = /datum/reagent/consumable/alienhoney
			thecostofhorny = 1

	var/makechems = alert(user, "Are you sure you want to make [choice]?", "Boon of Lust", "Yes", "No")
	switch(makechems)
		if("Yes")
			src.reagents.add_reagent(choicechem, 5)
			truecostofhorny = (thecostofhorny*user.size_multiplier)
			user.adjustCloneLoss(truecostofhorny, 1)
			user.adjustArousalLoss(100, 1)
			to_chat(user, "<span class='userdanger'>You feel part of your body ripped from you violently, before the beaker fills itself with [choice].</span>")
		if("No")
			return


/obj/item/reagent_containers/chalice/lust/attack(mob/M, mob/user, obj/target)
	if(!canconsume(M, user))
		return

	if(!spillable)
		return

	if(!reagents || !reagents.total_volume)
		to_chat(user, "<span class='warning'>[src] is empty!</span>")
		return

	if(istype(M))
		if(user.a_intent == INTENT_HARM)
			M.visible_message("<span class='danger'>[user] splashes the contents of [src] onto [M]!</span>", \
							"<span class='userdanger'>[user] splashes the contents of [src] onto [M]!</span>")
			var/R = reagents?.log_list()
			if(isturf(target) && reagents.reagent_list.len && thrownby)
				log_combat(thrownby, target, "splashed (thrown) [english_list(reagents.reagent_list)]")
				message_admins("[ADMIN_LOOKUPFLW(thrownby)] splashed (thrown) [english_list(reagents.reagent_list)] on [target] at [ADMIN_VERBOSEJMP(target)].")
			reagents.reaction(M, TOUCH)
			log_combat(user, M, "splashed", R)
			reagents.clear_reagents()
		else
			if(M != user)
				M.visible_message("<span class='danger'>[user] attemped to feed something to [M], but failed!</span>")
				return
			else
				to_chat(user, "<span class='notice'>You swallow a gulp of [src].</span>")
			var/fraction = min(5/reagents.total_volume, 1)
			reagents.reaction(M, INGEST, fraction)
			addtimer(CALLBACK(reagents, /datum/reagents.proc/trans_to, M, 5), 5)
			playsound(M.loc,'sound/items/drink.ogg', rand(10,50), 1)

/obj/structure/lewdfountain
	name = "Lewd Fountain"
	desc = "You shouldn't see this!"
	icon = 'icons/obj/hand_of_god_structures.dmi'
	icon_state = "fountain"
	anchored = TRUE
	density = TRUE

/obj/structure/lewdfountain/lust
	name = "fountain of lust"
	desc = "A beautiful hand carved fountain, with a carved golden cup atop it. The cup seems to be constantly overflowing with a pink fluid that smells like liquid desire. Just looking at it makes you turned on."
	icon = 'icons/obj/hand_of_god_structures.dmi'
	icon_state = "fountain"
	anchored = TRUE
	density = TRUE
	var/chalice_taken = 0

/obj/structure/lewdfountain/lust/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(chalice_taken == 1)
		to_chat(user, "<i>You hear a voice in your head... <b>\"My chalice has already been taken, dear. I cannot give you another...\"</i></b>")
		return
	if(user.getArousalLoss() < 100)
		to_chat(user, "<i>You hear a voice in your head... <b>\"You are not horny enough to receive my blessing, dear~\"</i></b>")
		return
	if (ishuman(user) && user.has_dna())
		user.mob_climax(forced_climax=TRUE)
		to_chat(user, "<i>You hear a voice in your head... <b>\"You are worth of my blessing dear~\"</i></b>")
		to_chat(user, "<span class='userdanger'>You feel overpowering pleasure surge through your entire body.</span>")
		var/A = new /obj/item/reagent_containers/chalice/lust
		user.put_in_hands(A)
		chalice_taken = 1