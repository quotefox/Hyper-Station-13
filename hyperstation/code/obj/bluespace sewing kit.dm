//Jay Sparrow
#define ROOMY = "ROOMY"
//Sorry jay, I killed it.

/obj/item/bluespace_thread
	name = "Bluespace Sewing Kit"
	desc = "Thread infused with bluespace dust to make your clothes a little more roomy. Current sewing technology already incorporates this, so thankfully, the days of needing these are long gone. Good souvenir though."
	icon = 'hyperstation/icons/obj/bluespace_thread.dmi'
	icon_state = "thread"
	item_state = "thread"
	var/uses = 5 //Give it a few charges so it can last through the shift
	w_class = WEIGHT_CLASS_TINY

/obj/item/bluespace_thread/attack_obj(obj/O, mob/living/user)
    . = ..()
    if(!istype(O, /obj/item/clothing))
        user.show_message("<span class='notice'>You find yourself unable to stitch this.</span>", 1)
        return

/obj/item/bluespace_thread/attack_self(mob/living/user)
    user.show_message("<span class='notice'>The spool has [uses] uses remaining.</span>", 1)

//Let's add this to the loadout screen
/datum/gear/bluespace_thread
	name = "Bluespace Sewing Kit"
	category = SLOT_IN_BACKPACK
	path = /obj/item/bluespace_thread

//Crafting recipe
/datum/crafting_recipe/bluespace_thread
	name = "Bluespace Sewing Kit"
	result = /obj/item/bluespace_thread
	time = 40
	reqs = list(/obj/item/stack/ore/bluespace_crystal = 1,
				/obj/item/stack/sheet/cloth = 3)
	category = CAT_MISC
