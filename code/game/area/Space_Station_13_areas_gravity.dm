//deadass i'm sure there's a better way to do this but i dont wanna go have issues with areas acting up and i'm lazy. could probably just force gravity in the future on previous areas
//like i'm sure i can just do area/gravity and attach the flag there but like... that would require me fiddling around with the fact that some areas will shit themselves
//so for now i dig myself my own grave to lay in later. if something better comes along just fuckin delete this shitcode

//Maintenance

/area/maintenance
	ambientsounds = MAINTENANCE
	valid_territory = FALSE


//Departments

/area/maintenance/department/chapel/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/department/chapel/monastery/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/department/crew_quarters/bar/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/department/crew_quarters/dorms/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/department/crew_quarters/locker/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/department/eva/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/department/electrical/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/department/engine/atmos/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/department/security/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/department/security/brig/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/department/medical/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/department/medical/morgue/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/department/science/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/department/cargo/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/department/bridge/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/department/engine/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/department/science/xenobiology/gravity
	has_gravity = STANDARD_GRAVITY


//Maintenance - Generic

/area/maintenance/arrivals/north/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/arrivals/north_2/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/aft/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/aft/secondary/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/central/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/central/secondary/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/fore/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/fore/secondary/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/starboard/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/starboard/central/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/starboard/aft/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/starboard/fore/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/port/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/port/central/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/port/aft/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/port/fore/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/disposal/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/disposal/incinerator/gravity
	has_gravity = STANDARD_GRAVITY


//Hallway

/area/hallway/primary/aft/gravity
	has_gravity = STANDARD_GRAVITY

/area/hallway/primary/fore/gravity
	has_gravity = STANDARD_GRAVITY

/area/hallway/primary/starboard/gravity
	has_gravity = STANDARD_GRAVITY

/area/hallway/primary/starboard/aft/gravity
	has_gravity = STANDARD_GRAVITY

/area/hallway/primary/starboard/fore/gravity
	has_gravity = STANDARD_GRAVITY

/area/hallway/primary/port/gravity
	has_gravity = STANDARD_GRAVITY

/area/hallway/primary/port/aft/gravity
	has_gravity = STANDARD_GRAVITY

/area/hallway/primary/port/fore/gravity
	has_gravity = STANDARD_GRAVITY

/area/hallway/primary/central/gravity
	has_gravity = STANDARD_GRAVITY

/area/hallway/secondary/command/gravity
	has_gravity = STANDARD_GRAVITY

/area/hallway/secondary/construction/gravity
	has_gravity = STANDARD_GRAVITY

/area/hallway/secondary/exit/gravity
	has_gravity = STANDARD_GRAVITY

/area/hallway/secondary/exit/departure_lounge/gravity
	has_gravity = STANDARD_GRAVITY

/area/hallway/secondary/entry/gravity
	has_gravity = STANDARD_GRAVITY

/area/hallway/secondary/service/gravity
	has_gravity = STANDARD_GRAVITY

//Command

/area/bridge/gravity
	has_gravity = STANDARD_GRAVITY

/area/bridge/meeting_room/gravity
	has_gravity = STANDARD_GRAVITY

/area/bridge/meeting_room/council/gravity
	has_gravity = STANDARD_GRAVITY

/area/bridge/showroom/corporate/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/heads/captain/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/heads/captain/private/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/heads/chief/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/heads/chief/private/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/heads/cmo/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/heads/cmo/private/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/heads/hop/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/heads/hop/private/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/heads/hos/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/heads/hos/private/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/heads/hor/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/heads/hor/private/gravity
	has_gravity = STANDARD_GRAVITY

/area/comms/gravity
	has_gravity = STANDARD_GRAVITY

/area/server/gravity
	has_gravity = STANDARD_GRAVITY

//Crew

/area/crew_quarters/dorms/gravity
	has_gravity = STANDARD_GRAVITY
/*
/area/crew_quarters/dorms/male

/area/crew_quarters/dorms/female

*/ // the fuck is the point of gender dorms? the fuck?
/area/crew_quarters/rehab_dome/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/toilet/gravity //weightful shits
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/toilet/auxiliary/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/toilet/locker/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/toilet/fitness/gravity
	has_gravity = STANDARD_GRAVITY
