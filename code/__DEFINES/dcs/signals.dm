// All signals. Format:
// When the signal is called: (signal arguments)
// All signals send the source datum of the signal as the first argument

// global signals
// These are signals which can be listened to by any component on any parent
// start global signals with "!", this used to be necessary but now it's just a formatting choice

/// called after an explosion happened : (epicenter, devastation_range, heavy_impact_range, light_impact_range, took, orig_dev_range, orig_heavy_range, orig_light_range)
#define COMSIG_GLOB_EXPLOSION "!explosion"
/// mob was created somewhere : (mob)
#define COMSIG_GLOB_MOB_CREATED "!mob_created"
/// mob died somewhere : (mob , gibbed)
#define COMSIG_GLOB_MOB_DEATH "!mob_death"
/// called by datum/cinematic/play() : (datum/cinematic/new_cinematic)
#define COMSIG_GLOB_PLAY_CINEMATIC "!play_cinematic"
	#define COMPONENT_GLOB_BLOCK_CINEMATIC (1<<0)
/// ingame button pressed (/obj/machinery/button/button)
#define COMSIG_GLOB_BUTTON_PRESSED "!button_pressed"

/// signals from globally accessible objects

///from SSsun when the sun changes position : (azimuth)
#define COMSIG_SUN_MOVED "sun_moved"

//////////////////////////////////////////////////////////////////

// /datum signals
/// just before a datum's Destroy() is called: (force), at this point none of the other components chose to interrupt qdel and Destroy will be called
#define COMSIG_PARENT_QDELETING "parent_qdeleting"
/// generic topic handler (usr, href_list)
#define COMSIG_TOPIC "handle_topic"

/// fires on the target datum when an element is attached to it (/datum/element)
#define COMSIG_ELEMENT_ATTACH "element_attach"
/// fires on the target datum when an element is attached to it  (/datum/element)
#define COMSIG_ELEMENT_DETACH "element_detach"

// /atom signals
///from base of atom/proc/Initialize(): sent any time a new atom is created
#define COMSIG_ATOM_CREATED "atom_created"
//from SSatoms InitAtom - Only if the  atom was not deleted or failed initialization
#define COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZE "atom_init_success"
///from base of atom/animal_attack(): (/mob/user)
#define COMSIG_ATOM_ATTACK_ANIMAL "attack_animal"
///from base of atom/update_icon(): (signalOut, did_anything)
#define COMSIG_ATOM_UPDATED_ICON "atom_updated_icon"
///from base of atom/Bumped(): (/atom/movable)
#define COMSIG_ATOM_BUMPED "atom_bumped"
///from obj/machinery/bsa/full/proc/fire(): ()
#define COMSIG_ATOM_BSA_BEAM "atom_bsa_beam_pass"
	#define COMSIG_ATOM_BLOCKS_BSA_BEAM (1<<0)
///from base of atom/wrench_act(): (mob/living/user, obj/item/I)
#define COMSIG_ATOM_WRENCH_ACT "atom_wrench_act"
///from base of atom/multitool_act(): (mob/living/user, obj/item/I)
#define COMSIG_ATOM_MULTITOOL_ACT "atom_multitool_act"
///from base of atom/welder_act(): (mob/living/user, obj/item/I)
#define COMSIG_ATOM_WELDER_ACT "atom_welder_act"
///from base of atom/wirecutter_act(): (mob/living/user, obj/item/I)
#define COMSIG_ATOM_WIRECUTTER_ACT "atom_wirecutter_act"
///from base of atom/crowbar_act(): (mob/living/user, obj/item/I)
#define COMSIG_ATOM_CROWBAR_ACT "atom_crowbar_act"
///from base of atom/analyser_act(): (mob/living/user, obj/item/I)
#define COMSIG_ATOM_ANALYSER_ACT "atom_analyser_act"
	#define COMPONENT_BLOCK_TOOL_ATTACK (1<<0)
