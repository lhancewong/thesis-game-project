extends Node

export(Resource) var INGRED

signal ingred_bought(type, amount)
signal ingred_consumed(type, amount)
signal ingred_costed(type, amount)
signal money_spent(amount)


func buy_ingredients(type: String, amount: int) -> void:
	var ingredient
	var price
	var debug_msg

	match type:
		"Chicken":
			ingredient = INGRED.chicken
		"Beef":
			ingredient = INGRED.beef
		"Pork":
			ingredient = INGRED.pork
		"Curry Powder":
			ingredient = INGRED.curry_stock
		"Lemon":
			ingredient = INGRED.lemon
		"Cucumber":
			ingredient = INGRED.cucumber
		"Coffee Mix":
			ingredient = INGRED.coffee_mix
		"Milk":
			ingredient = INGRED.milk
		_:
			push_error("Buy Ingredients error")

	price = ingredient.price * amount
	if Game.buffs_hndlr.feed_animals_buff():
		print("Price Decreased!")
		price = price * 0.9

	if Game.money >= price:
		Game.ingredients_ordered[ingredient.type] += amount
		Game.money -= price
		emit_signal("money_spent", price)
		emit_signal("ingred_bought", ingredient.type, amount)
		emit_signal("ingred_costed", ingredient.type, price)
		SoundHandler.progress_fill.play()
		debug_msg = "Bought %.2f dollars of %s"
	else:
		SoundHandler.angry_noise.play()
		debug_msg = "You broke ass bitch you can't afford %.2f pesos of %s"

	if get_tree().current_scene.name == "OnDaylight":
		var game_console = get_node("/root/OnDaylight/%GameConsole")
		game_console.add_text(debug_msg % [price, type])


func get_ingredient(type: String):
	match type:
		"Chicken":
			return INGRED.chicken
		"Beef":
			return INGRED.beef
		"Pork":
			return INGRED.pork
		"Curry Powder":
			return INGRED.curry_stock
		"Lemon":
			return INGRED.lemon
		"Cucumber":
			return INGRED.cucumber
		"Coffee Mix":
			return INGRED.coffee_mix
		"Milk":
			return INGRED.milk
		_:
			return INGRED.lemon


func receive_ingredients_ordered():
	for ingred_type in Game.ingredients_ordered:
		Game.i_stockpile[ingred_type] += Game.ingredients_ordered[ingred_type]


func spend_ingredients(ingredients: Array, amount: int) -> void:
	for ingredient in ingredients:
		Game.i_stockpile[ingredient] -= amount
		emit_signal("ingred_consumed", ingredient, amount)


func check_unlocked_ingredients():
	if get_tree().current_scene.name == "OnDaylight":
		var order_ingreds_node = get_node("/root/OnDaylight/%OrderIngredients")
		var price_mgmt_node = get_node("/root/OnDaylight/%PriceManagement")
		var prepare_meals_node = get_node("/root/OnDaylight/%PrepareMeals")

		if Game.day >= 3:
			order_ingreds_node.set_coffee_visibility()
			price_mgmt_node.set_coffee_visibility()
			prepare_meals_node.set_coffee_visibility()
			Game.unlocked_ingredients.coffee = true
			Game.unlocked_ingredients.milk = true

		if Game.day >= 5:
			order_ingreds_node.set_beef_visibility()
			price_mgmt_node.set_beef_visibility()
			prepare_meals_node.set_beef_visibility()
			Game.unlocked_ingredients.beef = true

		if Game.day >= 7:
			order_ingreds_node.set_lemonade_visibility()
			price_mgmt_node.set_lemonade_visibility()
			prepare_meals_node.set_lemonade_visibility()
			Game.unlocked_ingredients.lemon = true
			Game.unlocked_ingredients.cucumber = true

		if Game.day >= 10:
			order_ingreds_node.set_pork_visibility()
			price_mgmt_node.set_pork_visibility()
			prepare_meals_node.set_pork_visibility()
			Game.unlocked_ingredients.pork = true
