// Watermelon
/obj/item/seeds/watermelon
	name = "pack of watermelon seeds"
	desc = "These seeds grow into watermelon plants."
	icon_state = "seed-watermelon"
	species = "watermelon"
	plantname = "Watermelon Vines"
	product = /obj/item/reagent_containers/food/snacks/grown/watermelon
	lifespan = 50
	endurance = 40
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_dead = "watermelon-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutate_factor = PLANT_MUTATE_CUSTOM	//Custom to make lewd melon more rare in case of more "serious" scenarios, see mutatespecie()
	reagents_add = list(/datum/reagent/water = 0.2, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.2)

/obj/item/seeds/watermelon/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is swallowing [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	user.gib()
	new product(drop_location())
	qdel(src)
	return MANUAL_SUICIDE

/obj/item/seeds/watermelon/mutatespecie()
	. = ..()
	if (src != /obj/item/seeds/watermelon && . != PLANT_MUTATE_CUSTOM)
		return

	if (prob(70))
		mutatelist = /obj/item/seeds/watermelon/holy
	else
		mutatelist = /obj/item/seeds/watermelon/milk

/obj/item/reagent_containers/food/snacks/grown/watermelon
	seed = /obj/item/seeds/watermelon
	name = "watermelon"
	desc = "It's full of watery goodness."
	icon_state = "watermelon"
	slice_path = /obj/item/reagent_containers/food/snacks/watermelonslice
	slices_num = 5
	dried_type = null
	w_class = WEIGHT_CLASS_NORMAL
	filling_color = "#008000"
	bitesize_mod = 3
	foodtype = FRUIT
	juice_results = list(/datum/reagent/consumable/watermelonjuice = 0)
	wine_power = 40

// Holymelon
/obj/item/seeds/watermelon/holy
	name = "pack of holymelon seeds"
	desc = "These seeds grow into holymelon plants."
	icon_state = "seed-holymelon"
	species = "holymelon"
	plantname = "Holy Melon Vines"
	product = /obj/item/reagent_containers/food/snacks/grown/holymelon
	genes = list(/datum/plant_gene/trait/glow/yellow)
	mutate_factor = PLANT_MUTATE_CANNOTMUTATE
	reagents_add = list(/datum/reagent/water/holywater = 0.2, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)
	rarity = 20

/obj/item/reagent_containers/food/snacks/grown/holymelon
	seed = /obj/item/seeds/watermelon/holy
	name = "holymelon"
	desc = "The water within this melon has been blessed by some deity that's particularly fond of watermelon."
	icon_state = "holymelon"
	filling_color = "#FFD700"
	dried_type = null
	wine_power = 70 //Water to wine, baby.
	wine_flavor = "divinity"

/obj/item/reagent_containers/food/snacks/grown/holymelon/Initialize()
	. = ..()
	AddComponent(/datum/component/anti_magic, TRUE, TRUE) //deliver us from evil o melon god

//Milkmelon
/obj/item/seeds/watermelon/milk
	name = "pack of milkmelon seeds"
	desc = "These seeds grow into Milkmelon plants."
	icon_state = "seed-milkmelon"
	species = "milkmelon"
	plantname = "Milk Melon Vines"
	product = /obj/item/reagent_containers/food/snacks/grown/milkmelon
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/reagent/unextractable/succubus)
	mutate_factor = PLANT_MUTATE_CANNOTMUTATE
	reagents_add = list(/datum/reagent/consumable/milk = 0.2, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)
	rarity = 20

/obj/item/reagent_containers/food/snacks/grown/milkmelon
	seed = /obj/item/seeds/watermelon/milk
	name = "milkmelon"
	desc = "A softer, rounder-looking watermelon that audibly sloshes with milk."
	icon_state = "milkmelon"
	filling_color = "#FFAABB"
	dried_type = null
	wine_power = 30
	wine_flavor = "creamy"