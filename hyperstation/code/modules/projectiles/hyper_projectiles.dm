/obj/item/projectile/weave
    name = "coder skill issue"
    //damage_type = WEAVE
    armour_penetration = 30
    //flag = "weave"

//obj/item/projectile/weave/shatter lambent thing later

/obj/item/projectile/crystal_slash
    name = "sharpened crystals"
    desc = "A quickly-formed lattice crystal, sharp as a blade."
    icon_state = "ice_2" //Make a sprite for this
    flag = "bullet" //Set to weave later
    armour_penetration = 30
    damage_type = BRUTE
    damage = 30
    alpha = 0
    spread = 20

/obj/item/projectile/crystal_slash/Initialize()
	. = ..()
	hitsound = "hyperstation/sound/weapons/rapier[pick(1,2)].ogg"
	animate(src, alpha = 255, time = 5)
