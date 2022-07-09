//Duo malfunctioning cryostasis sleepers: Spawns in big makeshift shelters in lavaland.
/obj/effect/mob_spawn/human/duohermit
	name = "malfunctioning cryostasis sleeper"
	desc = "A humming sleeper with a silhouetted occupant inside. Its stasis function is broken and it's likely being used as a bed."
	mob_name = "a stranded hermit"
	job_description = "Lavaland Hermit"
	icon = 'icons/obj/lavaland/spawners.dmi'
	icon_state = "cryostasis_sleeper"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	short_desc = "You are lost."
	flavour_text = "You and another have been stranded in this planet for quite some time now. Each day you barely scrape by, and between the terrible \
	conditions of your makeshift shelter, the hostile creatures, and the ash drakes swooping down from the cloudless skies, all you can wish for is the feel of soft grass between your toes and \
	the fresh air of Earth. These thoughts are dispelled by yet another recollection of how you and your friend got here... "
	assignedrole = "Hermit"
	mirrorcanloadappearance = TRUE

/obj/effect/mob_spawn/human/duohermit/Initialize(mapload)
	. = ..()
	var/arrpee = rand(1,3)
	switch(arrpee)
		if(1)
			flavour_text += "you were an intern at a rather odd deep space facility. You weren't quite sure how things worked or what they were doing there, but it was your first day on the \
			job. A day that was abruptly interrupted by gunfire and alarms. Luckily enough, your handy crowbar skills managed to get you to an escape pod before it was too late.</b>"
			outfit.uniform = /obj/item/clothing/under/assistantformal
			outfit.shoes = /obj/item/clothing/shoes/sneakers/black
			outfit.back = /obj/item/storage/backpack
		if(2)
			flavour_text += "you were a volunteer test subject for a state of the art deep space facility. You didn't care much about who you were working with, but in the end, the paycheck \
			was really, really good. To this day, you're not quite sure which sort of prototype implants were used on you, as you seem to remember little but the headache that struck you once \
			the escape pod finally hit the ground and your seatbelt failed to keep you buckled.</b>"
			outfit.uniform = /obj/item/clothing/under/rank/scientist
			outfit.suit = /obj/item/clothing/suit/toggle/labcoat
			outfit.shoes = /obj/item/clothing/shoes/sneakers/black
			outfit.back = /obj/item/storage/backpack
		if(3)
			flavour_text += "you were a doctor at a state of the art deep space facility. For who exactly you were conducting research for, not even you are quite sure. Only that the paycheck \
			at the end of the month was good enough. In the end, when said facility was attacked by Nanotransen, you and another were the only ones to have made it out alive. Or so it seemed.</b>"
			outfit.uniform = /obj/item/clothing/under/rank/medical
			outfit.suit = /obj/item/clothing/suit/toggle/labcoat
			outfit.back = /obj/item/storage/backpack/medic
			outfit.shoes = /obj/item/clothing/shoes/sneakers/black

/obj/effect/mob_spawn/human/duohermit/Destroy()
	new/obj/structure/fluff/empty_cryostasis_sleeper(get_turf(src))
	return ..()

/obj/effect/mob_spawn/human/duohermit/special(mob/living/carbon/human/new_spawn)
	ADD_TRAIT(new_spawn,TRAIT_EXEMPT_HEALTH_EVENTS,GHOSTROLE_TRAIT)

//Exiles: Stranded exiles that have been left in Snowdin. Can be easily adapted for other roles as well.
/obj/effect/mob_spawn/human/exiled
	name = "used bed"
	desc = "Still warm."
	mob_name = "exiled"
	job_description = "Exiles"
	icon = 'icons/obj/objects.dmi'
	icon_state = "bed"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	short_desc = "You've been left behind."
	flavour_text = "As the last escape shuttle left the sector, you were left for dead, stranded in a cold hell where you make do, until hopefully someone finds you. \
	Every day, you pause and recollect your memories from before it all happened... "
	assignedrole = "Arctic Exile"
	mirrorcanloadappearance = TRUE
	ghost_usable = FALSE

