// In this document: Chair code, Simple chairs, Wooden chairs, Comfy chairs, Stools, Brass chair

// --------------
// CHAIR CODE 
// --------------

/obj/structure/chair
	name = "chair"
	desc = "You sit in this. Either by will or force."
	icon = 'icons/fallout/objects/furniture/chairs.dmi'
	icon_state = "chair"
	anchored = TRUE
	can_buckle = 1
	buckle_lying = 0 //you sit in a chair, not lay
	resistance_flags = NONE
	max_integrity = 250
	integrity_failure = 0.1
	custom_materials = list(/datum/material/iron = 2000)
	var/buildstacktype = /obj/item/stack/sheet/metal
	var/buildstackamount = 1
	var/item_chair = /obj/item/chair // if null it can't be picked up
	layer = OBJ_LAYER

/obj/structure/chair/examine(mob/user)
	. = ..()
	. += SPAN_NOTICE("It's held together by a couple of <b>bolts</b>.")
	if(!has_buckled_mobs())
		. += SPAN_NOTICE("Drag your sprite to sit in it.")

/obj/structure/chair/Initialize()
	. = ..()
	if(!anchored)	//why would you put these on the shuttle?
		addtimer(CALLBACK(src, .proc/RemoveFromLatejoin), 0)

/obj/structure/chair/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/simple_rotation,ROTATION_ALTCLICK | ROTATION_CLOCKWISE, CALLBACK(src, .proc/can_user_rotate),CALLBACK(src, .proc/can_be_rotated),null)

/obj/structure/chair/proc/can_be_rotated(mob/user)
	return TRUE

/obj/structure/chair/proc/can_user_rotate(mob/user)
	var/mob/living/L = user

	if(istype(L))
		if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
			return FALSE
		else
			return TRUE
	else if(isobserver(user) && CONFIG_GET(flag/ghost_interaction))
		return TRUE
	return FALSE

/obj/structure/chair/Destroy()
	RemoveFromLatejoin()
	return ..()

/obj/structure/chair/proc/RemoveFromLatejoin()
	SSjob.latejoin_trackers -= src	//These may be here due to the arrivals shuttle

/obj/structure/chair/deconstruct()
	// If we have materials, and don't have the NOCONSTRUCT flag
	if(!(flags_1 & NODECONSTRUCT_1))
		if(buildstacktype)
			new buildstacktype(loc,buildstackamount)
		else
			for(var/i in custom_materials)
				var/datum/material/M = i
				new M.sheet_type(loc, FLOOR(custom_materials[M] / MINERAL_MATERIAL_AMOUNT, 1))
	..()

/obj/structure/chair/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/chair/narsie_act()
	var/obj/structure/chair/wood/W = new/obj/structure/chair/wood(get_turf(src))
	W.setDir(dir)
	qdel(src)

/obj/structure/chair/ratvar_act()
	var/obj/structure/chair/brass/B = new(get_turf(src))
	B.setDir(dir)
	qdel(src)

/obj/structure/chair/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/wrench) && !(flags_1&NODECONSTRUCT_1))
		W.play_tool_sound(src)
		deconstruct()
	else if(istype(W, /obj/item/assembly/shock_kit))
		if(!user.temporarilyRemoveItemFromInventory(W))
			return
		var/obj/item/assembly/shock_kit/SK = W
		var/obj/structure/chair/e_chair/E = new /obj/structure/chair/e_chair(src.loc)
		playsound(src.loc, 'sound/items/deconstruct.ogg', 50, 1)
		E.setDir(dir)
		E.part = SK
		SK.forceMove(E)
		SK.master = E
		qdel(src)
	else
		return ..()

/obj/structure/chair/alt_attack_hand(mob/living/user)
	if(Adjacent(user) && istype(user))
		if(!item_chair || !user.can_hold_items() || !has_buckled_mobs() || buckled_mobs.len > 1 || dir != user.dir || flags_1 & NODECONSTRUCT_1)
			return TRUE
		if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
			to_chat(user, SPAN_WARNING("You can't do that right now!"))
			return TRUE
		if(IS_STAMCRIT(user))
			to_chat(user, SPAN_WARNING("You're too exhausted for that."))
			return TRUE
		var/mob/living/poordude = buckled_mobs[1]
		if(!istype(poordude))
			return TRUE
		user.visible_message(SPAN_NOTICE("[user] pulls [src] out from under [poordude]."), SPAN_NOTICE("You pull [src] out from under [poordude]."))
		var/obj/item/chair/C = new item_chair(loc)
		C.set_custom_materials(custom_materials)
		TransferComponents(C)
		user.put_in_hands(C)
		poordude.DefaultCombatKnockdown(20)//rip in peace
		user.adjustStaminaLoss(5)
		unbuckle_all_mobs(TRUE)
		qdel(src)
		return TRUE

