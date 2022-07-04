/obj/item/clothing/suit/kaminacape
	name = "Kamina's Cape"
	desc = "Don't believe in yourself, dumbass. Believe in me. Believe in the Kamina who believes in you."
	icon_state = "kaminacape"
	item_state = "kaminacape"
	body_parts_covered = 0
	icon = 'hyperstation/icons/obj/clothing/suits.dmi'
	alternate_worn_icon = 'hyperstation/icons/mobs/suits.dmi'
	mutantrace_variation = NO_MUTANTRACE_VARIATION

/obj/item/clothing/suit/gcvest
	name = "\improper Guncaster's Vest"
	desc = "An open leather vest with battlescarred metal shoulderpads, perfect for hunting interdimensional wazards. Smells of gunpowder and plasma."
	icon_state = "guncaster"
	item_state = "guncaster"
	icon = 'hyperstation/icons/obj/clothing/suits.dmi'
	alternate_worn_icon = 'hyperstation/icons/mobs/suits.dmi'
	mutantrace_variation = NO_MUTANTRACE_VARIATION

/obj/item/clothing/suit/gcvest/alt
	name = "\improper Hellraider's Vest"
	desc = "An open leather vest with battlescarred metal shoulderpads, discovered in a dimensional anomaly. Smells of gunpowder and plasma."
	icon_state = "guncaster_alt"
	item_state = "guncaster_alt"

/*
 * Posshim's Corpus atire
 */
 //Making this a subset of wintercoats/winterhoods since poss intends it to have wintercoat stats --Archie
 
/obj/item/clothing/suit/hooded/wintercoat/corpus
	name = "Standard Voidsuit"
	desc = "Standard issue voidsuit in the name of Grofit!"
	icon_state = "corpus"
	item_state = "armor"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|FEET|HANDS
	hoodtype = /obj/item/clothing/head/hooded/winterhood/corpus
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT //"Hide shoes" but digi shoes dont get hidden, too bad!
	mutantrace_variation = NO_MUTANTRACE_VARIATION //There is no need for a digi variant, it's a costume

/obj/item/clothing/suit/hooded/wintercoat/corpus/sec
	name = "Enforcer Voidsuit"
	desc = "Delux issue grofit voidsuit. Let the middle class know You're in charge."
	icon_state = "corpuss"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/corpus/sec //Enjoy this nice red outfit Kinaris! There is NO NEED for a pink one! xoxo -VivI Fanteriso

/obj/item/clothing/suit/hooded/wintercoat/corpus/command
	name = "Commander Voidsuit"
	desc = "Premium issue correctional worker attire. Grease the gears of production."
	icon_state = "corpusc"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/corpus/command

/obj/item/clothing/head/hooded/winterhood/corpus
	name = "Voidsuit helmet"
	desc = "galvanized reinforced helm to protect against the elements"
	icon_state = "corpus"
	flags_inv = HIDEHAIR|HIDEEARS|HIDEFACIALHAIR|HIDEFACE|HIDEMASK|HIDESNOUT|HIDENECK //hide your ugly face with this one simple trick!

/obj/item/clothing/head/hooded/winterhood/corpus/sec
	icon_state = "corpuss"

/obj/item/clothing/head/hooded/winterhood/corpus/command
	icon_state = "corpusc"