/datum/plant_gene
	var/name
	var/mutability_flags = PLANT_GENE_EXTRACTABLE | PLANT_GENE_REMOVABLE ///These flags tells the genemodder if we want the gene to be extractable, only removable or neither.

/datum/plant_gene/proc/get_name() // Used for manipulator display and gene disk name.
	var/formatted_name
	if(!(mutability_flags & PLANT_GENE_REMOVABLE && mutability_flags & PLANT_GENE_EXTRACTABLE))
		if(mutability_flags & PLANT_GENE_REMOVABLE)
			formatted_name += "Fragile "
		else if(mutability_flags & PLANT_GENE_EXTRACTABLE)
			formatted_name += "Essential "
		else
			formatted_name += "Immutable "
	formatted_name += name
	return formatted_name

/datum/plant_gene/proc/can_add(obj/item/seeds/S)
	return !istype(S, /obj/item/seeds/sample) // Samples can't accept new genes

/datum/plant_gene/proc/Copy()
	var/datum/plant_gene/G = new type
	G.mutability_flags = mutability_flags
	return G

/datum/plant_gene/proc/apply_vars(obj/item/seeds/S) // currently used for fire resist, can prob. be further refactored
	return

// Core plant genes store 5 main variables: lifespan, endurance, production, yield, potency
/datum/plant_gene/core
	var/value

/datum/plant_gene/core/get_name()
	return "[name] [value]"

/datum/plant_gene/core/proc/apply_stat(obj/item/seeds/S)
	return

/datum/plant_gene/core/New(var/i = null)
	..()
	if(!isnull(i))
		value = i

/datum/plant_gene/core/Copy()
	var/datum/plant_gene/core/C = ..()
	C.value = value
	return C

/datum/plant_gene/core/can_add(obj/item/seeds/S)
	if(!..())
		return FALSE
	return S.get_gene(src.type)

/datum/plant_gene/core/lifespan
	name = "Lifespan"
	value = 25

/datum/plant_gene/core/lifespan/apply_stat(obj/item/seeds/S)
	S.lifespan = value


/datum/plant_gene/core/endurance
	name = "Endurance"
	value = 15

/datum/plant_gene/core/endurance/apply_stat(obj/item/seeds/S)
	S.endurance = value


/datum/plant_gene/core/production
	name = "Production Speed"
	value = 6

/datum/plant_gene/core/production/apply_stat(obj/item/seeds/S)
	S.production = value


/datum/plant_gene/core/yield
	name = "Yield"
	value = 3

/datum/plant_gene/core/yield/apply_stat(obj/item/seeds/S)
	S.yield = value


/datum/plant_gene/core/potency
	name = "Potency"
	value = 10

/datum/plant_gene/core/potency/apply_stat(obj/item/seeds/S)
	S.potency = value


/datum/plant_gene/core/weed_rate
	name = "Weed Growth Rate"
	value = 1

/datum/plant_gene/core/weed_rate/apply_stat(obj/item/seeds/S)
	S.weed_rate = value


/datum/plant_gene/core/weed_chance
	name = "Weed Vulnerability"
	value = 5

/datum/plant_gene/core/weed_chance/apply_stat(obj/item/seeds/S)
	S.weed_chance = value


// Reagent genes store reagent ID and reagent ratio. Amount of reagent in the plant = 1 + (potency * rate)
/datum/plant_gene/reagent
	name = "Nutriment"
	var/reagent_id = /datum/reagent/consumable/nutriment
	var/rate = 0.04

/datum/plant_gene/reagent/get_name()
	var/formatted_name
	if(!(mutability_flags & PLANT_GENE_REMOVABLE && mutability_flags & PLANT_GENE_EXTRACTABLE))
		if(mutability_flags & PLANT_GENE_REMOVABLE)
			formatted_name += "Fragile "
		else if(mutability_flags & PLANT_GENE_EXTRACTABLE)
			formatted_name += "Essential "
		else
			formatted_name += "Immutable "
	formatted_name += "[name] production [rate*100]%"
	return formatted_name