/obj/structure/chair/attack_tk(mob/user)
	if(!anchored || has_buckled_mobs() || !isturf(user.loc))
		..()
	else
		setDir(turn(dir,-90))

/obj/structure/chair/proc/handle_rotation(direction)
	handle_layer()
	if(has_buckled_mobs())
		for(var/m in buckled_mobs)
			var/mob/living/buckled_mob = m
			buckled_mob.setDir(direction)

/obj/structure/chair/proc/handle_layer()
	if(has_buckled_mobs() && dir == NORTH)
		layer = ABOVE_MOB_LAYER
	else
		layer = OBJ_LAYER

/obj/structure/chair/post_buckle_mob(mob/living/M)
	. = ..()
	handle_layer()

/obj/structure/chair/post_unbuckle_mob()
	. = ..()
	handle_layer()

/obj/structure/chair/setDir(newdir)
	..()
	handle_rotation(newdir)

/obj/structure/chair/MouseDrop(over_object, src_location, over_location)
	. = ..()
	if(over_object == usr && Adjacent(usr))
		if(!item_chair || !usr.can_hold_items() || has_buckled_mobs() || src.flags_1 & NODECONSTRUCT_1)
			return
		if(!usr.canUseTopic(src, BE_CLOSE, ismonkey(usr)))
			return
		usr.visible_message(SPAN_NOTICE("[usr] grabs \the [src.name]."), SPAN_NOTICE("You grab \the [src.name]."))
		var/obj/item/C = new item_chair(loc)
		C.set_custom_materials(custom_materials)
		TransferComponents(C)
		usr.put_in_hands(C)
		qdel(src)


// -------------------
// CHAIR ITEM (inhand)
// -------------------

/obj/item/chair
	name = "chair"
	desc = "Bar brawl essential."
	icon = 'icons/fallout/objects/furniture/chairs.dmi'
	icon_state = "chair_toppled"
	item_state = "chair"
	lefthand_file = 'icons/mob/inhands/misc/chairs_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/chairs_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	force = 8
	throwforce = 10
	throw_range = 3
	hitsound = 'sound/items/trayhit1.ogg'
	custom_materials = list(/datum/material/iron = 2000)
	var/break_chance = 5 //Likely hood of smashing the chair.
	var/obj/structure/chair/origin_type = /obj/structure/chair
	item_flags = ITEM_CAN_PARRY | ITEM_CAN_BLOCK
	block_parry_data = /datum/block_parry_data/chair

/obj/item/chair/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands = TRUE)

/datum/block_parry_data/chair
	block_damage_multiplier = 0.7
	block_stamina_efficiency = 2
	block_stamina_cost_per_second = 1.5
	block_slowdown = 0.5
	block_lock_attacking = FALSE
	block_lock_sprinting = TRUE
	block_start_delay = 1.5
	block_damage_absorption = 7
	block_damage_limit = 20
	block_resting_stamina_penalty_multiplier = 2
	block_projectile_mitigation = 20
	parry_stamina_cost = 5
	parry_time_windup = 1
	parry_time_active = 11
	parry_time_spindown = 2
	parry_time_perfect = 1.5
	parry_time_perfect_leeway = 1
	parry_imperfect_falloff_percent = 7.5
	parry_efficiency_to_counterattack = 100
	parry_efficiency_considered_successful = 50
	parry_efficiency_perfect = 120
	parry_efficiency_perfect_override = list(
		TEXT_ATTACK_TYPE_PROJECTILE = 30,
	)
	parry_failed_stagger_duration = 3.5 SECONDS
	parry_data = list(PARRY_COUNTERATTACK_MELEE_ATTACK_CHAIN = 2.5)

