/*

LEGION

Legion spawns from the necropolis gate in the far north of lavaland. It is the guardian of the Necropolis and emerges from within whenever an intruder tries to enter through its gate.
Whenever Legion emerges, everything in lavaland will receive a notice via color, audio, and text. This is because Legion is powerful enough to slaughter the entirety of lavaland with little effort.

It has two attack modes that it constantly rotates between.

In ranged mode, it will behave like a normal legion - retreating when possible and firing legion skulls at the target.
In charge mode, it will spin and rush its target, attacking with melee whenever possible.

When Legion dies, it drops a staff of storms, which allows its wielder to call and disperse ash storms at will and functions as a powerful melee weapon.

Difficulty: Medium

*/

/mob/living/simple_animal/hostile/megafauna/legion
	name = "Legion"
	health = 800
	maxHealth = 800
	spacewalk = TRUE
	icon_state = "legion"
	icon_living = "legion"
	desc = "One of many."
	icon = 'icons/mob/lavaland/legion.dmi'
	attacktext = "chomps"
	attack_sound = 'sound/magic/demon_attack1.ogg'
	speak_emote = list("echoes")
	armour_penetration = 50
	melee_damage_lower = 25
	melee_damage_upper = 25
	speed = 1
	move_to_delay = 2
	ranged = 1
	del_on_death = 1
	retreat_distance = 5
	minimum_distance = 5
	ranged_cooldown_time = 10
	var/size = 5
	var/charging = 0
	medal_type = BOSS_MEDAL_LEGION
	score_type = LEGION_SCORE
	pixel_y = -90
	pixel_x = -75
	loot = list(/obj/item/stack/sheet/bone = 3)
	vision_range = 10
	wander = FALSE
	elimination = 1
	appearance_flags = LONG_GLIDE
	mouse_opacity = MOUSE_OPACITY_ICON

/mob/living/simple_animal/hostile/megafauna/legion/Initialize()
	. = ..()
	internal = new/obj/item/gps/internal/legion(src)

/mob/living/simple_animal/hostile/megafauna/legion/GiveTarget(new_target)
	. = ..()
	if(target)
		wander = TRUE

/mob/living/simple_animal/hostile/megafauna/legion/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	if(GLOB.necropolis_gate)
		GLOB.necropolis_gate.toggle_the_gate(null, TRUE) //very clever.
	return ..()

/mob/living/simple_animal/hostile/megafauna/legion/AttackingTarget()
	. = ..()
	if(. && ishuman(target))
		var/mob/living/L = target
		if(L.stat == UNCONSCIOUS)
			var/mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion/A = new(loc)
			A.infest(L)

/mob/living/simple_animal/hostile/megafauna/legion/OpenFire(the_target)
	if(world.time >= ranged_cooldown && !charging)
		if(prob(75))
			var/mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion/A = new(loc)
			A.GiveTarget(target)
			A.friends = friends
			A.faction = faction
			ranged_cooldown = world.time + ranged_cooldown_time
		else
			visible_message("<span class='warning'><b>[src] charges!</b></span>")
			SpinAnimation(speed = 20, loops = 5)
			ranged = 0
			retreat_distance = 0
			minimum_distance = 0
			speed = 0
			move_to_delay = 1
			charging = 1
			addtimer(CALLBACK(src, .proc/reset_charge), 50)

/mob/living/simple_animal/hostile/megafauna/legion/proc/reset_charge()
	ranged = 1
	retreat_distance = 5
	minimum_distance = 5
	speed = 1
	move_to_delay = 2
	charging = 0

/mob/living/simple_animal/hostile/megafauna/legion/death()
	if(health > 0)
		return
	if(size > 1)
		adjustHealth(-maxHealth) //heal ourself to full in prep for splitting
		var/mob/living/simple_animal/hostile/megafauna/legion/L = new(loc)

		L.maxHealth = round(maxHealth * 0.6,DAMAGE_PRECISION)
		maxHealth = L.maxHealth

		L.health = L.maxHealth
		health = maxHealth

		size--
		L.size = size

		L.resize = L.size * 0.2
		transform = initial(transform)
		resize = size * 0.2

		L.update_transform()
		update_transform()

		L.faction = faction.Copy()

		L.GiveTarget(target)

		visible_message("<span class='boldannounce'>[src] splits in twain!</span>")
	else
		var/last_legion = TRUE
		for(var/mob/living/simple_animal/hostile/megafauna/legion/other in GLOB.mob_living_list)
			if(other != src)
				last_legion = FALSE
				break
		if(last_legion)
			loot = list(/obj/structure/closet/crate/necropolis/legion)
			elimination = 0
		else if(prob(5))
			loot = list(/obj/structure/closet/crate/necropolis/tendril)
		..()

/obj/item/gps/internal/legion
	icon_state = null
	gpstag = "Echoing Signal"
	desc = "The message repeats."
	invisibility = 100

