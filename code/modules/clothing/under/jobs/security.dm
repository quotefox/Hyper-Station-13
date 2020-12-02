/*
 * Contains:
 *		Security
 *		Detective
 *		Navy uniforms
 */
/*
 * Security
 */
/obj/item/clothing/under/rank/security
	name = "security jumpsuit"
	desc = "A tactical security jumpsuit for officers complete with Kinaris PMC belt buckle."
	icon_state = "rsecurity"
	item_state = "r_suit"
	item_color = "rsecurity"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	strip_delay = 50
	alt_covers_chest = TRUE
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
/obj/item/clothing/under/rank/security/grey
	name = "grey security jumpsuit"
	desc = "A tactical relic of years past before it was agreed upon that it was cheaper to just dye the suits red instead of washing out the blood."
	icon_state = "security"
	item_state = "gy_suit"
	item_color = "security"
/obj/item/clothing/under/rank/security/pink
	name = "pink security jumpsuit"
	desc = "A tactical security jumpsuit for officers that screw up their laundry."
	icon_state = "rsecuritypink"
	item_state = "r_suit"
	item_color = "rsecuritypink"
/obj/item/clothing/under/rank/security/skirt
	name = "security jumpskirt"
	desc = "A \"tactical\" security jumpsuit with the legs replaced by a skirt."
	icon_state = "secskirt"
	item_state = "r_suit"
	item_color = "secskirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE //you know now that i think of it if you adjust the skirt and the sprite disappears isn't that just like flashing everyone
	fitted = FEMALE_UNIFORM_TOP
/obj/item/clothing/under/rank/security/skirt/slut
	name = "slutty security jumpskirt"
	desc = "A \"\"\"tactical\"\"\" security jumpsuit with the legs replaced by a skirt. No matter how you adjust it, it always feels a little too small."
	icon_state = "secslutskirt"
	item_state = "secslutskirt"
	item_color = null //i dont understand what item_color even is, apparently setting it to null means it won't change color in a washing machine?
	mutantrace_variation = NO_MUTANTRACE_VARIATION //look at the first two comments in vg_under.dm
/obj/item/clothing/under/rank/security/skirt/slut/pink
	desc = "A \"\"\"tactical\"\"\" security jumpsuit with the legs replaced by a skirt. No matter how you adjust it, it always feels a little too small. This one seems to have an experimental color scheme."
	icon_state = "secslutskirtpink"
	item_state = "secslutskirtpink"
/obj/item/clothing/under/rank/security/stripper
	name = "security stripper outfit"
	desc = "This can't be dress code compliant, can it?"
	icon_state = "secstripper"
	item_state = "secstripper"
	item_color = null
	can_adjust = FALSE
	body_parts_covered = CHEST|GROIN
	mutantrace_variation = NO_MUTANTRACE_VARIATION


/obj/item/clothing/under/rank/warden
	name = "security suit"
	desc = "A formal security suit for officers complete with Kinaris PMC belt buckle."
	icon_state = "rwarden"
	item_state = "r_suit"
	item_color = "rwarden"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	strip_delay = 50
	alt_covers_chest = TRUE
	sensor_mode = 3
	random_sensor = FALSE
/obj/item/clothing/under/rank/warden/grey
	name = "grey security suit"
	desc = "A formal relic of years past before it was decided it was cheaper to dye the suits red instead of washing out the blood."
	icon_state = "warden"
	item_state = "gy_suit"
	item_color = "warden"

/obj/item/clothing/under/rank/warden/skirt
	name = "warden's suitskirt"
	desc = "A formal security suitskirt for officers complete with Kinaris PMC belt buckle."
	icon_state = "rwarden_skirt"
	item_state = "r_suit"
	item_color = "rwarden_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/*
 * Detective
 */
/obj/item/clothing/under/rank/det
	name = "hard-worn suit"
	desc = "Someone who wears this means business."
	icon_state = "detective"
	item_state = "det"
	item_color = "detective"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	strip_delay = 50
	alt_covers_chest = TRUE
	sensor_mode = 3
	random_sensor = FALSE