/obj/item/chair/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] begins hitting [user.p_them()]self with \the [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	playsound(src,hitsound,50,1)
	return BRUTELOSS

/obj/item/chair/narsie_act()
	var/obj/item/chair/wood/W = new/obj/item/chair/wood(get_turf(src))
	W.setDir(dir)
	qdel(src)

/obj/item/chair/attack_self(mob/user)
	plant(user)

/obj/item/chair/proc/plant(mob/user)
	for(var/obj/A in get_turf(loc))
		if(istype(A, /obj/structure/chair))
			to_chat(user, SPAN_DANGER("There is already a chair here."))
			return
		if(A.density && !(A.flags_1 & ON_BORDER_1))
			to_chat(user, SPAN_DANGER("There is already something here."))
			return

	user.visible_message(SPAN_NOTICE("[user] rights \the [src.name]."), SPAN_NOTICE("You right \the [name]."))
	var/obj/structure/chair/C = new origin_type(get_turf(loc))
	C.set_custom_materials(custom_materials)
	TransferComponents(C)
	C.setDir(dir)
	qdel(src)

/obj/item/chair/proc/smash(mob/living/user)
	var/stack_type = initial(origin_type.buildstacktype)
	if(!stack_type)
		return
	var/remaining_mats = initial(origin_type.buildstackamount)
	remaining_mats-- //Part of the chair was rendered completely unusable. It magically dissapears. Maybe make some dirt?
	if(remaining_mats)
		for(var/M=1 to remaining_mats)
			new stack_type(get_turf(loc))
	qdel(src)

/obj/item/chair/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(!(attack_type & ATTACK_TYPE_UNARMED))
		return NONE
	return ..()

/obj/item/chair/afterattack(atom/target, mob/living/carbon/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(prob(break_chance))
		user.visible_message(SPAN_DANGER("[user] smashes [src] to pieces against [target]."))
		if(iscarbon(target))
			var/mob/living/carbon/C = target
			if(C.health < C.maxHealth*0.5)
				C.DefaultCombatKnockdown(20)
		smash(user)



//OBSOLETE replace with 
/obj/structure/chair/stool/f13stool
	name = "bar stool"
	desc = "It has some unsavory stains on it..."
	icon_state = "f13stool"
	item_chair = /obj/item/chair/stool/bar

// OBSOLETE
/obj/structure/chair/wood/worn

// OBSOLETE
/obj/structure/chair/wood/normal //Kept for map compatibility

// OBSOLETE repace with /folding
/obj/structure/chair/f13foldupchair
	icon_state = "folding_chair"

// OBSOLETE repace with /chair
/obj/structure/chair/f13chair1
	icon_state = "f13chair1"
	item_chair = null

/obj/structure/chair/f13chair2
	icon_state = "f13chair2"
	item_chair = null


///////////////////
// SIMPLE CHAIRS //
///////////////////

/obj/structure/chair/folding
	icon_state = "folding_chair"
	item_chair = /obj/item/chair/folding

/obj/item/chair/folding
	icon_state = "folding_chair_toppled"
	origin_type = /obj/structure/chair/folding


/obj/structure/chair/greyscale
	icon_state = "chair_greyscale"
	material_flags = MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	item_chair = /obj/item/chair/greyscale
	buildstacktype = null //Custom mats handle this

/obj/item/chair/greyscale
	icon_state = "chair_greyscale_toppled"
	item_state = "chair_greyscale"
	material_flags = MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	origin_type = /obj/structure/chair/greyscale


///////////////////
// WOODEN CHAIRS //
///////////////////

/obj/structure/chair/wood
	name = "wooden chair"
	desc = "Old is never too old to not be in fashion."
	icon_state = "wooden_chair"
	resistance_flags = FLAMMABLE
	max_integrity = 70
	buildstacktype = /obj/item/stack/sheet/mineral/wood
	buildstackamount = 3
	item_chair = /obj/item/chair/wood

/obj/item/chair/wood
	name = "wooden chair"
	icon_state = "wooden_chair_toppled"
	item_state = "woodenchair"
	resistance_flags = FLAMMABLE
	max_integrity = 70
	hitsound = 'sound/weapons/genhit1.ogg'
	origin_type = /obj/structure/chair/wood
	custom_materials = null
	break_chance = 50


/obj/structure/chair/wood/wings
	name = "winged wooden chair"
	desc = "Polished wood furniture"
	icon_state = "wooden_chair_winged"
	item_chair = /obj/item/chair/wood/wings

/obj/item/chair/wood/wings
	icon_state = "wooden_chair_wings_toppled"
	origin_type = /obj/structure/chair/wood/wings


/obj/structure/chair/wood/modern
	icon_state = "wooden_chair_new"
	desc = "This chair is good as new.<br>Old is never too old to not be in fashion."
	item_chair = /obj/item/chair/wood/modern

/obj/item/chair/wood/modern
	icon_state = "wooden_chair_new_toppled"
	item_state = "wooden_chair_new"
	origin_type = /obj/structure/chair/wood/modern


/obj/structure/chair/wood/fancy
	name = "fancy wooden chair"
	desc = "An elegant chair made of luxurious wood."
	icon_state = "wooden_chair_fancy"
	item_chair = /obj/item/chair/wood/fancy

/obj/item/chair/wood/fancy
	icon_state = "wooden_chair_fancy_toppled"
	item_state = "wooden_chair_fancy"
	origin_type = /obj/structure/chair/wood/fancy


////////////////////////
// COMFORTABLE CHAIRS //
////////////////////////

/obj/structure/chair/comfy
	name = "comfy chair"
	desc = "It looks comfy."
	icon_state = "comfychair"
	color = COLOR_PALE_ORANGE
	resistance_flags = FLAMMABLE
	max_integrity = 70
	buildstackamount = 2
	item_chair = null
	var/mutable_appearance/armrest

/obj/structure/chair/comfy/Initialize()
	armrest = GetArmrest()
	armrest.layer = ABOVE_MOB_LAYER
	return ..()

/obj/structure/chair/comfy/proc/GetArmrest()
	return mutable_appearance('icons/fallout/objects/furniture/chairs.dmi', "comfychair_armrest")

/obj/structure/chair/comfy/Destroy()
	QDEL_NULL(armrest)
	return ..()

/obj/structure/chair/comfy/post_buckle_mob(mob/living/M)
	. = ..()
	update_armrest()

/obj/structure/chair/comfy/proc/update_armrest()
	if(has_buckled_mobs())
		add_overlay(armrest)
	else
		cut_overlay(armrest)

/obj/structure/chair/comfy/post_unbuckle_mob()
	. = ..()
	update_armrest()

/obj/structure/chair/comfy/brown
	color = COLOR_MAROON

/obj/structure/chair/comfy/beige
	color = COLOR_BROWN

/obj/structure/chair/comfy/teal
	color = COLOR_TEAL

/obj/structure/chair/comfy/black
	color = COLOR_FLOORTILE_GRAY 

/obj/structure/chair/comfy/green
	color = COLOR_GREEN_GRAY

/obj/structure/chair/comfy/lime
	color = COLOR_LIME

/obj/structure/chair/comfy/purple
	color = COLOR_PURPLE_GRAY


// -------------
// PLYWOOD CHAIR
// -------------

/obj/structure/chair/comfy/plywood
	name = "plywood chair"
	desc = "Soft and comfy."
	icon_state = "plywood_chair"
	anchored = FALSE
	buildstacktype = /obj/item/stack/sheet/mineral/wood
	buildstackamount = 4

/obj/structure/chair/comfy/plywood/GetArmrest()
	return mutable_appearance('icons/fallout/objects/furniture/chairs.dmi', "plywood_chair_armrest")


// -------------
// LUXURY SEATS
// -------------

/obj/structure/chair/comfy/shuttle
	name = "luxurious chair"
	desc = "A comfortable, secure seat from synthetic leather."
	icon_state = "luxurious_chair"

/obj/structure/chair/comfy/shuttle/GetArmrest()
	return mutable_appearance('icons/fallout/objects/furniture/chairs.dmi', "shuttle_chair_armrest")


/obj/structure/chair/comfy/synthetic
	name = "synthetic chair"
	desc = "A comfortable, secure seat. It has a more sturdy looking buckling system, for smoother flights."
	icon_state = "synthetic_chair"


////////////
// THRONE //
////////////

/obj/structure/chair/comfy/throne
	name = "tribal throne"
	desc = "A massive chair from various animal parts and wood."
	icon = 'icons/fallout/objects/furniture/throne.dmi'
	icon_state = "throne"
	item_chair = null

/obj/structure/chair/comfy/throne/GetArmrest()
	return mutable_appearance('icons/fallout/objects/furniture/throne.dmi', "throne_armrest")


///////////////////
// OFFICE CHAIRS //
///////////////////

/obj/structure/chair/office
	name = "office chair"
	desc = "Suitable for cubicles."
	icon_state = "office_chair"
	anchored = FALSE
	buildstackamount = 5
	item_chair = null
	drag_delay = 0.05 SECONDS //Pulling something on wheels is easy

/obj/structure/chair/office/Moved()
	. = ..()
	if(has_gravity())
		playsound(src, 'sound/effects/roll.ogg', 100, 1)

/obj/structure/chair/office/light
	icon_state = "office_chair_white"

/obj/structure/chair/office/dark
	icon_state = "officechair_dark"


////////////
// STOOLS //
////////////

/obj/structure/chair/stool
	name = "stool"
	desc = "Apply butt."
	icon_state = "stool_old"
	can_buckle = 0
	buildstackamount = 1
	item_chair = /obj/item/chair/stool

/obj/structure/chair/stool/narsie_act()
	return

/obj/item/chair/stool
	name = "stool"
	icon_state = "stool_old_toppled"
	item_state = "stool"
	origin_type = /obj/structure/chair/stool
	break_chance = 0 //It's too sturdy.

/obj/item/chair/stool/narsie_act()
	return //sturdy enough to ignore a god


/obj/structure/chair/stool/bar
	name = "bar stool"
	desc = "It has some unsavory stains on it..."
	icon_state = "bar_old"
	item_chair = /obj/item/chair/stool/bar

/obj/item/chair/stool/bar
	name = "bar stool"
	icon_state = "bar_old_toppled"
	item_state = "stool_bar"
	origin_type = /obj/structure/chair/stool/bar


/obj/structure/chair/stool/retro
	name = "bar stool"
	icon_state = "bar"
	item_chair = /obj/item/chair/stool/retro

/obj/item/chair/stool/retro
	icon_state = "bar_toppled"
	item_state = "nv_backed"
	origin_type = /obj/structure/chair/stool/retro


/obj/structure/chair/stool/retro/black
	name = "bar stool"
	icon_state = "bar_black"
	item_chair = /obj/item/chair/stool/retro/black

/obj/item/chair/stool/retro/black
	icon_state = "bar_black_toppled"
	item_state = "nvbar_black"
	origin_type = /obj/structure/chair/stool/retro/black


/obj/structure/chair/stool/retro/tan
	name = "bar stool"
	icon_state = "bar_tan"
	item_chair = /obj/item/chair/stool/retro/tan

/obj/item/chair/stool/retro/tan
	icon_state = "bar_tan_toppled"
	item_state = "nvbar_tan"
	origin_type = /obj/structure/chair/stool/retro/tan


/obj/structure/chair/stool/retro/backed
	name = "bar stool"
	icon_state = "bar_backed"
	item_chair = /obj/item/chair/stool/retro/backed

/obj/item/chair/stool/retro/backed
	icon_state = "bar_backed_toppled"
	item_state = "nv_backed"
	origin_type = /obj/structure/chair/stool/retro/backed


/obj/structure/chair/stool/alien
	name = "alien stool"
	desc = "A hard stool made of advanced alien alloy."
	icon_state = "stoolalien"
	item_chair = /obj/item/chair/stool/alien
	buildstacktype = /obj/item/stack/sheet/mineral/abductor
	buildstackamount = 1

/obj/item/chair/stool/alien
	name = "stool"
	icon_state = "stoolalien_toppled"
	item_state = "stoolalien"
	origin_type = /obj/structure/chair/stool/alien
	break_chance = 0 //It's too sturdy.


// -------------
// BRASS CHAIR
// -------------

/obj/structure/chair/brass
	name = "brass chair"
	desc = "A spinny chair made of brass. It looks uncomfortable."
	icon_state = "brass_chair"
	max_integrity = 150
	buildstacktype = /obj/item/stack/tile/brass
	buildstackamount = 1
	item_chair = null

/obj/structure/chair/brass/ComponentInitialize()
	return //it spins with the power of ratvar, not components.

/obj/structure/chair/brass/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	. = ..()

/obj/structure/chair/brass/process()
	setDir(turn(dir,-90))
	playsound(src, 'sound/effects/servostep.ogg', 50, FALSE)

/obj/structure/chair/brass/ratvar_act()
	return

/obj/structure/chair/brass/AltClick(mob/living/user)
	. = ..()
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	if(!(datum_flags & DF_ISPROCESSING))
		user.visible_message(SPAN_NOTICE("[user] spins [src] around, and Ratvarian technology keeps it spinning FOREVER."), \
		SPAN_NOTICE("Automated spinny chairs. The pinnacle of Ratvarian technology."))
		START_PROCESSING(SSfastprocess, src)
	else
		user.visible_message(SPAN_NOTICE("[user] stops [src]'s uncontrollable spinning."), \
		SPAN_NOTICE("You grab [src] and stop its wild spinning."))
		STOP_PROCESSING(SSfastprocess, src)
	return TRUE