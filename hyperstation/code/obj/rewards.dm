/obj/item/pen/bluemarker
	name = "blue marker"
	desc = "A simple blueberry scented marker."
	icon_state = "marker_blue"
	colour = "blue"

/obj/item/pen/bluemarker/attack_self(mob/user)
	user.emote("sniff")
	to_chat(user, "<span class='notice'>Ahh~ blueberries!</span>")

/obj/item/clothing/suit/napoleonic
	name = "napoleonic uniform"
	desc = "An heirloom passed down from the Gruber family dynasty."
	icon_state = "napoleonic"
	item_state = "napoleonic"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS

/obj/item/clothing/suit/shackles
	name = "Plastitanium Shackles"
	desc = "A set of heavy plastitanium shackles, there are chains still attatched"
	icon_state = "shackles"
	item_state = "shackles"
	icon = 'hyperstation/icons/mobs/rewards.dmi'
	alternate_worn_icon = 'hyperstation/icons/mobs/rewards.dmi'
	mutantrace_variation = NO_MUTANTRACE_VARIATION

/obj/item/clothing/suit/luwethtrench
	name = "Syndicate Commander's Coat"
	desc = "A sinister looking black and red jacket. The gold collar and shoulders denote that this belongs to a high ranking syndicate officer. A rather strange brooch is pinned to the coat, displaying a unique range of lustrous brass cracks through the deep blacks of it’s hammered finish."
	icon = 'hyperstation/icons/obj/clothing/rewards.dmi'
	alternate_worn_icon = 'hyperstation/icons/mobs/rewards.dmi'
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	icon_state = "luwethtrench"
	item_state = "luwethtrench"
	mutantrace_variation = NO_MUTANTRACE_VARIATION

/obj/item/clothing/gloves/ring/luweth
	name = "Luweth’s Wedding Band"
	icon = 'hyperstation/icons/obj/clothing/rewards.dmi'
	icon_state = "luweth"
	desc = "A seemingly natural yet rather rough brass ring, which shows off a unique range of lustrous brass cracks through the deep blacks of it’s hammered finish. 'Till death does us part.'"

/obj/item/dice/d20/blue
	name = "blue d20"
	desc = "Clearly the dice hate you."
	icon_state = "d20_blue"
	sides = 20
	unique = TRUE

/obj/item/clothing/suit/hooded/wintercoat/death
	name = "inconspicuous winter coat"
	icon_state = "rdeath"
	item_state = "rdeath"
	allowed = list(/obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/melee/classic_baton/telescopic, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/screwdriver, /obj/item/crowbar, /obj/item/wrench, /obj/item/stack/cable_coil, /obj/item/weldingtool, /obj/item/multitool)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/death

/obj/item/clothing/head/hooded/winterhood/death
	icon_state = "winterhood_death"

/obj/item/storage/pill_bottle/heat
	name = "heat-b-gone pill bottle"
	desc = "a bottle of pills from a sketchy pharmaceutical corporation. at the bottom of the label is a small red S."

/obj/item/reagent_containers/pill/heat
	name = "heat-b-gone pill"
	desc = "claims to be foolproof heat repression medication but it tastes extremely sweet."
	icon_state = "pill8"
	list_reagents = list(/datum/reagent/consumable/sugar = 10)
	roundstart = 1

/obj/item/storage/pill_bottle/heat/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/heat(src)

/obj/item/storage/pill_bottle/betablock
	name = "anaphrodisiacs pill bottle"
	desc = "a bottle of anaphrodisiacs."

/obj/item/reagent_containers/pill/betablock
	name = "anaphrodisiac pill"
	desc = "Prescribed to races that have trouble keeping their urges in check."
	icon_state = "pill5"
	list_reagents = list(/datum/reagent/drug/anaphrodisiac = 10)
	roundstart = 1

/obj/item/storage/pill_bottle/betablock/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/betablock(src)

