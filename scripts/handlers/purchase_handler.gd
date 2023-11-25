extends Node

export(Resource) var CUSTO
signal day_completed

# Sibling Nodes
onready var food_hndlr = $"../Food"
onready var custo_hndler = $"../Customer"
onready var ingred_hndler = $"../Ingredient"
onready var waste_hndlr = $"../Waste"


# Adds noise to a float value
func _noisefy(num: float):
	return rand_range(0.95, 1.05) * num


# Handles a customer buying a food item
func start_day() -> void:
	var day_length = rand_range(Game.min_day_len, Game.max_day_len)
	var customer_amount = rand_range(Game.min_custo, Game.max_custo)
	var steve_harvey
	var terminal
	var npc_spawner
	
	if get_tree().current_scene.name == "OnDaylight":
		steve_harvey = get_node("/root/OnDaylight/PauseFrame/SteveHarvey")
		terminal = get_node("/root/OnDaylight/VBoxContainer/HBoxContainer/VBoxContainer2/GameConsole")
		npc_spawner = get_node("/root/OnDaylight/NPCs/Spawner")

	for i in customer_amount:
		var entry = _create_transaction()

		if entry.empty():
			terminal.add_text("No Food!" + str(entry))
			SoundHandler.get_node("DryFart").play()
		else:
			terminal.add_entry(entry)
			SoundHandler.get_node("VineBoom").play()
			npc_spawner.spawnNPC()
			steve_harvey.visible = !steve_harvey.visible

		var wait = rand_range(0.7, 1.3) * (day_length / customer_amount)
		yield(get_tree().create_timer(wait), "timeout")

	Game.on_day_end()


func _create_transaction() -> Dictionary:
	food_hndlr.update_cookable_food()

	var custo = custo_hndler.get_rand_customer()
	var food = food_hndlr.get_food(food_hndlr.get_rand_cookable_food())

	# Checks if theres any cookable food
	if food == null:
		return {}
	elif food.empty():
		return {}

	Game.custos_served_per_day[Game.day][custo["type"]] += 1
	Game.meals_served_per_day[Game.day][food["type"]] += 1

	ingred_hndler.spend_ingredients(food)
	var entry = _log_transaction_entry(food, custo)
	_update_restaurant(entry)

	return entry


func _update_restaurant(entry: Dictionary) -> void:
	Game.money += entry.food_payment
	waste_hndlr.add_waste(entry["waste_type"], entry["waste_amnt"])
	Game.satisfaction += entry.satisfaction

	Game.money_earned_per_day[Game.day] += entry.food_payment
	match entry["waste_type"]:
		0:
			Game.e_waste_managed_per_day[Game.day] += entry["waste_amnt"]
		1:
			Game.i_waste_managed_per_day[Game.day] += entry["waste_amnt"]
	Game.satis_earned_per_day[Game.day] += entry.satisfaction


func _log_transaction_entry(food: Dictionary, customer: Dictionary) -> Dictionary:
	var food_id = food.id
	var food_type = food.type
	var food_payment = food.base_price

	var customer_type = customer.type
	var waste_amnt = int(_noisefy(CUSTO.BASE_WASTE * customer.waste_factor))
	var waste_type = randi() % 2
	var satisfaction_amnt = _noisefy(CUSTO.BASE_SATISFACTION * customer.satisfaction_factor)

	var entry = {
		"day": Game.day,
		"food_id": food_id,
		"food_type": food_type,
		"food_payment": food_payment,
		"customer": customer_type,
		"waste_type": waste_type,
		"waste_amnt": waste_amnt,
		"satisfaction": satisfaction_amnt,
	}

	Game.sold_food.append(entry)

	return entry


func _increment_day_end_entry():
	pass


func _log_day_end_entry():
	pass
	var entry = {}
