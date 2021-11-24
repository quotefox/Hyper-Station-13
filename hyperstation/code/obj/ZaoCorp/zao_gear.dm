/obj/item/storage/secure/briefcase/zao/standard
	name = "\improper ZaoCorp Gear Kit"
	desc = "A storage case for a complete ZaoCorp uniform. Giant sword included!"

/obj/item/storage/secure/briefcase/zao/standard/PopulateContents()
	new /obj/item/clothing/suit/toggle/zao(src)
	new /obj/item/clothing/under/rank/security/zao(src)
	new /obj/item/clothing/head/zao(src)
	new /obj/item/clothing/glasses/hud/toggle/zao(src)
	new /obj/item/clothing/shoes/jackboots(src)
	new /obj/item/clothing/gloves/color/black(src)
	new /obj/item/clothing/accessory/waistcoat(src)
	new /obj/item/twohanded/required/zao/zweihander(src)

/obj/item/choice_beacon/zao
	name = "ZaoCorp supply beacon"
	desc = "Use this to summon a ZaoCorp Kit!"

/obj/item/choice_beacon/zao/generate_display_names()
	var/static/list/zao_list
	if(!zao_list)
		zao_list = list()
		var/list/templist = subtypesof(/obj/item/storage/secure/briefcase/zao/) //we have to convert type = name to name = type, how lovely!
		for(var/V in templist)
			var/atom/A = V
			zao_list[initial(A.name)] = A
	return zao_list