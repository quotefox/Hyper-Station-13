/*
* cards rework; uses TGUI and allows in-depth manipulation of cards, such as
* angles, flip states, drawing a number of cards at once, peeking, etc.
*
* sarcoph march 2022
*/

#define CARD_ROTATION_UP "upright"
#define CARD_ROTATION_SIDE "sideways"
#define CARD_ROTATION_DOWN "reversed"

// ================================= GENERAL CARDS =================================

/obj/item/toy/cards
	var/face_up = FALSE
	var/rotation = CARD_ROTATION_UP
	var/merge_rank = 0

/obj/item/toy/cards/proc/GetAngle(_dir)
	var/_angle = 0
	switch(_dir)
		if(CARD_ROTATION_UP)
			_angle = 0
		if(CARD_ROTATION_SIDE)
			_angle = 90
		if(CARD_ROTATION_DOWN)
			_angle = 180
	return _angle

/obj/item/toy/cards/proc/GetNextAngle(angle)
	var/list/_rotations = list(CARD_ROTATION_UP, CARD_ROTATION_SIDE, CARD_ROTATION_DOWN)
	var/list/_indexof = _rotations.Find(rotation)
	return _rotations[_indexof%3 + 1]
	

/obj/item/toy/cards/proc/RotateCards(angle)
	if(angle)
		rotation = angle
	else 
		rotation = GetNextAngle(angle)
	update_icon()

/obj/item/toy/cards/proc/FlipCards(side)
	if(side != null) face_up = side
	else face_up = !face_up
	update_icon()


/**
	* Handles functionality for merging different types of cards.
	* 
	* Arguments:
	* * target - The "greater" card item that this object is going to merge into.
	* * user - The mob that is performing this merge.
	*
	* Returns:
	* * TRUE/FALSE: Whether or not this logic is considered "processed" - i.e., a merge
	* was actually attempted.
	*/
/obj/item/toy/cards/proc/MergeInto(obj/item/toy/cards/target, mob/living/user)
	if(target.parentdeck != src && src.parentdeck != target && src.parentdeck != target.parentdeck)
		to_chat(user, "<span class='warning'>You can't mix cards from other decks!</span>")
		return TRUE
	if(!user.temporarilyRemoveItemFromInventory(src))
		to_chat(user, "<span class='warning'>\The [src] is stuck to your hand, you can't add it to \the [target]!</span>")
		return TRUE
	return FALSE
	// unimplemented

/** 
  * Announces card(s) being added to a deck, and then deletes the card(s).
	*/
/obj/item/toy/cards/proc/FinishMergingCards(obj/item/toy/cards/target, mob/living/user)
	return FALSE // unimplemented

/obj/item/toy/cards/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/toy/cards))
		var/obj/item/toy/cards/C = I
		var/obj/item/toy/cards/greater = merge_rank > C.merge_rank ? src : C
		var/obj/item/toy/cards/lesser = greater == src ? C : src
		if(lesser.MergeInto(greater, user)) return
	else
		return ..()

// ================================= DECK OF CARDS =================================

/obj/item/toy/cards/deck
	var/peeking = FALSE
	var/dealing = FALSE
	merge_rank = 3
	
/**
	* Randomizes positions of all cards in a deck, plays a nice sound,
	* and announces this to the `user`'s surroundings. There is a small
	* cooldown.
	*
	* Arguments:
	* * user - The `mob` shuffling this deck of cards. 
	*/
/obj/item/toy/cards/deck/proc/ShuffleCards(mob/user)
	if(cooldown < world.time - 5 SECONDS)
		cards = shuffle(cards)
		playsound(src, 'sound/items/cardshuffle.ogg', 50, 1)
		user.visible_message("[user] shuffles the deck.", "<span class='notice'>You shuffle the deck.</span>")
		cooldown = world.time

/** 
	* Draws cards into a new hand from a list of indices, turning those new
	* cards into a hand.
	* 
	* Arguments:
	* * card_indices - The `list` of card indices to remove from `cards`.
	* 
	* Returns:
	* * /obj/item/toy/cards/cardhand - A new hand containing the removed cards.
	* OR
	* * /obj/item/toy/cards/singlecard - A single card, if there is only one index.
	*/
