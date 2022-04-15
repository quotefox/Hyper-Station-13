/datum/computer_file/program/filemanager
	filename = "filemanager"
	filedesc = "File Manager"
	extended_desc = "This program allows management of files."
	program_icon_state = "generic"
	size = 8
	requires_ntnet = 0
	available_on_ntnet = 0
	undeletable = 1
	tgui_id = "NtosFileManager"

/datum/computer_file/program/filemanager/ui_act(action, params)
	if(..())
		return 1

	var/obj/item/computer_hardware/hard_drive/HDD = computer.all_components[MC_HDD]
	var/obj/item/computer_hardware/hard_drive/RHDD = computer.all_components[MC_SDD]

	switch(action)
		if("PRG_deletefile")
			. = 1
			if(!HDD)
				return 1
			var/datum/computer_file/file = HDD.find_file_by_name(params["name"])
			if(!file || file.undeletable)
				return 1
			HDD.remove_file(file)
		if("PRG_usbdeletefile")
			. = 1
			if(!RHDD)
				return 1
			var/datum/computer_file/file = RHDD.find_file_by_name(params["name"])
			if(!file || file.undeletable)
				return 1
			RHDD.remove_file(file)
		if("PRG_rename")
			. = 1
			if(!HDD)
				return 1
			var/datum/computer_file/file = HDD.find_file_by_name(params["name"])
			if(!file || !istype(file))
				return 1
			var/newname = stripped_input(usr, "Enter new file name:", "File rename", file.filename, max_length=50)
			if(file && newname)
				file.filename = newname
		if("PRG_usbrenamefile")
			if(!RHDD)
				return 1
			var/datum/computer_file/file = RHDD.find_file_by_name(params["name"])
			if(!file || !istype(file))
				return 1
			var/newname = stripped_input(usr, "Enter new file name:", "File rename", file.filename, max_length=50)
			if(file && newname)
				file.filename = newname
		if("PRG_copytousb")
			. = 1
			if(!HDD || !RHDD)
				return 1
			var/datum/computer_file/F = HDD.find_file_by_name(params["name"])
			if(!F || !istype(F))
				return 1
			var/datum/computer_file/C = F.clone(0)
			RHDD.store_file(C)
		if("PRG_copyfromusb")
			. = 1
			if(!HDD || !RHDD)
				return 1
			var/datum/computer_file/F = RHDD.find_file_by_name(params["name"])
			if(!F || !istype(F))
				return 1
			var/datum/computer_file/C = F.clone(0)
			HDD.store_file(C)

/datum/computer_file/program/filemanager/proc/parse_tags(t)
	t = replacetext(t, "\[center\]", "<center>")
	t = replacetext(t, "\[/center\]", "</center>")
	t = replacetext(t, "\[br\]", "<BR>")
	t = replacetext(t, "\n", "<BR>")
	t = replacetext(t, "\[b\]", "<B>")
	t = replacetext(t, "\[/b\]", "</B>")
	t = replacetext(t, "\[i\]", "<I>")
	t = replacetext(t, "\[/i\]", "</I>")
	t = replacetext(t, "\[u\]", "<U>")
	t = replacetext(t, "\[/u\]", "</U>")
	t = replacetext(t, "\[time\]", "[STATION_TIME_TIMESTAMP("hh:mm:ss")]")
	t = replacetext(t, "\[date\]", "[time2text(world.realtime, "MMM DD")] [GLOB.year_integer+540]")
	t = replacetext(t, "\[large\]", "<font size=\"4\">")
	t = replacetext(t, "\[/large\]", "</font>")
	t = replacetext(t, "\[h1\]", "<H1>")
	t = replacetext(t, "\[/h1\]", "</H1>")
	t = replacetext(t, "\[h2\]", "<H2>")
	t = replacetext(t, "\[/h2\]", "</H2>")
	t = replacetext(t, "\[h3\]", "<H3>")
	t = replacetext(t, "\[/h3\]", "</H3>")
	t = replacetext(t, "\[*\]", "<li>")
	t = replacetext(t, "\[hr\]", "<HR>")
	t = replacetext(t, "\[small\]", "<font size = \"1\">")
	t = replacetext(t, "\[/small\]", "</font>")
	t = replacetext(t, "\[list\]", "<ul>")
	t = replacetext(t, "\[/list\]", "</ul>")
	t = replacetext(t, "\[table\]", "<table border=1 cellspacing=0 cellpadding=3 style='border: 1px solid black;'>")
	t = replacetext(t, "\[/table\]", "</td></tr></table>")
	t = replacetext(t, "\[grid\]", "<table>")
	t = replacetext(t, "\[/grid\]", "</td></tr></table>")
	t = replacetext(t, "\[row\]", "</td><tr>")
	t = replacetext(t, "\[tr\]", "</td><tr>")
	t = replacetext(t, "\[td\]", "<td>")
	t = replacetext(t, "\[cell\]", "<td>")
	t = replacetext(t, "\[tab\]", "&nbsp;&nbsp;&nbsp;&nbsp;")

	t = parsemarkdown_basic(t)

	return t

/datum/computer_file/program/filemanager/proc/prepare_printjob(t) // Additional stuff to parse if we want to print it and make a happy Head of Personnel. Forms FTW.
	t = replacetext(t, "\[field\]", "<span class=\"paper_field\"></span>")
	t = replacetext(t, "\[sign\]", "<span class=\"paper_field\"></span>")

	t = parse_tags(t)

	t = replacetext(t, regex("(?:%s(?:ign)|%f(?:ield))(?=\\s|$)", "ig"), "<span class=\"paper_field\"></span>")

	return t

/datum/computer_file/program/filemanager/ui_data(mob/user)
	var/list/data = get_header_data()

	var/obj/item/computer_hardware/hard_drive/HDD = computer.all_components[MC_HDD]
	var/obj/item/computer_hardware/hard_drive/portable/RHDD = computer.all_components[MC_SDD]

	if(!computer || !HDD)
		data["error"] = "I/O ERROR: Unable to access hard drive."
	else
		var/list/files[0]
		for(var/datum/computer_file/F in HDD.stored_files)
			files.Add(list(list(
				"name" = F.filename,
				"type" = F.filetype,
				"size" = F.size,
				"undeletable" = F.undeletable
			)))
		data["files"] = files
		if(RHDD)
			data["usbconnected"] = TRUE
			var/list/usbfiles[0]
			for(var/datum/computer_file/F in RHDD.stored_files)
				usbfiles.Add(list(list(
					"name" = F.filename,
					"type" = F.filetype,
					"size" = F.size,
					"undeletable" = F.undeletable
				)))
			data["usbfiles"] = usbfiles

	return data
