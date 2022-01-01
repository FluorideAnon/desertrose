/obj/item/seeds/ash
	name = "pack of ash flower seeds"
	desc = "These dubious little seeds grow into some Ash Blossom vines."
	icon_state = "seed-ash"
	species = "ash"
	plantname = "Ash Vines"
	product = /obj/item/reagent_containers/food/snacks/grown/ashBlossom
	lifespan = 100
	endurance = 30
	maturation = 10
	production = 5
	yield = 3
	potency = 30
	growthstages = 3
	rarity = 20
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "ash-grow"
	icon_dead = "ash-dead"
	icon_harvest = "ash-harvest"
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/medicine/charcoal = 0.1, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/reagent_containers/food/snacks/grown/ashBlossom
	seed = /obj/item/seeds/Ash
	name = "ashblossom"
	desc = "Ash Flowers take a, well, ashy-purple appearance, and blossom from thin, yet tough, water-intensive vines."
	icon_state = "Ash Blossom"
	filling_color = "#FF6347"
	juice_results = list(/datum/reagent/consumable/ethanol/ashtea = 0)