#define DUMPTIME 3000

/datum/bank_account
	var/account_holder = "Some pleb"
	var/account_balance = 0
	var/account_offstation_balance = 0
	var/account_pin = 0
	var/account_dna = ""
	var/datum/job/account_job
	var/list/bank_cards = list()
	var/add_to_accounts = TRUE
	var/transferable = TRUE
	var/account_id
	var/withdrawDelay = 0

/datum/bank_account/New(newname, job)
	if(add_to_accounts)
		if(!SSeconomy)
			log_world("Wack")
		SSeconomy.bank_accounts += src
	account_holder = newname
	account_job = job
	account_id = rand(111111,999999)

/datum/bank_account/Destroy()
	if(add_to_accounts)
		SSeconomy.bank_accounts -= src
	return ..()

