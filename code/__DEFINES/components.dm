#define SEND_SIGNAL(target, sigtype, arguments...) ( !target.comp_lookup || !target.comp_lookup[sigtype] ? NONE : target._SendSignal(sigtype, list(target, ##arguments)) )

#define SEND_GLOBAL_SIGNAL(sigtype, arguments...) ( SEND_SIGNAL(SSdcs, sigtype, ##arguments) )

#define COMPONENT_INCOMPATIBLE 1
#define COMPONENT_NOTRANSFER 2

// How multiple components of the exact same type are handled in the same datum

#define COMPONENT_DUPE_HIGHLANDER		0		//old component is deleted (default)
#define COMPONENT_DUPE_ALLOWED			1	//duplicates allowed
#define COMPONENT_DUPE_UNIQUE			2	//new component is deleted
#define COMPONENT_DUPE_UNIQUE_PASSARGS	4	//old component is given the initialization args of the new

// All signals. Format:
// When the signal is called: (signal arguments)
// All signals send the source datum of the signal as the first argument

// global signals
// These are signals which can be listened to by any component on any parent
// start global signals with "!", this used to be necessary but now it's just a formatting choice
//////////////////////////////////////////////////////////////////

// /datum signals
// /atom signals
	//Positions for overrides list
	//End positions
#define COMSIG_ATOM_RATVAR_ACT "atom_ratvar_act"				//from base of atom/ratvar_act(): ()
/////////////////

// /area signals

// /turf signals

// /atom/movable signals

// /mob/living signals

// /mob/living/carbon signals

// /obj signals
#define COMSIG_OBJ_BREAK		"obj_break"						//from base of /obj/obj_break(): (damage_flag)

// /obj/item signals

// /obj/item/clothing signals

// /obj/item/implant signals
	//This uses all return values of COMSIG_IMPLANT_OTHER

// /obj/item/pda signals

// /obj/item/radio signals

// /obj/item/pen signals

// /mob/living/carbon/human signals

// /datum/species signals

/*******Component Specific Signals*******/
//Janitor

//Food

//Mood
#define COMSIG_INCREASE_SANITY "decrease_sanity" //Called when you want to increase sanity from anywhere in the code.
#define COMSIG_DECREASE_SANITY "increase_sanity" //Same as above but to decrease sanity instead.

//NTnet

//Nanites

// /datum/component/storage signals

// /datum/action signals

/*******Non-Signal Component Related Defines*******/

//Redirection component init flags
#define REDIRECT_TRANSFER_WITH_TURF 1

//Arch
#define ARCH_PROB "probability"					//Probability for each item
#define ARCH_MAXDROP "max_drop_amount"				//each item's max drop amount

//Ouch my toes!
#define CALTROP_BYPASS_SHOES 1
#define CALTROP_IGNORE_WALKERS 2

#define ELEMENT_INCOMPATIBLE 1 // Return value to cancel attaching

// /datum/element flags
/// Causes the detach proc to be called when the host object is being deleted
#define ELEMENT_DETACH		(1 << 0)
/**
  * Only elements created with the same arguments given after `id_arg_index` share an element instance
  * The arguments are the same when the text and number values are the same and all other values have the same ref
  */
#define ELEMENT_BESPOKE		(1 << 1)
#define COMSIG_MOVABLE_UPDATE_GLIDE_SIZE "movable_glide_size"	//Called when the movable's glide size is updated: (new_glide_size)

#define COMSIG_LIVING_FULLY_HEAL "living_fully_healed"		//from base of /mob/living/fully_heal(): (admin_revive)

