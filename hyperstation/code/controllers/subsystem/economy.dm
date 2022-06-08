SUBSYSTEM_DEF(economy)
	name = "Economy"
	wait = 5 MINUTES
	priority = FIRE_PRIORITY_ECONOMY
	init_order = INIT_ORDER_ECONOMY
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	/// How many "paychecks" someone gets at the creation of the bank account
	var/roundstart_paychecks = 5
	var/list/bank_accounts = list() //List of normal accounts (not department accounts)

/datum/controller/subsystem/economy/fire()
	for(var/datum/bank_account/account as anything in bank_accounts)
		account.GivePaycheck(GetPaycheck(account, account.account_job))

/**
 * Returns a value of the amount of money a bank account would be getting. It's just some simple multiplication.
 * Both the bank account and job is allowed to be null here.
 *
 * Thanks to the ultimate nature of byond, colon accessors, :, get the default values of the bank account and
 * job datums if the respective one is null. You can pass zero arguments here and you'd get the "default" amount of a paycheck.
 */
/datum/controller/subsystem/economy/proc/GetPaycheck(datum/bank_account/account, datum/job/job, multiplier=1)
	return FLOOR(account:base_pay * job:base_paycheck_multiplier * multiplier, 1)
