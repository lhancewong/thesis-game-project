extends Node

export(Resource) var MEAL


# Calculates possible food items that can be cooked given
# the current ingredient stockpile
func update_cookable_food():
	var food_list = MEAL.menu.values()

	for food in food_list:
		var cookable = true
		var temp_igdt_list = []
		for i_name in food["ingredients"]:
			var i_stock = Game.i_stockpile[str(i_name)]
			if i_stock < 1:
				cookable = false
				break
			else:
				temp_igdt_list.append(i_stock)

		if cookable:
			var cookable_amnt = temp_igdt_list.min()
			Game.cookable_food[food["type"]] = cookable_amnt
		else:
			Game.cookable_food.erase(food["type"])


func pre_prepare_meal(meal_type: String, amount: int):
	var meal = MEAL.menu[meal_type]

	var needed_ingredients = []
	for ingredient in meal["ingredients"]:
		if Game.i_stockpile[ingredient] < amount:
			print("not enough ingredients!")
			return
		else:
			needed_ingredients.append(ingredient)

	Game.cookable_food[meal_type] += amount
	$"../Ingredient".spend_ingredients(needed_ingredients, amount)


func get_rand_cookable_meal() -> String:
	var c_food_keys = Game.cookable_food.keys()
	if c_food_keys:
		var food_name = c_food_keys[randi() % c_food_keys.size()]
		return MEAL.menu[food_name]
	else:
		return "No Meals"


func get_meal(type: String):
	return MEAL.menu[type]


func set_meal_price(meal: String, price: float):
	Game.meal_prices[meal] = price
