/obj/machinery/vending/security
	name = "\improper SecTech"
	desc = "A security equipment vendor."
	product_ads = "Crack capitalist skulls!;Beat some heads in!;Don't forget - harm is good!;Your weapons are right here.;Handcuffs!;Freeze, scumbag!;Don't tase me bro!;Tase them, bro.;Why not have a donut?"
	icon_state = "sec"
	icon_deny = "sec-deny"
	req_access = list(ACCESS_SECURITY)
	products = list(/obj/item/restraints/handcuffs = 8,
		            /obj/item/restraints/handcuffs/cable/zipties = 10,
		            /obj/item/grenade/flashbang = 4,
		            /obj/item/assembly/flash/handheld = 5,
					/obj/item/reagent_containers/food/snacks/donut = 12,
					/obj/item/storage/box/evidence = 6,
				    /obj/item/flashlight/seclite = 4,
				    /obj/item/restraints/legcuffs/bola/energy = 7,
					/obj/item/secbat = 5)
	contraband = list(/obj/item/clothing/glasses/sunglasses = 2,
		              /obj/item/storage/fancy/donut_box = 2,
		              /obj/item/ssword_kit = 1,
					  /obj/item/clothing/suit/armor/vest/stripper = 5,
					  /obj/item/clothing/suit/armor/vest/stripper/bikini = 5,
					  /obj/item/clothing/neck/petcollar/locked/security = 5,
					  /obj/item/electropack/shockcollar/security = 5,
					  /obj/item/storage/belt/slut = 5,
					  /obj/item/clothing/mask/gas/sechailer/slut = 5,
					  /obj/item/bdsm_whip/ridingcrop = 3,
					  /obj/item/grenade/secbed = 3,
					  /obj/item/dildo/flared/gigantic = 1,
					  /obj/item/dildo/flared/gigantic/tacticool = 1)
	premium = list(/obj/item/coin/antagtoken = 1,
					/obj/item/clothing/head/helmet/blueshirt = 1,
					/obj/item/clothing/suit/armor/vest/blueshirt = 1,
					/obj/item/clothing/under/rank/security/blueshirt = 1,
					/obj/item/ssword_kit = 1)
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF

/obj/machinery/vending/security/pre_throw(obj/item/I)
	if(istype(I, /obj/item/grenade))
		var/obj/item/grenade/G = I
		G.preprime()
	else if(istype(I, /obj/item/flashlight))
		var/obj/item/flashlight/F = I
		F.on = TRUE
		F.update_brightness()