/datum/plant_gene/reagent/proc/set_reagent(reag_id)
	reagent_id = reag_id
	name = "UNKNOWN"

	var/datum/reagent/R = GLOB.chemical_reagents_list[reag_id]
	if(R && R.type == reagent_id)
		name = R.name

/datum/plant_gene/reagent/New(reag_id = null, reag_rate = 0)
	..()
	if(reag_id && reag_rate)
		set_reagent(reag_id)
		rate = reag_rate

/datum/plant_gene/reagent/Copy()
	var/datum/plant_gene/reagent/G = ..()
	G.name = name
	G.reagent_id = reagent_id
	G.rate = rate
	return G

/datum/plant_gene/reagent/can_add(obj/item/seeds/S)
	if(!..())
		return FALSE
	for(var/datum/plant_gene/reagent/R in S.genes)
		if(R.reagent_id == reagent_id)
			return FALSE
	return TRUE

/datum/plant_gene/reagent/fragile
	name = "Fragile Gene"
	mutability_flags = PLANT_GENE_REMOVABLE	//Cannot be extracted

/datum/plant_gene/reagent/fragile/polypyr
	name = "Polypyrylium Oligomers"
	reagent_id = /datum/reagent/medicine/polypyr
	rate = 0.15

/datum/plant_gene/reagent/fragile/teslium
	name = "Teslium"
	reagent_id = /datum/reagent/teslium
	rate = 0.1

/datum/plant_gene/reagent/fragile/breastchem
	name = "Succubus Milk"
	reagent_id = /datum/reagent/fermi/breast_enlarger
	rate = 0.04	//5 units at 100 potency

/datum/plant_gene/reagent/fragile/penischem
	name = "Incubus Draft"
	reagent_id = /datum/reagent/fermi/penis_enlarger
	rate = 0.04

/datum/plant_gene/reagent/fragile/crocin
	name = "Crocin"
	reagent_id = /datum/reagent/drug/aphrodisiac
	rate = 0.2

// Various traits affecting the product.
/datum/plant_gene/trait
	var/rate = 0.05
	var/examine_line = ""
	var/trait_id // must be set and equal for any two traits of the same type

/datum/plant_gene/trait/Copy()
	var/datum/plant_gene/trait/G = ..()
	G.rate = rate
	return G

/datum/plant_gene/trait/can_add(obj/item/seeds/S)
	if(!..())
		return FALSE

	for(var/datum/plant_gene/trait/R in S.genes)
		if(trait_id && R.trait_id == trait_id)
			return FALSE
		if(type == R.type)
			return FALSE
	return TRUE

/datum/plant_gene/trait/proc/on_new(obj/item/reagent_containers/food/snacks/grown/G, newloc)
	return

/datum/plant_gene/trait/proc/on_consume(obj/item/reagent_containers/food/snacks/grown/G, mob/living/carbon/target)
	return

/datum/plant_gene/trait/proc/on_slip(obj/item/reagent_containers/food/snacks/grown/G, mob/living/carbon/target)
	return

/datum/plant_gene/trait/proc/on_squash(obj/item/reagent_containers/food/snacks/grown/G, atom/target)
	return

/datum/plant_gene/trait/proc/on_attackby(obj/item/reagent_containers/food/snacks/grown/G, obj/item/I, mob/user)
	return

/datum/plant_gene/trait/proc/on_throw_impact(obj/item/reagent_containers/food/snacks/grown/G, atom/target)
	return

///This proc triggers when the tray processes and a roll is sucessful, the success chance scales with production.
/datum/plant_gene/trait/proc/on_grow(obj/machinery/hydroponics/H)
	return

/datum/plant_gene/trait/squash
	// Allows the plant to be squashed when thrown or slipped on, leaving a colored mess and trash type item behind.
	// Also splashes everything in target turf with reagents and applies other trait effects (teleporting, etc) to the target by on_squash.
	// For code, see grown.dm
	name = "Liquid Contents"
	examine_line = "<span class='info'>It has a lot of liquid contents inside.</span>"