/obj/item/toy/cards/deck/proc/DrawCards(list/card_indices)
	if(card_indices.len == 1) return DrawOneCard(card_indices)
	var/obj/item/toy/cards/cardhand/H = new/obj/item/toy/cards/cardhand(usr.loc)
	var/list/cards_to_remove = list()
	for(var/C in card_indices)
		var/card_to_add = cards[C]
		card_to_add["rotation"] = rotation
		card_to_add["face_up"] = face_up
		H.currenthand += list(card_to_add)
		cards_to_remove += list(card_to_add)
	cards -= cards_to_remove
	H.parentdeck = src
	H.apply_card_vars(H,src)
	update_icon()
	return H

/obj/item/toy/cards/deck/proc/DrawOneCard(list/card_indices)
	var/obj/item/toy/cards/singlecard/S = new/obj/item/toy/cards/singlecard(usr.loc)
	var/_card = cards[card_indices[1]]
	_card["rotation"] = rotation
	_card["face_up"] = face_up
	S.card = _card
	S.rotation = _card["rotation"]
	S.face_up = _card["face_up"]
	S.parentdeck = src
	S.apply_card_vars(S,src)
	cards -= list(_card)
	return S

/obj/item/toy/cards/deck/FinishMergingCards(obj/item/toy/cards/target, mob/living/user)
	var/message = "[user] adds \the [target] to the bottom of \the [src]."
	var/self_message = "<span class='notice'>You add \the [target] to the bottom of \the [src].</span>"
	user.visible_message(message, self_message)
	qdel(target)
	update_icon()

/obj/item/toy/cards/deck/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-Click to quick-draw a card.</span>"

/obj/item/toy/cards/deck/AltClick(mob/user)
	. = ..()
	if(!ishuman(usr) || !usr.canUseTopic(src, BE_CLOSE))
		return
	var/obj/item/toy/cards/drawn = DrawCards(list(1))
	drawn.pickup(user)
	user.put_in_hands(drawn)
	to_chat(user, "<span class='notice'>You draw \a [drawn] from \the [src].</span>")


// =================== TGUI stuff ===================

/obj/item/toy/cards/deck/ui_interact(mob/user, ui_key, datum/tgui/ui, force_open, datum/tgui/master_ui, datum/tgui_state/state)
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "CardsDeck", name, 300, 400, master_ui, state)
		ui.open()
	
/obj/item/toy/cards/deck/ui_act(action, params)
	if(..())
		return
	var/list/targets = list(usr, src)
	switch(action)
		if("deal")
			var/n_cards = text2num(params["count"])
			var/n_hands = text2num(params["hands"])
			if(dealing) return FALSE
			if(!n_cards || !n_hands) return FALSE
			if(n_cards * n_hands > cards.len)
				to_chat(usr, "<span class='warning'>You can't deal more cards than there are in the deck!</span>")
				return FALSE
			dealing = TRUE
			to_chat(usr, "<span class='notice'>You get ready to deal cards...</span>")
			if(do_after_mob(usr, targets, 1 SECONDS, progress=TRUE))
				visible_message("[usr] begins dealing cards.")
				var/list/holder = list()
				var/broken = FALSE
				for(var/C = 1, C <= n_cards, C++)	holder += C // card indices placeholder
				for(var/H = 1, H <= n_hands, H++)
					if(do_after_mob(usr, targets, 0.5 SECONDS, progress=TRUE) && dealing)
						var/obj/item/toy/cards/hand = DrawCards(holder)
						step(hand, GLOB.alldirs[H])
					else
						broken = TRUE
						break
				if(broken)
					visible_message("<span class='danger'>[usr] stops in the middle of dealing cards!</span>")
			dealing = FALSE
		if("draw")
			if(!params["cards"]) return FALSE
			var/list/P = splittext(params["cards"], ",")
			var/list/P_cards = list()
			for(var/T in P) 
				P_cards += text2num(T) + 1
			var/obj/item/toy/cards/H = DrawCards(P_cards)
			H.pickup(usr)
			usr.put_in_hands(H)
		if("flip")
			var/P_side = params["side"]
			var/flip_side = null
			if(P_side)
				flip_side = P_side == "face_down" ? FALSE : P_side == "face_up" ? TRUE : null
			FlipCards(flip_side)
			return TRUE
		if("peek")
			visible_message("<span class='warning'>[usr] is peeking in \the [name]!</span>")
			if(do_after_mob(usr, targets, 3 SECONDS, progress=TRUE))
				to_chat(usr, "<span class='notice'>You peek into \the [name].</span>")
				peeking = TRUE
		if("rotate")
			RotateCards(params["angle"])
			return TRUE
		if("shuffle")
			peeking = FALSE
			ShuffleCards(usr)
	update_icon()
	return TRUE
	