/*
/area/crew_quarters/toilet/female
	name = "Female Toilets"
	icon_state = "toilet"

/area/crew_quarters/toilet/male
	name = "Male Toilets"
	icon_state = "toilet"
*/ // dont think these will be used on hyper

/area/crew_quarters/toilet/restrooms/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/locker/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/lounge/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/fitness/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/fitness/recreation/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/cafeteria/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/cafeteria/lunchroom/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/kitchen/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/kitchen/backroom/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/bar/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/bar/atrium/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/electronic_marketing_den/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/abandoned_gambling_den/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/abandoned_gambling_den/secondary/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/theatre/gravity
	has_gravity = STANDARD_GRAVITY

/area/crew_quarters/theatre/abandoned/gravity
	has_gravity = STANDARD_GRAVITY

/area/library/gravity //may you find your book in this place
	has_gravity = STANDARD_GRAVITY

/area/library/lounge/gravity
	has_gravity = STANDARD_GRAVITY

/area/library/abandoned/gravity
	has_gravity = STANDARD_GRAVITY

/area/chapel/gravity
	has_gravity = STANDARD_GRAVITY

/area/chapel/main/gravity
	has_gravity = STANDARD_GRAVITY

/area/chapel/main/monastery/gravity
	has_gravity = STANDARD_GRAVITY

/area/chapel/office/gravity
	has_gravity = STANDARD_GRAVITY

/area/chapel/asteroid/gravity
	has_gravity = STANDARD_GRAVITY

/area/chapel/asteroid/monastery/gravity
	has_gravity = STANDARD_GRAVITY

/area/chapel/dock/gravity
	has_gravity = STANDARD_GRAVITY

/area/lawoffice/gravity
	has_gravity = STANDARD_GRAVITY

/area/arcade
	icon_state = "xenogen"
	has_gravity = STANDARD_GRAVITY


//Engineering

/area/engine/gravity
	has_gravity = STANDARD_GRAVITY

/area/engine/engine_smes/gravity
	has_gravity = STANDARD_GRAVITY

/area/engine/engineering/gravity
	has_gravity = STANDARD_GRAVITY

/area/engine/atmos/gravity
	has_gravity = STANDARD_GRAVITY

/area/engine/atmospherics_engine/gravity
	has_gravity = STANDARD_GRAVITY

/area/engine/supermatter/gravity
	has_gravity = STANDARD_GRAVITY

/area/engine/break_room/gravity
	has_gravity = STANDARD_GRAVITY

/area/engine/gravity_generator/gravity
	has_gravity = STANDARD_GRAVITY

/area/engine/secure_construction/gravity
	has_gravity = STANDARD_GRAVITY

/area/engine/storage/gravity
	has_gravity = STANDARD_GRAVITY

/area/engine/storage_shared/gravity
	has_gravity = STANDARD_GRAVITY

/area/engine/transit_tube/gravity
	has_gravity = STANDARD_GRAVITY


//Solars

/area/solar/gravity
	has_gravity = STANDARD_GRAVITY
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED

/area/solar/fore/gravity
	has_gravity = STANDARD_GRAVITY
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED

/area/solar/aft/gravity
	has_gravity = STANDARD_GRAVITY
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED

/area/solar/aux/port/gravity
	has_gravity = STANDARD_GRAVITY
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED

/area/solar/aux/starboard/gravity
	has_gravity = STANDARD_GRAVITY
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED

/area/solar/starboard/gravity
	has_gravity = STANDARD_GRAVITY
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED

/area/solar/starboard/aft/gravity
	has_gravity = STANDARD_GRAVITY
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED

/area/solar/starboard/fore/gravity
	has_gravity = STANDARD_GRAVITY
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED

/area/solar/port/gravity
	has_gravity = STANDARD_GRAVITY
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED

/area/solar/port/aft/gravity
	has_gravity = STANDARD_GRAVITY
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED

/area/solar/port/fore/gravity
	has_gravity = STANDARD_GRAVITY
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED


//Solar Maint