/datum/plant_gene/trait/slip
	// Makes plant slippery, unless it has a grown-type trash. Then the trash gets slippery.
	// Applies other trait effects (teleporting, etc) to the target by on_slip.
	name = "Slippery Skin"
	rate = 1.6
	examine_line = "<span class='info'>It has a very slippery skin.</span>"

/datum/plant_gene/trait/slip/on_new(obj/item/reagent_containers/food/snacks/grown/G, newloc)
	..()
	if(istype(G) && ispath(G.trash, /obj/item/grown))
		return
	var/obj/item/seeds/seed = G.seed
	var/stun_len = seed.potency * rate

	if(!istype(G, /obj/item/grown/bananapeel) && (!G.reagents || !G.reagents.has_reagent(/datum/reagent/lube)))
		stun_len /= 3

	G.AddComponent(/datum/component/slippery, min(stun_len,140), NONE, CALLBACK(src, .proc/handle_slip, G))

/datum/plant_gene/trait/slip/proc/handle_slip(obj/item/reagent_containers/food/snacks/grown/G, mob/M)
	for(var/datum/plant_gene/trait/T in G.seed.genes)
		T.on_slip(G, M)

/datum/plant_gene/trait/cell_charge
	// Cell recharging trait. Charges all mob's power cells to (potency*rate)% mark when eaten.
	// Generates sparks on squash.
	// Small (potency*rate*5) chance to shock squish or slip target for (potency*rate*5) damage.
	// Also affects plant batteries see capatative cell production datum
	name = "Electrical Activity"
	rate = 0.2

/datum/plant_gene/trait/cell_charge/on_slip(obj/item/reagent_containers/food/snacks/grown/G, mob/living/carbon/C)
	var/power = G.seed.potency*rate
	if(prob(power))
		C.electrocute_act(round(power), G, 1, 1)

/datum/plant_gene/trait/cell_charge/on_squash(obj/item/reagent_containers/food/snacks/grown/G, atom/target)
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		var/power = G.seed.potency*rate
		if(prob(power))
			C.electrocute_act(round(power), G, 1, 1)

/datum/plant_gene/trait/cell_charge/on_consume(obj/item/reagent_containers/food/snacks/grown/G, mob/living/carbon/target)
	if(!G.reagents.total_volume)
		var/batteries_recharged = 0
		for(var/obj/item/stock_parts/cell/C in target.GetAllContents())
			var/newcharge = min(G.seed.potency*0.01*C.maxcharge, C.maxcharge)
			if(C.charge < newcharge)
				C.charge = newcharge
				if(isobj(C.loc))
					var/obj/O = C.loc
					O.update_icon() //update power meters and such
				C.update_icon()
				batteries_recharged = 1
		if(batteries_recharged)
			to_chat(target, "<span class='notice'>Your batteries are recharged!</span>")



/datum/plant_gene/trait/glow
	// Makes plant glow. Makes plant in tray glow too.
	// Adds 1 + potency*rate light range and potency*(rate + 0.01) light_power to products.
	name = "Bioluminescence"
	rate = 0.03
	examine_line = "<span class='info'>It emits a soft glow.</span>"
	trait_id = "glow"
	var/glow_color = "#C3E381"

/datum/plant_gene/trait/glow/proc/glow_range(obj/item/seeds/S)
	return 1.4 + S.potency*rate

/datum/plant_gene/trait/glow/proc/glow_power(obj/item/seeds/S)
	return max(S.potency*(rate + 0.01), 0.1)

/datum/plant_gene/trait/glow/on_new(obj/item/reagent_containers/food/snacks/grown/G, newloc)
	..()
	G.set_light(glow_range(G.seed), glow_power(G.seed), glow_color)