///called when an atom is added to the hearers on get_hearers_in_view(): (list/processing_list, list/hearers)
#define COMSIG_ATOM_HEARER_IN_VIEW "atom_hearer_in_view"
///called when an atom starts orbiting another atom: (atom)
#define COMSIG_ATOM_ORBIT_BEGIN "atom_orbit_begin"
///called when an atom stops orbiting another atom: (atom)
#define COMSIG_ATOM_ORBIT_STOP "atom_orbit_stop"
/////////////////
//This signal return value bitflags can be found in __DEFINES/misc.dm

///called for each movable in a turf contents on /turf/zImpact(): (atom/movable/A, levels)
#define COMSIG_ATOM_INTERCEPT_Z_FALL "movable_intercept_z_impact"
///called on a movable (NOT living) when someone starts pulling it (atom/movable/puller, state, force)
#define COMSIG_ATOM_START_PULL "movable_start_pull"
///called on /living when someone starts pulling it (atom/movable/puller, state, force)
#define COMSIG_LIVING_START_PULL "living_start_pull"

/////////////////

// /turf signals
///from base of turf/New(): (turf/source, direction)
#define COMSIG_TURF_MULTIZ_NEW "turf_multiz_new"

// /atom/movable signals

///from base of atom/movable/Moved(): (/atom)
#define COMSIG_MOVABLE_PRE_MOVE "movable_pre_move"
	#define COMPONENT_MOVABLE_BLOCK_PRE_MOVE (1<<0)
///called when the movable is placed in an unaccessible area, used for stationloving: ()
#define COMSIG_MOVABLE_SECLUDED_LOCATION "movable_secluded"

// /mob signals

///from base of /mob/Login(): ()
#define COMSIG_MOB_LOGIN "mob_login"
///from base of /mob/Logout(): ()
#define COMSIG_MOB_LOGOUT "mob_logout"
///from base of mob/set_stat(): (new_stat)
#define COMSIG_MOB_STATCHANGE "mob_statchange"
///from base of mob/clickon(): (atom/A, params)
#define COMSIG_MOB_CLICKON "mob_clickon"
///from base of mob/MiddleClickOn(): (atom/A)
#define COMSIG_MOB_MIDDLECLICKON "mob_middleclickon"
///from base of mob/AltClickOn(): (atom/A)
#define COMSIG_MOB_ALTCLICKON "mob_altclickon"
	#define COMSIG_MOB_CANCEL_CLICKON (1<<0)

///from base of /mob/living/proc/apply_damage(): (damage, damagetype, def_zone)
#define COMSIG_MOB_APPLY_DAMGE	"mob_apply_damage"
///from base of obj/item/attack_qdeleted(): (atom/target, mob/user, proxiumity_flag, click_parameters)
#define COMSIG_MOB_ITEM_ATTACK_QDELETED "mob_item_attack_qdeleted"
///from base of /mob/verb/examinate(): (atom/target)
#define COMSIG_MOB_EXAMINATE "mob_examinate"

///from /mob/say_dead(): (mob/speaker, message)
#define COMSIG_MOB_DEADSAY "mob_deadsay"
	#define MOB_DEADSAY_SIGNAL_INTERCEPT (1<<0)
///from /mob/living/emote(): ()
#define COMSIG_MOB_EMOTE "mob_emote"
///from base of mob/swap_hand(): (obj/item)
#define COMSIG_MOB_SWAP_HANDS "mob_swap_hands"
	#define COMPONENT_BLOCK_SWAP (1<<0)

// /mob/living signals

///sent when items with siemen coeff. of 0 block a shock: (power_source, source, siemens_coeff, dist_check)
#define COMSIG_LIVING_SHOCK_PREVENTED "living_shock_prevented"
///from base of mob/living/revive() (full_heal, admin_revive)
#define COMSIG_LIVING_REVIVE "living_revive"
///from base of /mob/living/regenerate_limbs(): (noheal, excluded_limbs)
#define COMSIG_LIVING_REGENERATE_LIMBS "living_regen_limbs"
///from base of /obj/item/bodypart/proc/attach_limb(): (new_limb, special) allows you to fail limb attachment
#define COMSIG_LIVING_ATTACH_LIMB "living_attach_limb"
	#define COMPONENT_NO_ATTACH (1<<0)
