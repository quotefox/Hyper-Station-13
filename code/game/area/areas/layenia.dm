area/layenia
	name = "Layenia"
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY
	blob_allowed = FALSE
	requires_power = TRUE
	outdoors = TRUE
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	ambientsounds = MINING

area/layenia/cloudlayer
	name = "Laneya clouds"
	icon_state = "space"
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED

area/layenia/powered
	name = "Layenia Powered"
	icon_state = "centcom"
	requires_power = FALSE
	has_gravity = STANDARD_GRAVITY
	noteleport = FALSE
	blob_allowed = TRUE
	flags_1 = NONE
	outdoors = FALSE
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