/datum/plant_gene/trait/glow/shadow
	//makes plant emit slightly purple shadows
	//adds -potency*(rate*0.2) light power to products
	name = "Shadow Emission"
	rate = 0.04
	glow_color = "#AAD84B"

/datum/plant_gene/trait/glow/shadow/glow_power(obj/item/seeds/S)
	return -max(S.potency*(rate*0.2), 0.2)

//Colored versions of bioluminescence.
datum/plant_gene/trait/glow/white
	name = "White Bioluminescence"
	glow_color = "#FFFFFF"

/datum/plant_gene/trait/glow/red
	name = "Red Bioluminescence"
	glow_color = "#FF3333"

/datum/plant_gene/trait/glow/yellow
	//not the disgusting glowshroom yellow hopefully
	name = "Yellow Bioluminescence"
	glow_color = "#FFFF66"

/datum/plant_gene/trait/glow/green
	//oh no, now i'm radioactive
	name = "Green Bioluminescence"
	glow_color = "#99FF99"

/datum/plant_gene/trait/glow/blue
	//the best one
	name = "Blue Bioluminescence"
	glow_color = "#6699FF"

/datum/plant_gene/trait/glow/purple
	//did you know that notepad++ doesnt think bioluminescence is a word
	name = "Purple Bioluminescence"
	glow_color = "#D966FF"

/datum/plant_gene/trait/glow/pink
	//gay tide station pride
	name = "Pink Bioluminescence"
	glow_color = "#FFB3DA"

//Change grow, harvest, and crafted food's color
//Made for mostly being fancy with stuff. Should be rare or hard to obtain, with the exception of strange seeds
/datum/plant_gene/trait/modified_color
	name = "Dilated Light (Negative)"
	var/color = list(-1,0,0,0, 0,-1,0,0, 0,0,-1,0, 0,0,0,1, 1,1,1,0)		//Negative Colors
	var/long_calculation = FALSE		//For advanced color matrices

/datum/plant_gene/trait/modified_color/on_new(obj/item/reagent_containers/food/snacks/grown/G, newloc)
	if(G.modified_colors)
		return
	for(var/datum/plant_gene/trait/I in G.seed.genes)	//Have ones first added give priority
		if(istype(I, /datum/plant_gene/trait/modified_color) && I.type != type)
			return
	if(long_calculation)
		calculate()
	G.color = color
	G.modified_colors = TRUE

//same as above but for the gene modder
/datum/plant_gene/trait/modified_color/apply_vars(obj/item/seeds/S)
	S.color = color
	S.modified_colors = TRUE

/datum/plant_gene/trait/modified_color/proc/calculate()
	return

/datum/plant_gene/trait/modified_color/opaque
	name = "Dilated Light (Flimsy)"
	color =  list(1,0,0,0, 0,1,0,0, 0,0,1,0, -0.3,-0.3,-0.3,0.7, 0,0,0,0)

/datum/plant_gene/trait/modified_color/monochrome
	name = "Dilated Light (Monochrome)"
	color = list(0.5,0.5,0.5,0, 0.5,0.5,0.5,0, 0.5,0.5,0.5,0, 0,0,0,1, 0,0,0,0)

/datum/plant_gene/trait/modified_color/monochrome/red
	name = "Dilated Light (Red)"
	color = list(0.8,0,0,0, 0.8,0.5,0.5,0, 0.8,0.5,0.5,0, 0,0,0,1, 0,0,0,0)

/datum/plant_gene/trait/modified_color/monochrome/green
	name = "Dilated Light (Green)"
	color = list(0.5,0.8,0.5,0, 0,0.8,0,0, 0.5,0.8,0.5,0, 0,0,0,1, 0,0,0,0)

/datum/plant_gene/trait/modified_color/monochrome/blue
	name = "Dilated Light (Blue)"
	color = list(0.5,0.5,0.8,0, 0.5,0.5,0.8,0, 0,0,0.8,0, 0,0,0,1, 0,0,0,0)