///sent from borg recharge stations: (amount, repairs)
#define COMSIG_PROCESS_BORGCHARGER_OCCUPANT "living_charge"
///sent when a mob/login() finishes: (client)
#define COMSIG_MOB_CLIENT_LOGIN "comsig_mob_client_login"

//ALL OF THESE DO NOT TAKE INTO ACCOUNT WHETHER AMOUNT IS 0 OR LOWER AND ARE SENT REGARDLESS!

///from base of mob/living/Stun() (amount, update, ignore)
#define COMSIG_LIVING_STATUS_STUN "living_stun"
///from base of mob/living/Knockdown() (amount, update, ignore)
#define COMSIG_LIVING_STATUS_KNOCKDOWN "living_knockdown"
///from base of mob/living/Paralyze() (amount, update, ignore)
#define COMSIG_LIVING_STATUS_PARALYZE "living_paralyze"
///from base of mob/living/Immobilize() (amount, update, ignore)
#define COMSIG_LIVING_STATUS_IMMOBILIZE "living_immobilize"
///from base of mob/living/Unconscious() (amount, update, ignore)
#define COMSIG_LIVING_STATUS_UNCONSCIOUS "living_unconscious"
///from base of mob/living/Sleeping() (amount, update, ignore)
#define COMSIG_LIVING_STATUS_SLEEP "living_sleeping"
	#define COMPONENT_NO_STUN (1<<0)									//For all of them
///from base of /mob/living/can_track(): (mob/user)
#define COMSIG_LIVING_CAN_TRACK "mob_cantrack"
	#define COMPONENT_CANT_TRACK (1<<0)

// /mob/living/carbon signals

///from /item/organ/proc/Insert() (/obj/item/organ/)
#define COMSIG_CARBON_GAIN_ORGAN "carbon_gain_organ"
///from /item/organ/proc/Remove() (/obj/item/organ/)
#define COMSIG_CARBON_LOSE_ORGAN "carbon_lose_organ"
///from /mob/living/carbon/doUnEquip(obj/item/I, force, newloc, no_move, invdrop, silent)
#define COMSIG_CARBON_EQUIP_HAT "carbon_equip_hat"
///from /mob/living/carbon/doUnEquip(obj/item/I, force, newloc, no_move, invdrop, silent)
#define COMSIG_CARBON_UNEQUIP_HAT "carbon_unequip_hat"
///defined twice, in carbon and human's topics, fired when interacting with a valid embedded_object to pull it out (mob/living/carbon/target, /obj/item, /obj/item/bodypart/L)
#define COMSIG_CARBON_EMBED_RIP "item_embed_start_rip"
///called when removing a given item from a mob, from mob/living/carbon/remove_embedded_object(mob/living/carbon/target, /obj/item)
#define COMSIG_CARBON_EMBED_REMOVAL "item_embed_remove_safe"

// /mob/living/simple_animal/hostile signals
#define COMSIG_HOSTILE_ATTACKINGTARGET "hostile_attackingtarget"
	#define COMPONENT_HOSTILE_NO_ATTACK (1<<0)

// /obj signals

///from base of code/game/machinery
#define COMSIG_OBJ_DEFAULT_UNFASTEN_WRENCH "obj_default_unfasten_wrench"
///from base of /turf/proc/levelupdate(). (intact) true to hide and false to unhide
#define COMSIG_OBJ_HIDE	"obj_hide"

// /obj/machinery signals

///from /obj/machinery/obj_break(damage_flag): (damage_flag)
#define COMSIG_MACHINERY_BROKEN "machinery_broken"
///from base power_change() when power is lost
#define COMSIG_MACHINERY_POWER_LOST "machinery_power_lost"
///from base power_change() when power is restored
#define COMSIG_MACHINERY_POWER_RESTORED "machinery_power_restored"

// /obj/item signals

///from base of obj/item/attack_qdeleted(): (atom/target, mob/user, params)
#define COMSIG_ITEM_ATTACK_QDELETED "item_attack_qdeleted"
///called before marking an object for retrieval, checked in /obj/effect/proc_holder/spell/targeted/summonitem/cast() : (mob/user)
#define COMSIG_ITEM_MARK_RETRIEVAL "item_mark_retrieval"
	#define COMPONENT_BLOCK_MARK_RETRIEVAL (1<<0)
