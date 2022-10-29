//This event is intended to fill up a pool of otherwise empty events, until we can get more.
//Just so we don't get back-to-back comms-outages and sentient animal spawns. They get a little annoying.

/datum/round_event_control/filler
	name = "Filler"
	typepath = /datum/round_event/filler
	weight = 100
	earliest_start = 30 MINUTES //So other important events can roll before this one does
	max_occurrences = 50 //For those reaaaaaaally drawn-out rounds. Adjust as it comes
	alertadmins = 0

/datum/round_event/filler
	startWhen = 1
	endWhen	= 2
	fakeable = FALSE
