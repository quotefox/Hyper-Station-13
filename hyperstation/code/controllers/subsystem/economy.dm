SUBSYSTEM_DEF(economy)
	name = "Economy"
	wait = 5 MINUTES
	priority = FIRE_PRIORITY_ECONOMY
	init_order = INIT_ORDER_ECONOMY
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	/// How many "paychecks" someone gets at the creation of the bank account
	var/roundstart_paychecks = 5
	var/list/bank_accounts = list() //List of normal accounts (not department accounts)
	var/static/list/prices_by_type

/// Updates the prices from the config. Assorted into this individual proc instead of Initialize() so testers can change the config mid-round
/// without having to initialize the economy SS again
/datum/controller/subsystem/economy/proc/UpdatePrices()
	prices_by_type = list()
	prices_by_type += CONFIG_GET(number/economy_price_default)	//ECONOMY_PRICE_DEFAULT.. 1
	prices_by_type += CONFIG_GET(number/economy_price_low)		//ECONOMY_PRICE_LOW.. 2
	prices_by_type += CONFIG_GET(number/economy_price_high)
	prices_by_type += CONFIG_GET(number/economy_price_erotic)
	prices_by_type += CONFIG_GET(number/economy_price_expensive)
	prices_by_type += CONFIG_GET(number/economy_price_expensive_af)
	prices_by_type += 0 //ECONOMY_PRICE_FORCED_FREE.. 7

/datum/controller/subsystem/economy/Initialize()
	UpdatePrices()
	return ..()

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

/**
 * Returns a price value from a subtype of an /obj/item, assuming it was compiled to use money.
 * Otherwise, returns null if it does not use economy
 */
/datum/controller/subsystem/economy/proc/GetPrice(obj/item/costly_item)
	var/economy_type
	var/price_multiplier

	if(istype(costly_item))
		economy_type = costly_item.economy_type
		price_multiplier = costly_item.economy_price_mul
	else
		economy_type = initial(costly_item.economy_type)
		price_multiplier = initial(costly_item.economy_price_mul)

	if(!economy_type)
		return
	return FLOOR(prices_by_type[economy_type] * price_multiplier, 1)
