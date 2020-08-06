/obj/item/integrated_circuit/input/gmeasurement
	name = "body measurement"
	desc = "Used to get a measurement of a refs genitals size and body size."
	icon_state = "medscan"
	complexity = 5
	extended_desc = "Upon activation, the circuit will attempt to measure all body parts on the refs body within one tile away."
	inputs = list("target" = IC_PINTYPE_REF)
	outputs = list(
		"penis length" = IC_PINTYPE_NUMBER,
		"breast size" = IC_PINTYPE_NUMBER,
		"testicle size" = IC_PINTYPE_NUMBER,
		"body size" = IC_PINTYPE_NUMBER
		)
	activators = list("scan" = IC_PINTYPE_PULSE_IN, "on scanned" = IC_PINTYPE_PULSE_OUT)
	spawn_flags = IC_SPAWN_RESEARCH
	power_draw_per_use = 40
	cooldown_per_use = 20
	ext_cooldown = 25

/obj/item/integrated_circuit/input/gmeasurement/do_work()

	var/mob/living/L = get_pin_data_as_type(IC_INPUT, 1, /mob/living)

	if(!istype(L) || !L.Adjacent(get_turf(src)) ) //Invalid input
		return

	var/obj/item/organ/genital/penis/P = L.getorganslot("penis")
	var/obj/item/organ/genital/breasts/B = L.getorganslot("breasts")
	var/obj/item/organ/genital/testicles/T = L.getorganslot("testicles")

//reset data, just incase they dont have that genitle
	set_pin_data(IC_OUTPUT,	1, 0)
	set_pin_data(IC_OUTPUT,	2, 0)
	set_pin_data(IC_OUTPUT,	3, 0)
	set_pin_data(IC_OUTPUT,	4, 0)

//get sizes
	set_pin_data(IC_OUTPUT,	1, P.length)
	set_pin_data(IC_OUTPUT,	2, B.cached_size)
	set_pin_data(IC_OUTPUT,	3, T.cached_size )
	set_pin_data(IC_OUTPUT,	4, L.size_multiplier*100)
	push_data()
	activate_pin(2)

/obj/item/integrated_circuit/input/pregtest
	name = "pregnancy tester"
	desc = "A circuit used to determine whether someone is pregnant or not and if they possess the ability to be impregnated."
	icon_state = "medscan"
	complexity = 5
	inputs = list("target" = IC_PINTYPE_REF)
	outputs = list(
		"is pregnant" = IC_PINTYPE_BOOLEAN,
		"breedable" = IC_PINTYPE_BOOLEAN
		)
	activators = list("scan" = IC_PINTYPE_PULSE_IN, "on scanned" = IC_PINTYPE_PULSE_OUT)
	spawn_flags = IC_SPAWN_RESEARCH
	power_draw_per_use = 40
	cooldown_per_use = 20
	ext_cooldown = 25

/obj/item/integrated_circuit/input/pregtest/do_work()

	var/mob/living/L = get_pin_data_as_type(IC_INPUT, 1, /mob/living)

	if(!istype(L) || !L.Adjacent(get_turf(src)) ) //Invalid input
		return

	var/obj/item/organ/genital/womb/W = L.getorganslot("womb")


	set_pin_data(IC_OUTPUT,	1, null)
	set_pin_data(IC_OUTPUT,	2, null)
	set_pin_data(IC_OUTPUT,	1, W.pregnant)
	set_pin_data(IC_OUTPUT,	2, L.breedable)
	push_data()
	activate_pin(2)