///called on item when crossed by something (): (/atom/movable, mob/living/crossed)
#define COMSIG_ITEM_WEARERCROSSED "wearer_crossed"
///called on item when microwaved (): (obj/machinery/microwave/M)
#define COMSIG_ITEM_MICROWAVE_ACT "microwave_act"
///from base of item/sharpener/attackby(): (amount, max)
#define COMSIG_ITEM_SHARPEN_ACT "sharpen_act"
	#define COMPONENT_BLOCK_SHARPEN_APPLIED (1<<0)
	#define COMPONENT_BLOCK_SHARPEN_BLOCKED (1<<1)
	#define COMPONENT_BLOCK_SHARPEN_ALREADY (1<<2)
	#define COMPONENT_BLOCK_SHARPEN_MAXED (1<<3)
///from base of [/obj/item/proc/tool_check_callback]: (mob/living/user)
#define COMSIG_TOOL_IN_USE "tool_in_use"
///from base of [/obj/item/proc/tool_start_check]: (mob/living/user)
#define COMSIG_TOOL_START_USE "tool_start_use"
///from [/obj/item/proc/disableEmbedding]:
#define COMSIG_ITEM_DISABLE_EMBED "item_disable_embed"
///from [/obj/effect/mine/proc/triggermine]:
#define COMSIG_MINE_TRIGGERED "minegoboom"

// /obj/item signals for economy
///called when an item is sold by the exports subsystem
#define COMSIG_ITEM_SOLD "item_sold"
///called when a wrapped up structure is opened by hand
#define COMSIG_STRUCTURE_UNWRAPPED "structure_unwrapped"
#define COMSIG_ITEM_UNWRAPPED "item_unwrapped"
///called when a wrapped up item is opened by hand
	#define COMSIG_ITEM_SPLIT_VALUE  (1<<0)
///called when getting the item's exact ratio for cargo's profit.
#define COMSIG_ITEM_SPLIT_PROFIT "item_split_profits"
///called when getting the item's exact ratio for cargo's profit, without selling the item.
#define COMSIG_ITEM_SPLIT_PROFIT_DRY "item_split_profits_dry"

// /obj/item/clothing signals

///from base of /obj/item/clothing/suit/space/proc/toggle_spacesuit(): (obj/item/clothing/suit/space/suit)
#define COMSIG_SUIT_SPACE_TOGGLE "suit_space_toggle"

// /obj/item/pda signals

///called on pda when the user changes the ringtone: (mob/living/user, new_ringtone)
#define COMSIG_PDA_CHECK_DETONATE "pda_check_detonate"
	#define COMPONENT_PDA_NO_DETONATE (1<<0)

// /obj/item/gun signals

///called in /obj/item/gun/process_fire (user, target, params, zone_override)
#define COMSIG_MOB_FIRED_GUN "mob_fired_gun"

// /obj/item/grenade signals

///called in /obj/item/gun/process_fire (user, target, params, zone_override)
#define COMSIG_GRENADE_PRIME "grenade_prime"
///called in /obj/item/gun/process_fire (user, target, params, zone_override)
#define COMSIG_GRENADE_ARMED "grenade_armed"

// /obj/projectile signals (sent to the firer)

///from base of /obj/projectile/proc/on_hit(): (atom/movable/firer, atom/target, Angle)
#define COMSIG_PROJECTILE_SELF_ON_HIT "projectile_self_on_hit"
///from base of /obj/projectile/proc/on_hit(): (atom/movable/firer, atom/target, Angle)
#define COMSIG_PROJECTILE_ON_HIT "projectile_on_hit"
///from base of /obj/projectile/proc/fire(): (obj/projectile, atom/original_target)
#define COMSIG_PROJECTILE_BEFORE_FIRE "projectile_before_fire"
///from the base of /obj/projectile/proc/fire(): ()
#define COMSIG_PROJECTILE_FIRE "projectile_fire"
///sent to targets during the process_hit proc of projectiles
#define COMSIG_PROJECTILE_PREHIT "com_proj_prehit"
///sent to targets during the process_hit proc of projectiles
#define COMSIG_PROJECTILE_RANGE_OUT "projectile_range_out"
///sent when trying to force an embed (mainly for projectiles, only used in the embed element)
#define COMSIG_EMBED_TRY_FORCE "item_try_embed"