/area/maintenance/solars/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/solars/port/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/solars/port/aft/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/solars/port/fore/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/solars/starboard/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/solars/starboard/aft/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/solars/starboard/fore/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/solars/aux/port/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/solars/aux/port/aft/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/solars/aux/port/fore/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/solars/aux/starboard/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/solars/aux/starboard/aft/gravity
	has_gravity = STANDARD_GRAVITY

/area/maintenance/solars/aux/starboard/fore/gravity
	has_gravity = STANDARD_GRAVITY

//Teleporter

/area/teleporter/gravity
	has_gravity = STANDARD_GRAVITY

/area/gateway/gravity
	has_gravity = STANDARD_GRAVITY

//MedBay

/area/medical/gravity
	has_gravity = STANDARD_GRAVITY

/area/medical/abandoned/gravity
	has_gravity = STANDARD_GRAVITY

/area/medical/medbay/central/gravity
	has_gravity = STANDARD_GRAVITY

/area/medical/medbay/front_office/gravity
	has_gravity = STANDARD_GRAVITY

/area/medical/medbay/lobby/gravity
	has_gravity = STANDARD_GRAVITY

	//Medbay is a large area, these additional areas help level out APC load.

/area/medical/medbay/zone2/gravity
	has_gravity = STANDARD_GRAVITY

/area/medical/medbay/zone3/gravity
	has_gravity = STANDARD_GRAVITY

/area/medical/medbay/aft/gravity
	has_gravity = STANDARD_GRAVITY

/area/medical/storage/gravity
	has_gravity = STANDARD_GRAVITY

/area/medical/patients_rooms/gravity
	has_gravity = STANDARD_GRAVITY

/area/medical/patients_rooms/room_a/gravity
	has_gravity = STANDARD_GRAVITY

/area/medical/patients_rooms/room_b/gravity
	has_gravity = STANDARD_GRAVITY

/area/medical/virology/gravity
	has_gravity = STANDARD_GRAVITY

/area/medical/morgue/gravity
	has_gravity = STANDARD_GRAVITY

/area/medical/chemistry/gravity
	has_gravity = STANDARD_GRAVITY

/area/medical/psych/gravity
	has_gravity = STANDARD_GRAVITY

/area/medical/surgery/gravity
	has_gravity = STANDARD_GRAVITY

/area/medical/cryo/gravity
	has_gravity = STANDARD_GRAVITY

/area/medical/exam_room/gravity
	has_gravity = STANDARD_GRAVITY

/area/medical/genetics/gravity
	has_gravity = STANDARD_GRAVITY

/area/medical/genetics/cloning/gravity
	has_gravity = STANDARD_GRAVITY

/area/medical/sleeper/gravity
	has_gravity = STANDARD_GRAVITY


//Security

/area/security/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/main/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/brig/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/courtroom/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/prison/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/processing/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/processing/cremation/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/warden/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/armory/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/detectives_office/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/detectives_office/private_investigators_office/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/range/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/execution/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/execution/transfer/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/execution/education/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/nuke_storage/gravity
	has_gravity = STANDARD_GRAVITY

/area/ai_monitored/nuke_storage/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/checkpoint/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/checkpoint/auxiliary/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/checkpoint/tertiary/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/checkpoint/escape/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/checkpoint/supply/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/checkpoint/engineering/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/checkpoint/medical/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/checkpoint/science/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/checkpoint/science/research/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/checkpoint/customs/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/checkpoint/customs/auxiliary/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/vacantoffice/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/vacantoffice/a/gravity
	has_gravity = STANDARD_GRAVITY

/area/security/vacantoffice/b/gravity
	has_gravity = STANDARD_GRAVITY

/area/quartermaster/gravity
	has_gravity = STANDARD_GRAVITY

///////////WORK IN PROGRESS//////////

/area/quartermaster/sorting/gravity
	has_gravity = STANDARD_GRAVITY

/area/quartermaster/warehouse/gravity
	has_gravity = STANDARD_GRAVITY

////////////WORK IN PROGRESS//////////

/area/quartermaster/office/gravity
	has_gravity = STANDARD_GRAVITY

/area/quartermaster/storage/gravity
	has_gravity = STANDARD_GRAVITY

/area/quartermaster/qm/gravity
	has_gravity = STANDARD_GRAVITY

