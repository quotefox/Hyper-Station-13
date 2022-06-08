#define DUMPTIME 3000

/datum/bank_account
	var/account_holder = "Some pleboid"
	var/balance = 0
	var/account_pin = 0
	var/datum/job/account_job
	var/obj/item/card/id/associated_id
	var/list/bank_cards = list()
	var/account_id = 1
	var/base_pay = 60

/datum/bank_account/New(newname="Some plebith", datum/job/job)
	account_holder = newname
	account_job = job
	account_id = rand(111111,999999)

	if(!SSeconomy || !SSeconomy.initialized)
		stack_trace("A new bank account was made without the economy subsystem being initialized first. If this is an issue, change the subsystem's init_order.")
		return

	SSeconomy.bank_accounts += src
	balance += SSeconomy.GetPaycheck(src, job, SSeconomy.roundstart_paychecks)

/// Helper for whenever a paycheck gets processed into this account from the economy SS. Simply adds an amount to the account balance and notifies the user.
/datum/bank_account/proc/AddPaycheck(amount, silent=FALSE)
	balance += amount
	if(associated_id && !silent)
		var/local_turf = get_turf(associated_id)
		var/hearers = ohearers(1, local_turf)
		for(var/mob/M in hearers)
			M.playsound_local(local_turf, 'sound/machines/twobeep_high.ogg', 50, vary = TRUE)
			to_chat(M, "[icon2html(src, associated_id.loc)] <span class='notice>Paycheck processed, your account now holds [balance] credits.</span>")

/datum/bank_account/Destroy()
	if(SSeconomy)
		SSeconomy.bank_accounts -= src
	return ..()

