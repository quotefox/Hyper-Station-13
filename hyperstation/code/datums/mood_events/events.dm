/datum/mood_event/heatneed
	description = "<span class='warning'>I need someone to satisfy me, my heat is driving me crazy.</span>\n"
	mood_change = -3
	timeout = 2 MINUTES

/datum/mood_event/heat
	description = "<span class='userlove'>I have satisfied my heat, and I'm filled with happiness!</span>\n"
	mood_change = 3
	timeout = 5 MINUTES

/datum/mood_event/kiss
	description = "<span class='nicegreen'>Someone kissed me, I feel happy!</span>\n"
	mood_change = 2
	timeout = 3 MINUTES

/datum/mood_event/deathsaw
	description = "<span class='boldwarning'>I saw someone die!</span>\n"
	mood_change = -8
	timeout = 20 MINUTES //takes a long time to get over

/datum/mood_event/healsbadman
	description = "<span class='warning'>I feel like I'm held together by flimsy string, and could fall apart at any moment!</span>\n"
	mood_change = -4
	timeout = 2 MINUTES