/obj/item/toy/cards/deck/ui_data(mob/user)
	var/list/data = list()
	data["face_up"] = face_up
	data["rotation"] = rotation
	data["cards"] = cards
	data["name"] = name
	data["peeking"] = peeking
	return data
	
/obj/item/toy/cards/deck/ui_static_data(mob/user)
	var/list/data = list()
	data["possible_rotations"] = list(CARD_ROTATION_UP, CARD_ROTATION_SIDE, CARD_ROTATION_DOWN)
	return data

/obj/item/toy/cards/deck/ui_close()
	dealing = FALSE
	peeking = FALSE

	
// ================================= HAND OF CARDS =================================

/obj/item/toy/cards/cardhand
	merge_rank = 2
	face_up = TRUE

/obj/item/toy/cards/cardhand/proc/QuickAnnounce(mob/living/user)
	if(!user.is_holding(src))
		to_chat(user, "<span class='warning'>You need to be holding \the [src] to show it!</span>")
		return
	if(user.stat || user.restrained())
		return
	var/list/temp_cards = list()
	var/facedown = 0
	for(var/C in currenthand)
		var/_flipped = C["face_up"] || face_up
		var/_angle = C["rotation"] || rotation
		if(_flipped)
			if(is_all_same_direction())
				temp_cards += "\a [C["name"]]"
			else 
				temp_cards += "\a [_angle] [C["name"]]"
		else
			facedown++
	if(facedown > 0)
		temp_cards += "[facedown] unrevealed card\s"
	visible_message("<span class='notice'>[user] shows [user.p_their()] hand: [english_list(temp_cards)].</span>")

/obj/item/toy/cards/cardhand/proc/is_all_same_direction()
	var/compare_orient = currenthand[1]["rotation"]
	for(var/list/C in currenthand)
		var/_rotation = C["rotation"] || rotation 
		if(_rotation != compare_orient) return FALSE
	return TRUE

/obj/item/toy/cards/cardhand/proc/DrawOneCard(list/card_indices)
	var/obj/item/toy/cards/singlecard/S = new/obj/item/toy/cards/singlecard(usr.loc)
	var/_card = currenthand[card_indices[1]]
	S.card = _card
	S.rotation = _card["rotation"]
	S.face_up = _card["face_up"]
	S.parentdeck = src.parentdeck
	S.apply_card_vars(S,src)
	currenthand -= list(_card)
	S.update_icon()
	update_icon()
	return S

/obj/item/toy/cards/cardhand/MergeInto(obj/item/toy/cards/target, mob/living/user)
	if(..())
		return TRUE
	if(istype(target, /obj/item/toy/cards/deck))
		var/obj/item/toy/cards/deck/C = target
		for(var/_card = 1, _card < currenthand.len, _card++)
			currenthand[_card]["rotation"] = null
			currenthand[_card]["face_up"] = null
		C.cards += currenthand
		C.FinishMergingCards(src, user)
	else if(istype(target, /obj/item/toy/cards/cardhand))
		if(do_after_mob(user, list(user,src,target), 0.5 SECONDS))
			var/obj/item/toy/cards/cardhand/C = target
			C.currenthand += currenthand
			C.FinishMergingCards(src, user)
	else
		return FALSE
	return TRUE

/obj/item/toy/cards/cardhand/FinishMergingCards(obj/item/toy/cards/target, mob/living/user)
	user.visible_message("[user] combines \the [target] into [user.p_their()] hand.",\
	"<span class='notice'>You combine \the [target] into the [src].</span>")
	qdel(target)
	update_icon()

/obj/item/toy/cards/cardhand/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-Click to quick-announce your deck.</span>"

/obj/item/toy/cards/cardhand/AltClick(mob/user)
	. = ..()
	QuickAnnounce(user)


// =================== TGUI stuff ===================

/obj/item/toy/cards/cardhand/ui_interact(mob/user, ui_key, datum/tgui/ui, force_open, datum/tgui/master_ui, datum/tgui_state/state)
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "CardsHand", name, 300, 400, master_ui, state)
		ui.open()
	
