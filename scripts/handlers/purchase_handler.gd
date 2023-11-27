extends Node

export(Resource) var CUSTO

signal meal_served(type)
signal customer_served(type)
signal money_earned(amount)
signal satsifation_gained(amount)

# Sibling Nodes
onready var food_hndlr = $"../Food"
onready var custo_hndler = $"../Customer"
onready var ingred_hndler = $"../Ingredient"
onready var waste_hndlr = $"../Waste"


# Adds noise to a float value
func _noisefy(num: float):
	return rand_range(0.95, 1.05) * num


func create_transaction() -> Dictionary:
	food_hndlr.update_cookable_food()

	var custo = custo_hndler.get_rand_customer()
	var food = food_hndlr.get_food(food_hndlr.get_rand_cookable_food())

	# Checks if theres any cookable food
	if food == null:
		return {}
	elif food.empty():
		return {}

	ingred_hndler.spend_ingredients(food)
	var entry = _log_transaction_entry(food, custo)
	_update_restaurant(entry)

	return entry


func _update_restaurant(entry: Dictionary) -> void:
	Game.money += entry.food_payment
	waste_hndlr.add_waste(entry["waste_type"], entry["waste_amnt"])
	Game.satisfaction += entry.satisfaction


func _log_transaction_entry(food: Dictionary, customer: Dictionary) -> Dictionary:
	var food_id = food.id
	var food_type = food.type
	var food_payment = food.base_price

	var customer_type = customer.type
	var waste_amnt = int(_noisefy(CUSTO.BASE_WASTE * customer.waste_factor))
	var waste_type = randi() % 2
	var satisfaction_amnt = _noisefy(CUSTO.BASE_SATISFACTION * customer.satisfaction_factor)

	emit_signal("meal_served", food_type)
	emit_signal("customer_served", customer_type)
	emit_signal("money_earned", food_payment)
	emit_signal("satsifation_gained", satisfaction_amnt)

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
