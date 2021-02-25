#define LIGHTSTOBREAK_MINIMUM	25
#define LIGHTSTOBREAK_MAXIMUM	75
#define LIGHTSTOBREAK_THRESHOLD 50
#define LIGHTSTOBREAK_AREA_MIN	1
#define LIGHTSTOBREAK_AREA_MAX	2

/datum/antagonist/nightmare
	name = "Nightmare"
	show_in_antagpanel = FALSE
	show_name_in_check_antagonists = TRUE

/datum/antagonist/nightmare/on_gain()
	owner.objectives += forge_objective()
	owner.objectives += new /datum/objective/survive

/datum/antagonist/nightmare/proc/forge_objective()
	var/datum/objective/break_lights/O = new
	O.mode = prob(50) ? TRUE : FALSE
	antag_memory = "<b>Objectives:<br>1.</b> [O.apply_rules()]<br><b>2.</b> Stay alive until the end."
	return O