/obj/item/clothing/under/rank/det/skirt
	name = "detective's suitskirt"
	desc = "Someone who wears this means business."
	icon_state = "detective_skirt"
	item_state = "det"
	item_color = "detective_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/det/grey
	name = "noir suit"
	desc = "A hard-boiled private investigator's grey suit, complete with tie clip."
	icon_state = "greydet"
	item_state = "greydet"
	item_color = "greydet"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/det/grey/skirt
	name = "noir suitskirt"
	desc = "A hard-boiled private investigator's grey suitskirt, complete with tie clip."
	icon_state = "greydet_skirt"
	item_state = "greydet"
	item_color = "greydet_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/*
 * Head of Security
 */
/obj/item/clothing/under/rank/head_of_security
	name = "head of security's jumpsuit"
	desc = "A security jumpsuit decorated for those few with the dedication to achieve the position of Head of Security."
	icon_state = "rhos"
	item_state = "r_suit"
	item_color = "rhos"
	armor = list("melee" = 10, "bullet" = 5, "laser" = 5,"energy" = 5, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	strip_delay = 60
	alt_covers_chest = TRUE
	sensor_mode = 3
	random_sensor = FALSE

/obj/item/clothing/under/rank/head_of_security/skirt
	name = "head of security's jumpskirt"
	desc = "A security jumpskirt decorated for those few with the dedication to achieve the position of Head of Security."
	icon_state = "rhos_skirt"
	item_state = "r_suit"
	item_color = "rhos_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/head_of_security/grey
	name = "head of security's grey jumpsuit"
	desc = "There are old men, and there are bold men, but there are very few old, bold men."
	icon_state = "hos"
	item_state = "gy_suit"
	item_color = "hos"
/obj/item/clothing/under/rank/head_of_security/alt
	name = "head of security's turtleneck"
	desc = "A stylish alternative to the normal head of security jumpsuit, complete with tactical pants."
	icon_state = "hosalt"
	item_state = "bl_suit"
	item_color = "hosalt"

/obj/item/clothing/under/rank/head_of_security/alt/skirt
	name = "head of security's turtleneck skirt"
	desc = "A stylish alternative to the normal head of security jumpsuit, complete with a tactical skirt."
	icon_state = "hosalt_skirt"
	item_state = "bl_suit"
	item_color = "hosalt_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/*
 * Navy uniforms
 */
/obj/item/clothing/under/rank/security/navyblue
	name = "security officer's formal uniform"
	desc = "The latest in fashionable security outfits."
	icon_state = "officerblueclothes"
	item_state = "officerblueclothes"
	item_color = "officerblueclothes"
	alt_covers_chest = TRUE
/obj/item/clothing/under/rank/head_of_security/navyblue
	desc = "The insignia on this uniform tells you that this uniform belongs to the Head of Security."
	name = "head of security's formal uniform"
	icon_state = "hosblueclothes"
	item_state = "hosblueclothes"
	item_color = "hosblueclothes"
	alt_covers_chest = TRUE
/obj/item/clothing/under/rank/warden/navyblue
	desc = "The insignia on this uniform tells you that this uniform belongs to the Warden."
	name = "warden's formal uniform"
	icon_state = "wardenblueclothes"
	item_state = "wardenblueclothes"
	item_color = "wardenblueclothes"
	alt_covers_chest = TRUE
/*
 *Blueshirt
 */
/obj/item/clothing/under/rank/security/blueshirt
	name = "blue shirt and tie"
	desc = "I'm a little busy right now, Calhoun."
	icon_state = "blueshift"
	item_state = "blueshift"
	item_color = "blueshift"
	can_adjust = FALSE
/*
 *Spacepol
 */
/obj/item/clothing/under/rank/security/spacepol
	name = "police uniform"
	desc = "Space not controlled by megacorporations, planets, or pirates is under the jurisdiction of Spacepol."
	icon_state = "spacepol"
	item_state = "spacepol"
	item_color = "spacepol"
	can_adjust = FALSE
