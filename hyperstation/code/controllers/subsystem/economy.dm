SUBSYSTEM_DEF(economy)
	name = "Economy"
	wait = 5 MINUTES
	init_order = INIT_ORDER_ECONOMY
	runlevels = RUNLEVEL_GAME
	flags = SS_NO_FIRE //Let's not forget this. This subsystem does not use fire and was needlessly using CPU.
	var/roundstart_paychecks = 5
	var/budget_pool = 35000
	var/list/generated_accounts = list()
	var/list/bank_accounts = list() //List of normal accounts (not department accounts)