/*
/datum/plant_gene/trait/modified_color/monochrome/yellow
	name = "Dilated Light (Yellow)"
	color = list(0.8,0,0,0, 0,0.4,0,0, 0.8,0.4,0.5,0, 0,0,0,1, 0,0,0,0)

/datum/plant_gene/trait/modified_color/monochrome/green
	name = "Dilated Light (Green)"
	color = list(0.5,0.8,0.4,0, 0,0.8,0,0, 0,0,0.4,0, 0,0,0,1, 0,0,0,0)
*/

/datum/plant_gene/trait/modified_color/monochrome/dark/
	name = "Dilated Light (Dark)"
	color = list(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1, -0.3, -0.3, -0.3, 0)

/*
/datum/plant_gene/trait/modified_color/monochrome/dark/red		//for vyx
	name = "Dilated Light (Dark Red)"
	color = list(1,0,0,0, 0.5,0.5,0.5,0, 0.5,0.5,0.5,0, 0,0,0,1, 0,0,0,0)

/datum/plant_gene/trait/modified_color/monochrome/dark/green
	name = "Dilated Light (Dark Green)"
	color = list(0.5,0.5,0.5,0, 0,1,0,0, 0.5,0.5,0.5,0, 0,0,0,1, 0,0,0,0)

/datum/plant_gene/trait/modified_color/monochrome/dark/blue
	name = "Dilated Light (Dark Blue)"
	color = list(0.5,0.5,0.,0, 0.5,0.5,0.5,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)
*/

/datum/plant_gene/trait/modified_color/vibrant
	name = "Dilated Light (Strong)"
	color = list(2,-1,-1,0, -1,2,-1,0, -1,-1,2,0, 0,0,0,1, 0,0,0,0)	//Any higher starts to look like clown vomit

/datum/plant_gene/trait/modified_color/cyan
	name = "Dilated Light (Shift R)"
	color = list(
				0.25, 1,    0.5,   0,
				0.5,  0.25, 1,     0,
				1,    0.5,  0.25,  0,
				0,0,0,1,
				0,0,0,0)

/datum/plant_gene/trait/modified_color/magenta
	name = "Dilated Light (Shift L)"
	color = list(
				0.25, 0.5,  1,     0,
				1,    0.25, 0.5,   0,
				0.5,  1,    0.25,  0,
				0,0,0,1,
				0,0,0,0)

/datum/plant_gene/trait/modified_color/sunset
	name = "Dilated Light (Shift S)"
	color = list(
				1,     0.25,  0,   0,
				0.25,  1,     0,   0,
				0.25,  0.125, 0.35,0,
				0,0,0,1,
				0,0,0,0)

/datum/plant_gene/trait/modified_color/random
	name = "Dilated Light (Shift C)"
	color = list()
	long_calculation = TRUE


//Calculations
/*
/datum/plant_gene/trait/modified_color/shift_red/calculate()
	var/list/M = color
	M[5] += 0.5 * M[1]
	M[6] += 0.5 * M[2]
	M[7] += 0.5 * M[3]
	color = M

/datum/plant_gene/trait/modified_color/shift_green/calculate()
	var/list/M = color
	M[9] += 0.5 * M[5]
	M[10] += 0.5 * M[6]
	M[11] += 0.5 * M[7]
	color = M

/datum/plant_gene/trait/modified_color/shift_blue/calculate()
	var/list/M = color
	M[13] += 0.5 * M[9]
	M[14] += 0.5 * M[10]
	M[15] += 0.5 * M[11]
	color = M
*/

/datum/plant_gene/trait/modified_color/random/calculate()
	var/R = rand(0,255)  / 255
	var/G = rand(0,255)  / 255
	var/B = rand(0,255)  / 255
	var/A = rand(200,255)/ 255

	if(prob(50))
		color = list(R,0,0,0,
					 0,G,0,0,
					 0,0,B,0,
					 0,0,0,1,
					 0,0,0,0)
	else
		color = list(R,0,0,0,
					 0,G,0,0,
					 0,0,B,0,
					 0,0,0,A,
					 0,0,0,0)
	var/D = rand(1,20)
	if(color[D] != 0)
		color[D] *= 1.5
	else
		color[D] = rand(-100, 100) * 0.01

