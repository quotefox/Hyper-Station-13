GLOBAL_DATUM_INIT(lore_terminal_controller, /datum/lore_controller, new)

/obj/machinery/computer/lore_terminal
	name = "Staff info-link terminal"
	desc = "A small CRT display with an inbuilt microcomputer which is loaded with an extensive database. These terminals contain eveyrthing from information about historical events to instruction manuals for common ship appliances."
	icon = 'nsv13/icons/obj/computers.dmi'
	icon_state = "terminal"
	pixel_y = 26 //So they snap to walls correctly
	density = FALSE
	anchored = TRUE
	idle_power_usage = 15
	var/access_tag = "kncommon"  //Every subtype of this type will be readable by this console. Use this for away terms as seen here \/
	var/list/entries = list() //Every entry that we've got.
	var/in_use = FALSE //Stops sound spam
	var/datum/looping_sound/computer_click/soundloop

/obj/machinery/computer/lore_terminal/command //Put sensitive information on this one
	name = "Command info-link terminal"
	access_tag = "kncommand"
	req_access = list(ACCESS_HEADS)

/obj/machinery/computer/lore_terminal/security
	name = "Security info-link terminal"
	access_tag = "knsecurity"
	req_access = list(ACCESS_SECURITY)

/obj/machinery/computer/lore_terminal/awaymission //Example for having a terminal preloaded with only a set list of files.
	access_tag = "awaymission_default"

/obj/machinery/computer/lore_terminal/Initialize()
	. = ..()
	get_entries()
	soundloop = new(list(src), FALSE)

/datum/looping_sound/computer_click
	mid_sounds = list('nsv13/sound/effects/computer/scroll1.ogg','nsv13/sound/effects/computer/scroll2.ogg','nsv13/sound/effects/computer/scroll3.ogg','nsv13/sound/effects/computer/scroll5.ogg')
	mid_length = 0.8 SECONDS
	volume = 30

/obj/machinery/computer/lore_terminal/proc/get_entries()
	for(var/X in GLOB.lore_terminal_controller.entries)
		var/datum/lore_entry/instance = X
		if(instance.access_tag == access_tag)
			entries += instance

/obj/machinery/computer/lore_terminal/attack_hand(mob/user)
	. = ..()
	if(!allowed(user))
		var/sound = pick('nsv13/sound/effects/computer/error.ogg','nsv13/sound/effects/computer/error2.ogg','nsv13/sound/effects/computer/error3.ogg')
		playsound(src, sound, 100, 1)
		to_chat(user, "<span class='warning'>Access denied</span>")
		return
	playsound(src, 'nsv13/sound/effects/computer/scroll_start.ogg', 100, 1)
	user.set_machine(src)
	var/dat
	if(!entries.len)
		get_entries()
	for(var/X in entries) //Allows you to remove things individually
		var/datum/lore_entry/content = X
		dat += "<a href='?src=[REF(src)];selectitem=\ref[content]'>[content.name]</a><br>"
	var/datum/browser/popup = new(user, "cd C:/entries/local", name, 300, 500)
	popup.set_content(dat)
	popup.open()


/obj/machinery/computer/lore_terminal/Topic(href, href_list)
	if(!in_range(src, usr))
		return
	if(in_use)
		var/sound = 'nsv13/sound/effects/computer/buzz2.ogg'
		playsound(src, sound, 100, 1)
		to_chat(usr, "<span class='warning'>ERROR: I/O function busy. A file is still loading...</span>")
		return
	var/datum/lore_entry/content = locate(href_list["selectitem"])
	if(!content || !content?.content)
		return
	var/clicks = length(content.content) //Split the content into characters. 1 character = 1 click
	var/dat = "<!DOCTYPE html>\
	<html>\
	<body background='https://cdn.discordapp.com/attachments/573966558548721665/612306341612093489/static.png'>\
	\
	<body onload='typeWriter()'>\
	\
	<h4>ACCESS FILE: C:/entries/local/[content.name]</h4>\
	<h3><i>Classification: [content.classified]</i></h3>\
	<h6>- � Seegson systems inc, 2257</h6>\
	<hr style='border-top: dotted 1px;' />\
	<h2>[content.title]</h2>\
	\
	<p id='demo'></p>\
	\
	<script>\
	var i = 0;\
	var txt = \"[content.content]\";\
	var speed = 10;\
	\
	function typeWriter() {\
	  if (i < txt.length) {\
	    var char = txt.charAt(i);\
	    if (char == '`') {\
	      document.getElementById('demo').innerHTML += '<br>';\
	    }\
	    else {\
	      document.getElementById('demo').innerHTML += txt.charAt(i);\
	    }\
	    i++;\
	    setTimeout(typeWriter, speed);\
	  }\
	}\
	</script>\
	\
	\
	<style>\
	body {\
	  background-color: black;\
	  background-image: radial-gradient(\
	    rgba(0, 20, 0, 0.75), black 120%\
	  );\
	  height: 100vh;\
	  margin: 0;\
	  overflow: hidden;\
	  padding: 2rem;\
	  color: #36f891;\
	  font: 1.3rem Lucida Console, monospace;\
	  text-shadow: 0 0 5px #355732;\
	  &::after {\
	    content: '';\
	    position: absolute;\
	    top: 0;\
	    left: 0;\
	    width: 100vw;\
	    height: 100vh;\
	    background: repeating-linear-gradient(\
	      0deg,\
	      rgba(black, 0.15),\
	      rgba(black, 0.15) 1px,\
	      transparent 1px,\
	      transparent 2px\
	    );\
	    pointer-events: none;\
	  }\
	}\
	::selection {\
	  background: #0080FF;\
	  text-shadow: none;\
	}\
	pre {\
	  margin: 0;\
	}\
	</style>\
	</body>\
	</html>"
	usr << browse(dat, "window=lore_console[content.name];size=600x600")
	playsound(src, pick('nsv13/sound/effects/computer/buzz.ogg','nsv13/sound/effects/computer/buzz2.ogg'), 100, TRUE)
	in_use = TRUE //Stops you from crashing the server with infinite sounds
	icon_state = "terminal_scroll"
	clicks = clicks/3
	var/loops = clicks/3 //Each click sound has 4 clicks in it, so we only need to click 1/4th of the time per character yeet.
	addtimer(CALLBACK(src, .proc/stop_clicking), loops)
	soundloop?.start()


