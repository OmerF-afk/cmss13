

/obj/item/clothing/shoes/marine
	name = "marine combat boots"
	desc = "Standard issue combat boots for combat scenarios or combat situations. All combat, all the time."
	icon_state = "marine"
	item_state = "marine"
	armor = list(melee = 60, bullet = 40, laser = 10,energy = 10, bomb = 10, bio = 10, rad = 0)
	flags_cold_protection = FEET
	flags_heat_protection = FEET
	min_cold_protection_temperature = SHOE_min_cold_protection_temperature
	max_heat_protection_temperature = SHOE_max_heat_protection_temperature
	siemens_coefficient = 0.7
	var/obj/item/stored_item
	var/armor_stage = 0
	var/list/items_allowed = list( /obj/item/weapon/combat_knife, /obj/item/weapon/throwing_knife, /obj/item/weapon/gun/pistol/holdout)

/obj/item/clothing/shoes/marine/Dispose()
	if(stored_item)
		cdel(stored_item)
		stored_item = null
	. = ..()

/obj/item/clothing/shoes/marine/attack_hand(var/mob/living/M)
	if(stored_item && src.loc == M && !M.is_mob_incapacitated()) //Only allow someone to take out the stored_item if it's being worn or held. So you can pick them up off the floor
		if(M.put_in_active_hand(stored_item))
			M << "<span class='notice'>You slide [stored_item] out of [src].</span>"
			playsound(M, 'sound/weapons/gun_shotgun_shell_insert.ogg', 15, 1)
			stored_item = 0
			update_icon()
		return
	..()

/obj/item/clothing/shoes/marine/attackby(var/obj/item/I, var/mob/living/M)
	for (var/i in items_allowed)
		if(istype(I, i))
			if(stored_item)	return
			M.drop_held_item()
			stored_item = I
			I.loc = src
			M << "<div class='notice'>You slide the [I] into [src].</div>"
			playsound(M, 'sound/weapons/gun_shotgun_shell_insert.ogg', 15, 1)
			update_icon()
			break

/obj/item/clothing/shoes/marine/update_icon()
	if(stored_item && !armor_stage)
		icon_state = "marine-1"
	else
		if(!armor_stage)
			icon_state = initial(icon_state)


/obj/item/clothing/shoes/marine/knife/New()
	..()
	stored_item = new /obj/item/weapon/combat_knife(src)
	update_icon()

/obj/item/clothing/shoes/marinechief
	name = "chief officer shoes"
	desc = "Only a small amount of monkeys, kittens, and orphans were killed in making this."
	icon_state = "laceups"
	armor = list(melee = 50, bullet = 50, laser = 25,energy = 25, bomb = 20, bio = 20, rad = 10)
	flags_inventory = NOSLIPPING
	siemens_coefficient = 0.6

/obj/item/clothing/shoes/marinechief/commander
	name = "commander shoes"
	desc = "Has special soles for better trampling those underneath."


/obj/item/clothing/shoes/veteran

/obj/item/clothing/shoes/veteran/PMC
	name = "polished shoes"
	desc = "The height of fashion, but these look to be woven with protective fiber."
	icon_state = "jackboots"
	item_state = "jackboots"
	armor = list(melee = 60, bullet = 40, laser = 10,energy = 10, bomb = 10, bio = 10, rad = 0)
	min_cold_protection_temperature = SHOE_min_cold_protection_temperature
	max_heat_protection_temperature = SHOE_max_heat_protection_temperature
	flags_cold_protection = FEET
	flags_heat_protection = FEET
	flags_inventory = FPRINT|NOSLIPPING
	siemens_coefficient = 0.6

/obj/item/clothing/shoes/veteran/PMC/commando
	name = "\improper PMC commando boots"
	desc = "A pair of heavily armored, acid-resistant boots."
	icon_state = "commando_boots"
	permeability_coefficient = 0.01
	armor = list(melee = 90, bullet = 120, laser = 100, energy = 90, bomb = 20, bio = 30, rad = 30)
	siemens_coefficient = 0.2
	unacidable = 1
