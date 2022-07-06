/datum/bank_account
	/// The name of whoever owns this account
	var/account_holder = "Some pleboid"
	/// The balance, in credits!
	var/balance = 0
	/// Fluff for the ID of this card. Purely cosmetic, but unique for every account
	var/account_id = 0
	/// The pin number that the owner wanted. Not set by default, so anyone can just steal your ID if you don't remember to set it
	var/account_pin
	/// The base amount of pay you get per paycheck
	var/base_pay = 80
	/// The linked job datum for this bank account, for calculating unique base payment for each job
	var/datum/job/account_job
	/// The associated ID, for letting the card-holder know when a paycheck is processed
	var/obj/item/card/id/associated_id

/datum/bank_account/New(mob/living/carbon/human/new_holder, datum/job/job, obj/item/card/id/id_card)
	account_holder = new_holder.real_name
	account_job = job
	associated_id = id_card
	account_id = rand(111111,999999)

	if(!SSeconomy || !SSeconomy.initialized)
		stack_trace("A new bank account was made without the economy subsystem being initialized first. If this is an issue, change the subsystem's init_order.")
		return

	base_pay = CONFIG_GET(number/economy_base_payment)

	SSeconomy.bank_accounts += src
	balance += SSeconomy.GetPaycheck(src, job, SSeconomy.roundstart_paychecks)

/// Helper for whenever a paycheck gets processed into this account from the economy SS. Simply adds an amount to the account balance and notifies the user.
/datum/bank_account/proc/GivePaycheck(amount, silent=FALSE)
	balance += amount
	if(associated_id && !silent)
		var/local_turf = get_turf(associated_id)
		for(var/mob/M in get_hearers_in_view(1, local_turf))
			M.playsound_local(local_turf, 'sound/machines/twobeep_high.ogg', 50, vary = TRUE)
			to_chat(M, "<span class='notice'>[icon2html(associated_id, M)] Paycheck processed, your account now holds [balance] credits.</span>")

/datum/bank_account/Destroy()
	if(SSeconomy)
		SSeconomy.bank_accounts -= src
	return ..()

