extends Node

export(Resource) var CUSTO

signal transaction_failed(type)
signal transaction_succeded(meal, customer, payment, ewaste, iwaste, satisfaction)

# Sibling Nodes
onready var food_hndlr = $"../Food"
onready var custo_hndler = $"../Customer"
onready var ingred_hndler = $"../Ingredient"
onready var waste_hndlr = $"../Waste"


func ready():
	randomize()


# Adds noise to a float value
func _noisefy(num: float):
	return rand_range(0.95, 1.05) * num


func create_transaction() -> Dictionary:
	food_hndlr.update_cookable_food()

	var custo = custo_hndler.get_rand_customer()
	var meal = food_hndlr.get_rand_cookable_meal()

	# Checks if theres any cookable food
	if typeof(meal) == TYPE_STRING:
		emit_signal("transaction_failed", "no_meal")
		return {no_meals = "No Meals"}

	# Checks buy chance
	var base_price = meal["base_price"]
	var current_price = Game.meal_prices[meal["type"]]
	var buy_chance = calculate_buy_chance(base_price, current_price, custo["buy_factor"])
	if randf() <= buy_chance:
		ingred_hndler.spend_ingredients(meal["ingredients"], 1)
		var entry = _log_transaction_entry(meal, custo)
		_update_restaurant_var(entry)
		return entry
	else:
		emit_signal("transaction_failed", meal["type"])
		return {
			chance_fail = buy_chance * 100,
			mealtype = meal["type"],
			custotype = custo["type"],
			base_price = base_price,
			current = current_price
		}


func _update_restaurant_var(entry: Dictionary) -> void:
	Game.money += entry.food_payment
	waste_hndlr.add_waste(entry["waste_type_string"], entry["waste_amnt"])
	Game.satisfaction += entry.satisfaction


func _log_transaction_entry(food: Dictionary, customer: Dictionary) -> Dictionary:
	var food_type = food.type
	var food_payment = Game.meal_prices[food_type]
	var customer_type = customer.type
	var waste_amnt = int(_noisefy(CUSTO.BASE_WASTE * customer.waste_factor))
	var waste_type = randi() % 2
	var waste_type_string
	match waste_type:
		0:
			waste_type_string = "inedible_waste"
		1:
			waste_type_string = "edible_waste"
	var satisfaction_amnt = _noisefy(CUSTO.BASE_SATISFACTION * customer.satisfaction_factor)

	var ewaste = 0
	var iwaste = 0
	if waste_type:
		ewaste = waste_amnt
	else:
		iwaste = waste_amnt

	emit_signal(
		"transaction_succeded",
		food_type,
		customer_type,
		food_payment,
		ewaste,
		iwaste,
		satisfaction_amnt
	)

	var entry = {
		"day": Game.day,
		"food_type": food_type,
		"food_payment": food_payment,
		"customer": customer_type,
		"waste_type_string": waste_type_string,
		"waste_amnt": waste_amnt,
		"satisfaction": satisfaction_amnt,
	}

	return entry


func calculate_buy_chance(base_price: float, current_price: float, customer_modifer: float):
	# max price for customers, any higher and they aint buying
	var max_tolerance = ceil(base_price * 1.6)
	# min price for customers, any lower and they always buying
	var min_tolerance = floor(base_price * 0.6)

	var upper = Vector2(max_tolerance, 0)
	var origin = Vector2(base_price, 85)
	var lower = Vector2(min_tolerance, 100)

	var chance
	# im pretty sure the y_intercept is the buy chance..
	if current_price > base_price:
		chance = calculate_y_intercept(upper, origin, current_price) + customer_modifer
	else:
		chance = calculate_y_intercept(lower, origin, current_price) + customer_modifer

	return (clamp(chance, 0, 100)) / 100


func calculate_y_intercept(point1: Vector2, point2: Vector2, x_value: float):
	var x1 = point1.x
	var y1 = point1.y
	var x2 = point2.x
	var y2 = point2.y

	# Calculate the slope
	var slope = (y2 - y1) / (x2 - x1)

	# Use one of the points to calculate the y-intercept (b)
	var intercept = y1 - slope * x1

	# Use the y = mx + b formula to find the y-value for the given x
	var y_value = slope * x_value + intercept

	return y_value