/area/quartermaster/qm/private/gravity
	has_gravity = STANDARD_GRAVITY

/area/quartermaster/miningdock/gravity
	has_gravity = STANDARD_GRAVITY

/area/quartermaster/miningdock/abandoned/gravity
	has_gravity = STANDARD_GRAVITY

/area/quartermaster/miningoffice/gravity
	has_gravity = STANDARD_GRAVITY

/area/quartermaster/miningstorage/gravity
	has_gravity = STANDARD_GRAVITY

/area/janitor/gravity
	has_gravity = STANDARD_GRAVITY

/area/hydroponics/gravity
	has_gravity = STANDARD_GRAVITY

/area/hydroponics/garden/gravity
	has_gravity = STANDARD_GRAVITY

/area/hydroponics/garden/abandoned/gravity
	has_gravity = STANDARD_GRAVITY

/area/hydroponics/garden/monastery/gravity
	has_gravity = STANDARD_GRAVITY


//Science

/area/science/gravity
	has_gravity = STANDARD_GRAVITY

/area/science/lab/gravity
	has_gravity = STANDARD_GRAVITY

/area/science/xenobiology/gravity
	has_gravity = STANDARD_GRAVITY

/area/science/storage/gravity
	has_gravity = STANDARD_GRAVITY

/area/science/mineral_storeroom/gravity
	has_gravity = STANDARD_GRAVITY

/area/science/test_area/gravity
	has_gravity = STANDARD_GRAVITY

/area/science/mixing/gravity
	has_gravity = STANDARD_GRAVITY

/area/science/mixing/chamber/gravity
	has_gravity = STANDARD_GRAVITY

/area/science/misc_lab/gravity
	has_gravity = STANDARD_GRAVITY

/area/science/misc_lab/range/gravity
	has_gravity = STANDARD_GRAVITY

/area/science/server/gravity
	has_gravity = STANDARD_GRAVITY

/area/science/explab/gravity
	has_gravity = STANDARD_GRAVITY

/area/science/robotics/gravity
	has_gravity = STANDARD_GRAVITY

/area/science/robotics/mechbay/gravity
	has_gravity = STANDARD_GRAVITY

/area/science/robotics/mechbay_cargo/gravity
	has_gravity = STANDARD_GRAVITY

/area/science/robotics/showroom/gravity
	has_gravity = STANDARD_GRAVITY

/area/science/robotics/lab/gravity
	has_gravity = STANDARD_GRAVITY

/area/science/research/gravity
	has_gravity = STANDARD_GRAVITY

/area/science/circuit/gravity
	has_gravity = STANDARD_GRAVITY

/area/science/research/lobby/gravity
	has_gravity = STANDARD_GRAVITY

/area/science/research/abandoned/gravity
	has_gravity = STANDARD_GRAVITY

/area/science/nanite/gravity
	has_gravity = STANDARD_GRAVITY

//Storage

/area/storage/tools/gravity
	has_gravity = STANDARD_GRAVITY

/area/storage/primary/gravity
	has_gravity = STANDARD_GRAVITY

/area/storage/autolathe/gravity
	has_gravity = STANDARD_GRAVITY

/area/storage/art/gravity
	has_gravity = STANDARD_GRAVITY

/area/storage/auxiliary/gravity
	has_gravity = STANDARD_GRAVITY

/area/storage/atmos/gravity
	has_gravity = STANDARD_GRAVITY

/area/storage/tcom/gravity
	has_gravity = STANDARD_GRAVITY

/area/storage/eva/gravity
	has_gravity = STANDARD_GRAVITY

/area/storage/secure/gravity
	has_gravity = STANDARD_GRAVITY

/area/storage/emergency/starboard/gravity
	has_gravity = STANDARD_GRAVITY

/area/storage/emergency/port/gravity
	has_gravity = STANDARD_GRAVITY

/area/storage/tech/gravity
	has_gravity = STANDARD_GRAVITY

/area/storage/testroom/gravity
	has_gravity = STANDARD_GRAVITY


//Construction

/area/construction/gravity
	has_gravity = STANDARD_GRAVITY