/datum/plant_gene/trait/teleport
	// Makes plant teleport people when squashed or slipped on.
	// Teleport radius is calculated as max(round(potency*rate), 1)
	name = "Bluespace Activity"
	rate = 0.1

/datum/plant_gene/trait/teleport/on_squash(obj/item/reagent_containers/food/snacks/grown/G, atom/target)
	if(isliving(target))
		var/teleport_radius = max(round(G.seed.potency / 10), 1)
		var/turf/T = get_turf(target)
		new /obj/effect/decal/cleanable/molten_object(T) //Leave a pile of goo behind for dramatic effect...
		do_teleport(target, T, teleport_radius, channel = TELEPORT_CHANNEL_BLUESPACE)

/datum/plant_gene/trait/teleport/on_slip(obj/item/reagent_containers/food/snacks/grown/G, mob/living/carbon/C)
	var/teleport_radius = max(round(G.seed.potency / 10), 1)
	var/turf/T = get_turf(C)
	to_chat(C, "<span class='warning'>You slip through spacetime!</span>")
	do_teleport(C, T, teleport_radius, channel = TELEPORT_CHANNEL_BLUESPACE)
	if(prob(50))
		do_teleport(G, T, teleport_radius, channel = TELEPORT_CHANNEL_BLUESPACE)
	else
		new /obj/effect/decal/cleanable/molten_object(T) //Leave a pile of goo behind for dramatic effect...
		qdel(G)


/datum/plant_gene/trait/noreact
	// Makes plant reagents not react until squashed.
	name = "Separated Chemicals"

/datum/plant_gene/trait/noreact/on_new(obj/item/reagent_containers/food/snacks/grown/G, newloc)
	..()
	ENABLE_BITFIELD(G.reagents.reagents_holder_flags, NO_REACT)

/datum/plant_gene/trait/noreact/on_squash(obj/item/reagent_containers/food/snacks/grown/G, atom/target)
	DISABLE_BITFIELD(G.reagents.reagents_holder_flags, NO_REACT)
	G.reagents.handle_reactions()


/datum/plant_gene/trait/maxchem
	// 2x to max reagents volume.
	name = "Densified Chemicals"
	rate = 2

/datum/plant_gene/trait/maxchem/on_new(obj/item/reagent_containers/food/snacks/grown/G, newloc)
	..()
	G.reagents.maximum_volume *= rate

/datum/plant_gene/trait/repeated_harvest
	name = "Perennial Growth"

/datum/plant_gene/trait/repeated_harvest/can_add(obj/item/seeds/S)
	if(!..())
		return FALSE
	if(istype(S, /obj/item/seeds/replicapod))
		return FALSE
	return TRUE

/datum/plant_gene/trait/battery
	name = "Capacitive Cell Production"