/obj/effect/mob_spawn/human/exiled/Initialize(mapload)
	. = ..()
	delayusability(9000, FALSE) //Probably should not show up on the menu? It gives it away that snowdin is the away mission.
	var/arrpee = rand(1,3)
	switch(arrpee)
		if(1)
			flavour_text += "You were a lowly engineer, hired by Kinaris to make sure the turbines from their mining operation remained functional. \
			You remember the day the mining team descended for the very last time into the depths of the shafts, only to never return. \
			The agonizing screams from whatever now haunts those mines still brings a shiver down your spine."
			outfit.uniform = /obj/item/clothing/under/rank/engineer
			outfit.suit = /obj/item/clothing/suit/hooded/wintercoat/engineering
			outfit.shoes = /obj/item/clothing/shoes/sneakers/black
			outfit.back = /obj/item/storage/backpack/industrial
			outfit.id = /obj/item/card/id/away/snowdin/eng
			outfit.implants = list(/obj/item/implant/exile) //Made it so they cannot simply exit through the gateway at will.
		if(2)
			flavour_text += "You were a plasma researcher, hired by Kinaris to oversee a small research division in a remote, isolated little icy planet, \
			you remember the day the mining team descended for the very last time into the depths of the shafts, only to never return. \
			While you haven't heard them yourself, reports say the sounds that were heard over radio were likely not of this world."
			outfit.uniform = /obj/item/clothing/under/rank/scientist
			outfit.suit = /obj/item/clothing/suit/hooded/wintercoat/science
			outfit.shoes = /obj/item/clothing/shoes/sneakers/black
			outfit.back = /obj/item/storage/backpack/science
			outfit.id = /obj/item/card/id/away/snowdin/sci
			outfit.implants = list(/obj/item/implant/exile) //Made it so they cannot simply exit through the gateway at will.
		if(3)
			flavour_text += "You were a junior doctor, hired by Kinaris to oversee the mental state of a plasma mining operation's miners. \
			Over and over you reported that the miners were having constant, similar types of hallucinations and that perhaps the whole operation should pause \
			until further investigation was concluded, but command shrugged it off as an episode of mass hallucination... Until the miners never came back."
			outfit.uniform = /obj/item/clothing/under/rank/medical
			outfit.suit = /obj/item/clothing/suit/hooded/wintercoat/medical
			outfit.shoes = /obj/item/clothing/shoes/sneakers/black
			outfit.back = /obj/item/storage/backpack/medic
			outfit.id = /obj/item/card/id/away/snowdin/med
			outfit.implants = list(/obj/item/implant/exile) //Made it so they cannot simply exit through the gateway at will.

/obj/effect/mob_spawn/human/exiled/Destroy()
	new/obj/structure/bed(get_turf(src))
	return ..()

/obj/effect/mob_spawn/human/exiled/special(mob/living/carbon/human/new_spawn)
	ADD_TRAIT(new_spawn,TRAIT_EXEMPT_HEALTH_EVENTS,GHOSTROLE_TRAIT)

//Villagers: Once a group of servants that worshiped their 'Gods-Kings', but now finally free after their overlords have abandoned the planet.

/obj/effect/mob_spawn/human/villager
	name = "used bed"
	desc = "Still warm."
	mob_name = "villager"
	job_description = "Villagers"
	icon = 'icons/obj/objects.dmi'
	icon_state = "bed"
	roundstart = FALSE
	death = FALSE
	mob_species = /datum/species/human
	short_desc = "You're finally free."
	flavour_text = "After the God-Kings have abandoned the land, your people are finally free from their oppression. \
	Still, the reasons for their departure are a mystery, and now your people need to work together to survive in this world."
	assignedrole = "Free villager"
	mirrorcanloadappearance = TRUE

/obj/effect/mob_spawn/human/villager/Initialize(mapload)
	. = ..()
	var/arrpee = rand(1,3)
	switch(arrpee)
		if(1)
			flavour_text += "You were a guard, serving your gods to keep control of you own people. \
			Now that they left, you work to defend the village."
			outfit.head = /obj/item/clothing/head/pharaoh
			outfit.uniform = /obj/item/clothing/under/tunic
			outfit.shoes = /obj/item/clothing/shoes/sandal
			outfit.back = /obj/item/storage/backpack/satchel/leather
			outfit.implants = list(/obj/item/implant/exile) //Made it so they cannot simply exit through the gateway at will.
		if(2)
			flavour_text += "You were a farmer, working extensively for years in the field to feed your people. \
			The work hasn't changed much since the departure of the gods..."
			outfit.head = /obj/item/clothing/head/rice_hat
			outfit.uniform = /obj/item/clothing/under/tunic
			outfit.shoes = /obj/item/clothing/shoes/sandal
			outfit.back = /obj/item/storage/backpack/satchel/leather
			outfit.implants = list(/obj/item/implant/exile) //Made it so they cannot simply exit through the gateway at will.
		if(3)
			flavour_text += "You were a servant, doing any necessary work that was thrown at you. \
			At least it gave you experience in a bit of everything, which can be useful in these new times."
			outfit.uniform = /obj/item/clothing/under/mummy
			outfit.uniform = /obj/item/clothing/under/tunic
			outfit.shoes = /obj/item/clothing/shoes/sandal
			outfit.back = /obj/item/storage/backpack/satchel/leather
			outfit.implants = list(/obj/item/implant/exile) //Made it so they cannot simply exit through the gateway at will.

/obj/effect/mob_spawn/human/villager/Destroy()
	new/obj/structure/bed(get_turf(src))
	return ..()

/obj/effect/mob_spawn/human/villager/special(mob/living/carbon/human/new_spawn)
	ADD_TRAIT(new_spawn,TRAIT_EXEMPT_HEALTH_EVENTS,GHOSTROLE_TRAIT)