///sent to targets during the process_hit proc of projectiles
#define COMSIG_PELLET_CLOUD_INIT "pellet_cloud_init"

// /obj/mecha signals

///sent from mecha action buttons to the mecha they're linked to
#define COMSIG_MECHA_ACTION_ACTIVATE "mecha_action_activate"

// /mob/living/carbon/human signals

///from mob/living/carbon/human/UnarmedAttack(): (atom/target, proximity)
#define COMSIG_HUMAN_EARLY_UNARMED_ATTACK "human_early_unarmed_attack"
///Whenever EquipRanked is called, called after job is set
#define COMSIG_JOB_RECEIVED "job_received"

// /datum/song signals

///sent to the instrument when a song starts playing
#define COMSIG_SONG_START 	"song_start"
///sent to the instrument when a song stops playing
#define COMSIG_SONG_END		"song_end"

/*******Component Specific Signals*******/
//Creamed

///called when you wash your face at a sink: (num/strength)
#define COMSIG_COMPONENT_CLEAN_FACE_ACT "clean_face_act"

//Gibs

///from base of /obj/effect/decal/cleanable/blood/gibs/streak(): (list/directions, list/diseases)
#define COMSIG_GIBS_STREAK "gibs_streak"

//Mood
///Mood event that only RnD members listen for
#define COMSIG_ADD_MOOD_EVENT_RND "RND_add_mood"

//Nanites

///() returns TRUE if nanites have stealth
#define COMSIG_NANITE_IS_STEALTHY "nanite_is_stealthy"
///() deletes the nanite component
#define COMSIG_NANITE_DELETE "nanite_delete"
///(amount) Returns nanite amount
#define COMSIG_NANITE_GET_VOLUME "nanite_get_volume"
///(method) Modify cloud sync status. Method can be toggle, enable or disable
#define COMSIG_NANITE_SET_CLOUD_SYNC "nanite_set_cloud_sync"
///(comm_code(1-9999), comm_message) Called when sending a nanite comm signal to a mob.
#define COMSIG_NANITE_COMM_SIGNAL "nanite_comm_signal"
///(datum/nanite_program/new_program, datum/nanite_program/source_program) Called when adding a program to a nanite component

// /datum/component/two_handed signals

///from base of datum/component/two_handed/proc/wield(mob/living/carbon/user): (/mob/user)
#define COMSIG_TWOHANDED_WIELD "twohanded_wield"
	#define COMPONENT_TWOHANDED_BLOCK_WIELD (1<<0)
///from base of datum/component/two_handed/proc/unwield(mob/living/carbon/user): (/mob/user)
#define COMSIG_TWOHANDED_UNWIELD "twohanded_unwield"

//Xenobio hotkeys

///from slime CtrlClickOn(): (/mob)
#define COMSIG_XENO_SLIME_CLICK_CTRL "xeno_slime_click_ctrl"
///from slime AltClickOn(): (/mob)
#define COMSIG_XENO_SLIME_CLICK_ALT "xeno_slime_click_alt"
///from slime ShiftClickOn(): (/mob)
#define COMSIG_XENO_SLIME_CLICK_SHIFT "xeno_slime_click_shift"
///from turf ShiftClickOn(): (/mob)
#define COMSIG_XENO_TURF_CLICK_SHIFT "xeno_turf_click_shift"
///from turf AltClickOn(): (/mob)
#define COMSIG_XENO_TURF_CLICK_CTRL "xeno_turf_click_alt"
///from monkey CtrlClickOn(): (/mob)
#define COMSIG_XENO_MONKEY_CLICK_CTRL "xeno_monkey_click_ctrl"
