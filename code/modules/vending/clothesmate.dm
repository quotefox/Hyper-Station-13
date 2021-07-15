//DON'T FORGET TO CHANGE THE REFILL SIZE IF YOU CHANGE THE MACHINE'S CONTENTS!
/obj/machinery/vending/clothing
	name = "ClothesMate" //renamed to make the slogan rhyme
	desc = "A vending machine for clothing."
	icon_state = "clothes"
	icon_deny = "clothes-deny"
	product_slogans = "Dress for success!;Prepare to look swagalicious!;Look at all this free swag!;Why leave style up to fate? Use the ClothesMate!"
	vend_reply = "Thank you for using the ClothesMate!"
	products = list(/obj/item/clothing/head/that = 4,
		            /obj/item/clothing/head/fedora = 3,
		            /obj/item/clothing/glasses/monocle = 3,
		            /obj/item/clothing/suit/jacket = 4,
					/obj/item/clothing/suit/jacket/flannel = 4,
					/obj/item/clothing/suit/jacket/flannel/red = 4,
					/obj/item/clothing/suit/jacket/flannel/aqua = 4,
					/obj/item/clothing/suit/jacket/flannel/brown = 4,
		            /obj/item/clothing/suit/jacket/puffer/vest = 4,
		            /obj/item/clothing/suit/jacket/puffer = 4,
		            /obj/item/clothing/under/suit_jacket/navy = 3,
		            /obj/item/clothing/under/suit_jacket/really_black = 3,
		            /obj/item/clothing/under/suit_jacket/burgundy = 3,
		            /obj/item/clothing/under/suit_jacket/charcoal = 3,
		            /obj/item/clothing/under/suit_jacket/white = 3,
		            /obj/item/clothing/under/kilt = 3,
		            /obj/item/clothing/under/overalls = 3,
		            /obj/item/clothing/under/sl_suit = 3,
		            /obj/item/clothing/under/pants/jeans = 5,
		            /obj/item/clothing/under/pants/classicjeans = 5,
		            /obj/item/clothing/under/pants/camo = 3,
		            /obj/item/clothing/under/pants/blackjeans = 5,
		            /obj/item/clothing/under/pants/khaki = 5,
		            /obj/item/clothing/under/pants/white = 5,
		            /obj/item/clothing/under/pants/red = 3,
		            /obj/item/clothing/under/pants/black = 4,
		            /obj/item/clothing/under/pants/tan = 4,
		            /obj/item/clothing/under/pants/track = 3,
		            /obj/item/clothing/suit/jacket/miljacket = 5,
					/obj/item/clothing/under/scratch/skirt = 2,
		            /obj/item/clothing/under/gimmick/rank/captain/suit/skirt = 2,
		            /obj/item/clothing/under/gimmick/rank/head_of_personnel/suit/skirt = 2,
		            /obj/item/clothing/neck/tie/blue = 3,
		            /obj/item/clothing/neck/tie/red = 3,
		            /obj/item/clothing/neck/tie/black = 3,
		            /obj/item/clothing/neck/tie/horrible = 5,
		            /obj/item/clothing/neck/scarf/pink = 3,
		            /obj/item/clothing/neck/scarf/red = 3,
		            /obj/item/clothing/neck/scarf/green = 3,
		            /obj/item/clothing/neck/scarf/darkblue = 3,
		            /obj/item/clothing/neck/scarf/purple = 3,
		            /obj/item/clothing/neck/scarf/yellow = 3,
		            /obj/item/clothing/neck/scarf/orange = 3,
		            /obj/item/clothing/neck/scarf/cyan = 3,
		            /obj/item/clothing/neck/scarf = 3,
		            /obj/item/clothing/neck/scarf/black = 3,
		            /obj/item/clothing/neck/scarf/zebra = 3,
		            /obj/item/clothing/neck/scarf/christmas = 3,
		            /obj/item/clothing/neck/stripedredscarf = 3,
		            /obj/item/clothing/neck/stripedbluescarf = 3,
		            /obj/item/clothing/neck/stripedgreenscarf = 3,
		            /obj/item/clothing/accessory/waistcoat = 2,
		            /obj/item/clothing/under/skirt/black = 3,
		            /obj/item/clothing/under/skirt/blue = 3,
		            /obj/item/clothing/under/skirt/red = 3,
		            /obj/item/clothing/under/skirt/purple = 3,
		            /obj/item/clothing/under/sundress = 4,
		            /obj/item/clothing/under/stripeddress = 3,
		            /obj/item/clothing/under/sailordress = 3,
		            /obj/item/clothing/under/redeveninggown = 3,
		            /obj/item/clothing/under/blacktango = 3,
		            /obj/item/clothing/under/plaid_skirt = 3,
		            /obj/item/clothing/under/plaid_skirt/blue = 3,
		            /obj/item/clothing/under/plaid_skirt/purple = 3,
		            /obj/item/clothing/under/plaid_skirt/green = 3,
		            /obj/item/clothing/glasses/regular = 2,
		            /obj/item/clothing/glasses/regular/jamjar = 2,
		            /obj/item/clothing/head/sombrero = 3,
		            /obj/item/clothing/suit/poncho = 3,
		            /obj/item/clothing/suit/ianshirt = 3,
		            /obj/item/clothing/shoes/laceup = 5,
		            /obj/item/clothing/shoes/sneakers/black = 6,
		            /obj/item/clothing/shoes/sandal = 3,
		            /obj/item/clothing/gloves/fingerless = 3,
		            /obj/item/clothing/glasses/orange = 5,
		            /obj/item/clothing/glasses/red = 5,
		            /obj/item/storage/belt/fannypack = 3,
		            /obj/item/storage/belt/fannypack/blue = 3,
		            /obj/item/storage/belt/fannypack/red = 3,
		            /obj/item/clothing/suit/jacket/letterman = 5,
		            /obj/item/clothing/head/beanie = 3,
		            /obj/item/clothing/head/beanie/black = 3,
		            /obj/item/clothing/head/beanie/red = 3,
		            /obj/item/clothing/head/beanie/green = 3,
		            /obj/item/clothing/head/beanie/darkblue = 3,
		            /obj/item/clothing/head/beanie/purple = 3,
		            /obj/item/clothing/head/beanie/yellow = 3,
		            /obj/item/clothing/head/beanie/orange = 3,
		            /obj/item/clothing/head/beanie/cyan = 3,
		            /obj/item/clothing/head/beanie/christmas = 3,
		            /obj/item/clothing/head/beanie/striped = 3,
		            /obj/item/clothing/head/beanie/stripedred = 3,
		            /obj/item/clothing/head/beanie/stripedblue = 3,
		            /obj/item/clothing/head/beanie/stripedgreen = 3,
		            /obj/item/clothing/suit/toggle/jacket_yellow = 3,
		            /obj/item/clothing/suit/toggle/jacket_orange = 3,
		            /obj/item/clothing/suit/toggle/jacket_red = 3,
		            /obj/item/clothing/suit/toggle/jacket_purple = 3,
		            /obj/item/clothing/suit/toggle/jacket_white = 3,
		            /obj/item/clothing/suit/jacket/letterman_red = 3,
		            /obj/item/clothing/suit/fluffyhalfcrop = 3,
		            /obj/item/clothing/ears/headphones = 10,
		            /obj/item/clothing/suit/apron/purple_bartender = 4,
		            /obj/item/clothing/under/rank/bartender/purple = 4,
		            /obj/item/clothing/under/rank/bartender/purple = 4,
					/obj/item/clothing/under/christmas/christmasmaler = 3,
					/obj/item/clothing/under/christmas/christmasmaleg = 3,
					/obj/item/clothing/under/christmas/christmasfemaler = 3,
					/obj/item/clothing/under/christmas/christmasfemaleg = 3,
					/obj/item/clothing/suit/hooded/wintercoat/christmascoatr = 3,
					/obj/item/clothing/suit/hooded/wintercoat/christmascoatg = 3,
					/obj/item/clothing/suit/hooded/wintercoat/christmascoatrg = 3,
					/obj/item/clothing/head/christmashat = 3,
					/obj/item/clothing/head/christmashatg = 3,
					/obj/item/clothing/shoes/winterboots/christmasbootsr = 3,
					/obj/item/clothing/shoes/winterboots/christmasbootsg = 3,
					/obj/item/clothing/shoes/winterboots/santaboots = 3,
					/obj/item/clothing/head/cowboyhat = 3,
					/obj/item/clothing/head/cowboyhat/black = 3,
					/obj/item/clothing/head/cowboyhat/white = 3,
					/obj/item/clothing/head/cowboyhat/pink = 3,
					/obj/item/clothing/shoes/cowboyboots = 3,
					/obj/item/clothing/shoes/cowboyboots/black = 3,
					/obj/item/clothing/under/polychromic/vsweater = 3)
	contraband = list(/obj/item/clothing/under/syndicate/tacticool = 3,
					  /obj/item/clothing/under/syndicate/tacticool/skirt = 3,
		              /obj/item/clothing/mask/balaclava = 3,
		              /obj/item/clothing/head/ushanka = 3,
					  /obj/item/clothing/suit/gcvest = 2,
					  /obj/item/clothing/suit/gcvest/alt = 2,
					  /obj/item/clothing/gloves/guncaster = 4,
		              /obj/item/clothing/under/soviet = 3,
		              /obj/item/storage/belt/fannypack/black = 3,
		              /obj/item/clothing/suit/jacket/letterman_syndie = 5,
		              /obj/item/clothing/under/jabroni = 2,
		              /obj/item/clothing/suit/vapeshirt = 2,
		              /obj/item/clothing/under/geisha = 4,
		              /obj/item/clothing/under/lawyer/galaxy_red = 3)
	premium = list(/obj/item/clothing/under/suit_jacket/checkered = 4,
		           /obj/item/clothing/head/mailman = 2,
		           /obj/item/clothing/under/rank/mailman = 2,
		           /obj/item/clothing/suit/jacket/leather = 4,
		           /obj/item/clothing/suit/jacket/leather/overcoat = 4,
		           /obj/item/clothing/under/pants/mustangjeans = 3,
		           /obj/item/clothing/neck/necklace/dope = 5,
		           /obj/item/clothing/suit/jacket/letterman_nanotrasen = 5,
				   /obj/item/bluespace_thread = 3,
				   /obj/item/clothing/under/lawyer/galaxy_blue = 3)
	refill_canister = /obj/item/vending_refill/clothing
	baseprice = 2

/obj/item/vending_refill/clothing
	machine_name = "ClothesMate"
	icon_state = "refill_clothes"