/obj/item/toy/cards/cardhand/ui_act(action, params)
	if(..())
		return
	switch(action)
		if("draw")
			if(!params["cards"]) return FALSE
			var/list/P = splittext(params["cards"], ",")
			var/list/P_cards = list()
			for(var/T in P) 
				P_cards += text2num(T) + 1
			var/obj/item/toy/cards/H = DrawOneCard(P_cards)
			H.pickup(usr)
			usr.put_in_hands(H)
		if("flip")
			if(!params["card"]) return FALSE
			var/card = currenthand[text2num(params["card"]) + 1]
			card["face_up"] = !card["face_up"]
		if("rotate")
			if(!params["card"]) return FALSE
			var/card = currenthand[text2num(params["card"]) + 1]
			if(params["angle"])
				card["rotation"] = params["angle"]
	update_icon()
	return TRUE
	
/obj/item/toy/cards/cardhand/ui_data(mob/user)
	var/list/data = list()
	data["cards"] = currenthand
	data["name"] = name
	return data

/obj/item/toy/cards/cardhand/ui_static_data(mob/user)
	var/list/data = list()
	data["possible_rotations"] = list(CARD_ROTATION_UP, CARD_ROTATION_SIDE, CARD_ROTATION_DOWN)
	return data


// ================================= SINGLE CARDS =================================

/obj/item/toy/cards/singlecard
	merge_rank = 1

/obj/item/toy/cards/singlecard/MergeInto(obj/item/toy/cards/target, mob/living/user)
	if(..())
		return TRUE
	if(istype(target, /obj/item/toy/cards/deck))
		var/obj/item/toy/cards/deck/C = target
		card["rotation"] = null
		card["face_up"] = null
		C.cards += list(card)
		C.FinishMergingCards(src, user)
	else if(istype(target, /obj/item/toy/cards/cardhand))
		var/obj/item/toy/cards/cardhand/C = target
		C.currenthand += list(card)
		C.FinishMergingCards(src, user)
	else if(istype(target, /obj/item/toy/cards/singlecard))
		var/obj/item/toy/cards/singlecard/C = target
		var/obj/item/toy/cards/cardhand/H = new/obj/item/toy/cards/cardhand(user.loc)
		H.currenthand += list(C.card)
		H.currenthand += list(src.card)
		H.parentdeck = C.parentdeck
		H.apply_card_vars(H,C)
		H.pickup(user)
		user.put_in_hands(H)
		C.FinishMergingCards(src, user)
	else
		return FALSE
	return TRUE

/obj/item/toy/cards/singlecard/proc/FlipCard(mob/user)
	if(!ishuman(usr) || !usr.canUseTopic(src, BE_CLOSE))
		return
	FlipCards()
	to_chat(user, "<span class='notice'>You flip \the [src] [(face_up ? "face-up" : "face-down")]</span>.")
	
/obj/item/toy/cards/singlecard/proc/RotateCard(mob/user, var/rotation_angle)
	if(!ishuman(usr) || !usr.canUseTopic(src, BE_CLOSE))
		return
	to_chat(user, "<span class='notice'>You turn \the [src] to \a [rotation_angle] position.</span>")
	RotateCards(rotation_angle)
	

/obj/item/toy/cards/singlecard/FinishMergingCards(obj/item/toy/cards/singlecard/target, mob/living/user)
	to_chat(user, "<span class='notice'>You combine the [target.card["name"]] and the [src.card["name"]] into a hand.</span>")
	qdel(target)
	qdel(src)
	update_icon()

/obj/item/toy/cards/singlecard/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Click to flip. Alt-Click to rotate.</span>"

/obj/item/toy/cards/singlecard/attack_self(mob/user)
	. = ..()
	FlipCard(user)

/obj/item/toy/cards/singlecard/AltClick(mob/user)
	. = ..()
	RotateCard(user, GetNextAngle(rotation))

/obj/item/toy/cards/singlecard/update_icon()
	. = ..()
	var/matrix/rot_matrix = matrix()
	rot_matrix.Turn(GetAngle(rotation))
	transform = rot_matrix

	var/rotation_name = (rotation == CARD_ROTATION_UP ? "" : rotation + " ") 
	if(face_up)
		if(card)
			src.icon_state = "sc_[card["icon_state"] || card["name"]]_[deckstyle]"
			src.name = rotation_name + src.card["name"]
		else
			src.icon_state = "sc_aceofspades_[deckstyle]"
			src.name = "What Card"
		src.pixel_x = 5
	else
		src.icon_state = "singlecard_down_[deckstyle]"
		src.name = rotation_name + "card"
		src.pixel_x = -5