/datum/plant_gene/trait/battery/on_attackby(obj/item/reagent_containers/food/snacks/grown/G, obj/item/I, mob/user)
	if(istype(I, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/C = I
		if(C.use(5))
			to_chat(user, "<span class='notice'>You add some cable to [G] and slide it inside the battery encasing.</span>")
			var/obj/item/stock_parts/cell/potato/pocell = new /obj/item/stock_parts/cell/potato(user.loc)
			pocell.icon_state = G.icon_state
			pocell.maxcharge = G.seed.potency * 20

			// The secret of potato supercells!
			var/datum/plant_gene/trait/cell_charge/CG = G.seed.get_gene(/datum/plant_gene/trait/cell_charge)
			if(CG) // Cell charge max is now 40MJ or otherwise known as 400KJ (Same as bluespace powercells)
				pocell.maxcharge *= CG.rate*100
			pocell.charge = pocell.maxcharge
			pocell.name = "[G.name] battery"
			pocell.desc = "A rechargeable plant-based power cell. This one has a rating of [DisplayEnergy(pocell.maxcharge)], and you should not swallow it."

			if(G.reagents.has_reagent(/datum/reagent/toxin/plasma, 2))
				pocell.rigged = TRUE

			qdel(G)
		else
			to_chat(user, "<span class='warning'>You need five lengths of cable to make a [G] battery!</span>")


/datum/plant_gene/trait/stinging
	name = "Hypodermic Prickles"

/datum/plant_gene/trait/stinging/on_throw_impact(obj/item/reagent_containers/food/snacks/grown/G, atom/target)
	if(isliving(target) && G.reagents && G.reagents.total_volume)
		var/mob/living/L = target
		if(L.reagents && L.can_inject(null, 0))
			var/injecting_amount = max(1, G.seed.potency*0.2) // Minimum of 1, max of 20
			var/fraction = min(injecting_amount/G.reagents.total_volume, 1)
			G.reagents.reaction(L, INJECT, fraction)
			G.reagents.trans_to(L, injecting_amount)
			to_chat(target, "<span class='danger'>You are pricked by [G]!</span>")

/datum/plant_gene/trait/smoke
	name = "gaseous decomposition"

/datum/plant_gene/trait/smoke/on_squash(obj/item/reagent_containers/food/snacks/grown/G, atom/target)
	var/datum/effect_system/smoke_spread/chem/S = new
	var/splat_location = get_turf(target)
	var/smoke_amount = round(sqrt(G.seed.potency * 0.1), 1)
	S.attach(splat_location)
	S.set_up(G.reagents, smoke_amount, splat_location, 0)
	S.start()
	G.reagents.clear_reagents()

/datum/plant_gene/trait/fire_resistance // Lavaland
	name = "Fire Resistance"

/datum/plant_gene/trait/fire_resistance/apply_vars(obj/item/seeds/S)
	if(!(S.resistance_flags & FIRE_PROOF))
		S.resistance_flags |= FIRE_PROOF

/datum/plant_gene/trait/fire_resistance/on_new(obj/item/reagent_containers/food/snacks/grown/G, newloc)
	if(!(G.resistance_flags & FIRE_PROOF))
		G.resistance_flags |= FIRE_PROOF

///Invasive spreading lets the plant jump to other trays, the spreadinhg plant won't replace plants of the same type.
/datum/plant_gene/trait/invasive
	name = "Invasive Spreading"

/datum/plant_gene/trait/invasive/on_grow(obj/machinery/hydroponics/H)
	for(var/step_dir in GLOB.alldirs)
		var/obj/machinery/hydroponics/HY = locate() in get_step(H, step_dir)
		if(HY && prob(15))
			if(HY.myseed) // check if there is something in the tray.
				if(HY.myseed.type == H.myseed.type && HY.dead != 0)
					continue //It should not destroy its owm kind.
				qdel(HY.myseed)
				HY.myseed = null
			HY.myseed = H.myseed.Copy()
			HY.age = 0
			HY.dead = 0
			HY.plant_health = HY.myseed.endurance
			HY.lastcycle = world.time
			HY.harvest = 0
			HY.weedlevel = 0 // Reset
			HY.pestlevel = 0 // Reset
			HY.update_icon()
			HY.visible_message("<span class='warning'>The [H.myseed.plantname] spreads!</span>")

/datum/plant_gene/trait/plant_type // Parent type
	name = "you shouldn't see this"
	trait_id = "plant_type"

/datum/plant_gene/trait/plant_type/weed_hardy
	name = "Weed Adaptation"

/datum/plant_gene/trait/plant_type/fungal_metabolism
	name = "Fungal Vitality"

/datum/plant_gene/trait/plant_type/alien_properties
	name ="?????"

/datum/plant_gene/trait/plant_type/carnivory
	name = "Obligate Carnivory"
