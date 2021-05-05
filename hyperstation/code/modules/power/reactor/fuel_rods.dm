/obj/item/twohanded/required/fuel_rod/telecrystal
	name = "Telecrystal Fuel Rod"
	desc = "A disguised titanium sheathed rod containing several small slots infused with uranium dioxide. Permits the insertion of telecrystals to grow more. Fissiles much faster than its standard counterpart"
	icon_state = "telecrystal"
	fuel_power = 0.30 // twice as powerful as a normal rod, you're going to need some engineering autism if you plan to mass produce TC
	var/telecrystal_amount = 0 // amount of telecrystals inside the rod?
	var/max_telecrystal_amount = 8 // the max amount of TC that can be in the rod?
	var/grown = FALSE // has the rod fissiled enough for us to remove the grown TC?
	var/expended = FALSE // have we removed the TC already?
	var/multiplier = 3 // how much do we multiply the inserted TC by?


/obj/item/twohanded/required/fuel_rod/telecrystal/deplete(amount=0.035)
	depletion += amount
	if(depletion >= 100)
		fuel_power = 0.60 // thrice as powerful as plutonium, you'll want to get this one out quick!
		name = "Exhausted Telecrystal Fuel Rod"
		desc = "A highly energetic, disguised titanium sheathed rod containing a number of slots filled with greatly expanded telecrystals which can be removed by hand. It's extremely efficient as nuclear fuel, but will cause the reaction to get out of control if not properly utilised."
		icon_state = "telecrystal_used"
		grown = TRUE
	else
		fuel_power = 0.30

/obj/item/twohanded/required/fuel_rod/telecrystal/attackby(obj/item/W, mob/user, params)
	var/obj/item/stack/telecrystal/M = W
	if(istype(M))
		if(depletion >= 10)
			to_chat(user, "<span class='warning'>The sample slots have sealed themselves shut, it's too late to add crystals now!</span>") // no cheesing in crystals at 100%
			return
		if(expended)
			to_chat(user, "<span class='warning'>\The [src]'s material slots have already been used.</span>")
			return

		if(telecrystal_amount < max_telecrystal_amount)
			var/adding = 0
			if(M.amount <= max_telecrystal_amount - telecrystal_amount)
				adding = M.amount
			else
				adding = max_telecrystal_amount - telecrystal_amount
			adding = min((max_telecrystal_amount - telecrystal_amount), M.amount)
			M.amount -= adding
			telecrystal_amount += adding
			M.zero_amount()
			to_chat(user, "<span class='notice'>You insert [adding] telecrystals into \the [src].</span>")
		else
			to_chat(user, "<span class='warning'>\The [src]'s material slots are full!</span>")
			return
	else
		return ..()

/obj/item/twohanded/required/fuel_rod/telecrystal/attack_self(mob/user)
	if(expended)
		to_chat(user, "<span class='notice'>You have already removed the telecrystals from the [src].</span>")
		return

	if(grown)
		var/profit = round(telecrystal_amount * multiplier, 1)
		to_chat(user, "<span class='notice'>You remove [profit] telecrystals from the [src].</span>")
		var/obj/item/stack/telecrystal/tc = new(get_turf(src))
		tc.amount = profit
		expended = TRUE
		telecrystal_amount = 0
		return

	else
		to_chat(user, "<span class='warning'>\The [src] has not fissiled enough to fully grow the sample. The progress bar shows it is [min(depletion / 40 * 100, 100)]% complete.</span>")

/obj/item/twohanded/required/fuel_rod/telecrystal/examine(mob/user)
	. = ..()
	if(expended)
		. += "<span class='warning'>The material slots have been slagged by the extreme heat, you can't grow crystals in this rod again...</span>"
		return
	if(depletion)
		. += "<span class='danger'>The sample is [min(depletion / 40 * 100, 100)]% fissiled.</span>"

	. += "<span class='disarm'>[telecrystal_amount]/[max_telecrystal_amount] of the telecrystal slots are full.</span>"