/obj/machinery/computer/lore_terminal/proc/stop_clicking()
	soundloop?.stop()
	icon_state = "terminal"
	in_use = FALSE

/datum/lore_controller
	var/name = "Lore archive controller"
	var/list/entries = list() //All the lore entries we have.

/datum/lore_controller/New()
	. = ..()
	instantiate_lore_entries()

/datum/lore_controller/proc/instantiate_lore_entries()
	for(var/instance in subtypesof(/datum/lore_entry))
		var/datum/lore_entry/S = new instance
		entries += S

/datum/lore_entry
	var/name = "Loredoc.txt" //"File display name" that the term shows (C://blah/yourfile.bmp)
	var/title = null //What it's all about
	var/classified = "Declassified" //Fluff, is this a restricted file or not?
	var/content = null //You may choose to set this here, or via a .txt. file if it's long. Newlines / Enters will break it!
	var/path = null //The location at which we're stored. If you don't have this, you don't get content
	var/access_tag = "placeholder" //Set this to match the terminals that you want to be able to access it. EG "ntcommon" for declassified shit.

/datum/lore_entry/New()
	. = ..()
	if(path)
		content = file2text("[path]")

/*

TO GET THE COOL TYPEWRITER EFFECT, I HAD TO STRIP OUT THE HTML FORMATTING STUFF.
SPECIAL KEYS RESPOND AS FOLLOWS:

` = newline (br) (AKA when you press enter)
~ = horizontal line (hr)
� = bullet point

*/

/datum/lore_entry/station
	name = "new_employees_memo.mail"
	title = "Intercepted message"
	path = "lore_entries/welcome.txt"
	access_tag = "kncommon"

/datum/lore_entry/station/meltdown_proceedures
	name = "meltdown_proceedures.mail"
	title = "Emergency proceedures regarding nuclear meltdowns:"
	path = "lore_entries/meltdowns.txt"

/datum/lore_entry/command
	name = "command_memo.mail"
	title = "Intercepted Message"
	access_tag = "kncommand"
	classified = "Restricted"
	content = "SYSADMIN -> command@seegnet.kin. RE: Orientation. ` Greetings station command staff, congratulations on your placement! It is now company policy to attend all briefings as issued by centcom staff. Please speak to your centcom officer for clarification on the new procedures."

/datum/lore_entry/command/xeno
	name = "outpost_27.mail"
	title = "Investigation Closed"
	classified = "Classified"
	content = "SYSADMIN -> command@seegnet.kin. RE: Outpost 27 Investigation. ` Until further notice, all communications, visits and trade with Outpost 27 must be denied. It is recommended that the subject is avoided. Stay safe through vigilance."

/datum/lore_entry/away_example
	title = "Intercepted log file"
	access_tag = "awayexample"

/datum/lore_entry/away_example/pilot_log
	name = "pilot_log.txt"
	content = "They're coming in hot! Prepare for flip and bur']###�$55%%% -=File Access Terminated=-"

/datum/lore_entry/away_example/weapons_log
	name = "weapon_systems_dump2259/11/25.txt"
	content = "Life support systems terminated. Railgun system status: A6E3. Torpedo system status: ~@##6#6#^^6 -=File Access Terminated=-"

/datum/lore_entry/security
	name = "usage_and_terms.memo"
	title = "Usage and Terms"
	access_tag = "knsecurity"
	path = "lore_entries/security/usageandterms.txt"

/datum/lore_entry/security/introduction
	name = "introduction.memo"
	title = "Security Introduction"
	path = "lore_entries/security/introduction.txt"

/datum/lore_entry/security/basicgearandyou
	name = "gearbasics.memo"
	title = "Basic Gear and You"
	path = "lore_entries/security/basicgearandyou.txt"

/datum/lore_entry/security/advancedgearandyou
	name = "gearadvanced.memo"
	title = "Advanced Gear and You"
	path = "lore_entries/security/advancedgearandyou.txt"

/datum/lore_entry/security/defensivegearandyou
	name = "geardefensive.memo"
	title = "Defensive Gear and You"
	path = "lore_entries/security/defensivegearandyou.txt"

/datum/lore_entry/security/sop
	name = "standard_operating_procedure.txt"
	title = "Standard Operating Procedure"
	path = "lore_entries/security/wip.txt"

/datum/lore_entry/security/lowcrime
	name = "low_infractions.txt"
	title = "Minor Infractions"
	path = "lore_entries/security/wip.txt"

/datum/lore_entry/security/mediumcrime
	name = "medium_infractions.txt"
	title = "Medium-risk Infractions"
	path = "lore_entries/security/wip.txt"

/datum/lore_entry/security/highcrime
	name = "high_infractions.txt"
	title = "Dangerous Infractions"
	path = "lore_entries/security/wip.txt"

/datum/lore_entry/security/deltacrime
	name = "delta_infractions.txt"
	title = "Zealot-class Notice and Warning"
	path = "lore_entries/security/wip.txt"