/obj/item/clothing/head/crystalline
	name = "crystalline shards"
	icon = 'hyperstation/icons/obj/rewards.dmi'
	desc = "A handful of blue crystals. They look like they came from some sort of cave."
	alternate_worn_icon = 'hyperstation/icons/mobs/rewards.dmi'
	icon_state = "crystalline"

/obj/item/clothing/mask/keaton
	name = "keaton mask"
	desc = "A mask made to look like the mythical Keaton."
	icon = 'hyperstation/icons/obj/rewards.dmi'
	alternate_worn_icon = 'hyperstation/icons/mobs/rewards.dmi'
	icon_state = "keaton"
	flags_inv = HIDEFACE|HIDEFACIALHAIR
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/suit/chloe
	name = "Fleet Commander's Overcoat"
	desc = "Custom tailored to warm the cold commanding hearts of the Syndicate's feared XIV'th battle group. Its armour plating has been removed."
	icon_state = "commissar_greatcoat"
	item_state = "commissar_greatcoat"
	allowed = list(/obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/melee/classic_baton/telescopic, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/screwdriver, /obj/item/crowbar, /obj/item/wrench, /obj/item/stack/cable_coil, /obj/item/weldingtool, /obj/item/multitool)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	mutantrace_variation = MUTANTRACE_VARIATION
	tauric = TRUE

/obj/item/clothing/head/chloe
	name = "Fleet Commander's Beret"
	desc = "A beret bearing a worn golden symbol that stikes fear in the hearts of many. It smells faintly of plasma and gunpowder."
	icon = 'hyperstation/icons/obj/clothing/rewards.dmi'
	alternate_worn_icon = 'hyperstation/icons/mobs/rewards.dmi'
	icon_state = "commissar_beret"
	item_state = "commissar_beret"

/obj/item/clothing/under/touchinfuzzy
	name = "provocative jumpsuit"
	desc = "A form fitting jumpsuit with a golden trim zipper! Smells faintly of succubus milk."
	icon_state = "touchinfuzzyuni"
	item_state = "touchinfuzzyuni"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	fitted = NO_FEMALE_UNIFORM

/obj/item/toy/sword/chloesabre
	name = "Fleet Commander's Sabre"
	desc = "An elegant weapon, similar in design to the Captain's Sabre, but with a syndicate twist."
	icon = 'icons/obj/custom.dmi'
	alternate_worn_icon = 'icons/mob/custom_w.dmi'
	icon_state = "darksabre"
	item_state = "darksabre"
	force = 5
	throwforce = 5
	hitsound = 'sound/weapons/rapierhit.ogg'
	lefthand_file = 'modular_citadel/icons/mob/inhands/stunsword_left.dmi'
	righthand_file = 'modular_citadel/icons/mob/inhands/stunsword_right.dmi'
	obj_flags = UNIQUE_RENAME
	attack_verb = list("slashed", "cut")

/obj/item/toy/sword/chloesabre/get_belt_overlay()
	return mutable_appearance('icons/obj/custom.dmi', "darksheath-darksabre")

/obj/item/toy/sword/chloesabre/get_worn_belt_overlay(icon_file)
	return mutable_appearance(icon_file, "darksheath-darksabre")

/obj/item/mialasscale
	name = "Miala's Scale"
	desc = "A bright, and familiar, cyan scale from an equally familiar snake being."
	icon = 'hyperstation/icons/obj/rewards.dmi'
	icon_state = "m_scale"
	item_state = "m_scale"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/bong/kiseru
	name = "black lacquered kiseru"
	desc = "it is a black lacquered kiseru with a ornate silver head and mouthpiece, you can feel it's old age as you hold it"
	icon = 'hyperstation/icons/obj/rewards.dmi'
	icon_state = null
	item_state = null
	w_class = WEIGHT_CLASS_NORMAL
	light_color = "#FFCC66"
	icon_off = "pipe"
	icon_on = "pipe_lit"
