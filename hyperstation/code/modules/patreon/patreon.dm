#define PATREONFILE "[global.config.directory]/patreons.txt"

GLOBAL_LIST_EMPTY(patreons)

/proc/load_patreons()
	GLOB.patreons = list()
	for(var/line in world.file2list(PATREONFILE))
		if(!line)
			continue
		GLOB.patreons += ckey(line)

/proc/check_patreons(var/ckey)
	if(!GLOB.patreons)
		return FALSE
	. = (ckey in GLOB.patreons)