/area/construction/minisat_exterior/gravity
	has_gravity = STANDARD_GRAVITY

/area/construction/mining/aux_base/gravity
	has_gravity = STANDARD_GRAVITY

/area/construction/mining/aux_base/closet/gravity
	has_gravity = STANDARD_GRAVITY

/area/construction/supplyshuttle/gravity
	has_gravity = STANDARD_GRAVITY

/area/construction/quarters/gravity
	has_gravity = STANDARD_GRAVITY

/area/construction/qmaint/gravity
	has_gravity = STANDARD_GRAVITY

/area/construction/hallway/gravity
	has_gravity = STANDARD_GRAVITY

/area/construction/solars/gravity
	has_gravity = STANDARD_GRAVITY

/area/construction/solarscontrol/gravity
	has_gravity = STANDARD_GRAVITY

/area/construction/storage/gravity
	has_gravity = STANDARD_GRAVITY

/area/construction/storage/wing/gravity
	has_gravity = STANDARD_GRAVITY


//AI

/area/ai_monitored/security/armory/gravity
	has_gravity = STANDARD_GRAVITY

/area/ai_monitored/storage/eva/gravity
	has_gravity = STANDARD_GRAVITY

/area/ai_monitored/storage/satellite/gravity
	has_gravity = STANDARD_GRAVITY

	//Turret_protected

/area/ai_monitored/turret_protected/gravity
	has_gravity = STANDARD_GRAVITY

/area/ai_monitored/turret_protected/ai_upload/gravity
	has_gravity = STANDARD_GRAVITY

/area/ai_monitored/turret_protected/ai_upload_foyer/gravity
	has_gravity = STANDARD_GRAVITY

/area/ai_monitored/turret_protected/ai/gravity
	has_gravity = STANDARD_GRAVITY

/area/ai_monitored/turret_protected/aisat/gravity
	has_gravity = STANDARD_GRAVITY

/area/ai_monitored/turret_protected/aisat/atmos/gravity
	has_gravity = STANDARD_GRAVITY

/area/ai_monitored/turret_protected/aisat/foyer/gravity
	has_gravity = STANDARD_GRAVITY

/area/ai_monitored/turret_protected/aisat/service/gravity
	has_gravity = STANDARD_GRAVITY

/area/ai_monitored/turret_protected/aisat/hallway/gravity
	has_gravity = STANDARD_GRAVITY

/area/aisat/gravity
	has_gravity = STANDARD_GRAVITY

/area/ai_monitored/turret_protected/aisat_interior/gravity
	has_gravity = STANDARD_GRAVITY

/area/ai_monitored/turret_protected/AIsatextFP/gravity
	has_gravity = STANDARD_GRAVITY

/area/ai_monitored/turret_protected/AIsatextFS/gravity
	has_gravity = STANDARD_GRAVITY

/area/ai_monitored/turret_protected/AIsatextAS/gravity
	has_gravity = STANDARD_GRAVITY

/area/ai_monitored/turret_protected/AIsatextAP/gravity
	has_gravity = STANDARD_GRAVITY


// Telecommunications Satellite

/area/tcommsat/gravity
	has_gravity = STANDARD_GRAVITY

/area/tcommsat/entrance/gravity
	has_gravity = STANDARD_GRAVITY

/area/tcommsat/chamber/gravity
	has_gravity = STANDARD_GRAVITY

/area/ai_monitored/turret_protected/tcomsat/gravity
	has_gravity = STANDARD_GRAVITY

/area/ai_monitored/turret_protected/tcomfoyer/gravity
	has_gravity = STANDARD_GRAVITY

/area/ai_monitored/turret_protected/tcomwest/gravity
	has_gravity = STANDARD_GRAVITY

/area/ai_monitored/turret_protected/tcomeast/gravity
	has_gravity = STANDARD_GRAVITY

/area/tcommsat/computer/gravity
	has_gravity = STANDARD_GRAVITY

/area/tcommsat/server/gravity
	has_gravity = STANDARD_GRAVITY

/area/tcommsat/lounge/gravity
	has_gravity = STANDARD_GRAVITY

//Pool
/area/crew_quarters/fitness/pool/gravity
	has_gravity = STANDARD_GRAVITY
