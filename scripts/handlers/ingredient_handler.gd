extends Node

export(Resource) var INGRED

signal ingred_bought(type, amount)
signal ingred_consumed(type, amount)
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
			ingredient = INGRED.curry_powder
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
		Game.i_stockpile[ingredient.type] += amount
		Game.money -= price
		emit_signal("money_spent", price)
		emit_signal("ingred_bought", ingredient.type, amount)
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
			return INGRED.curry_powder
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


func spend_ingredients(food: Dictionary) -> void:
	var ingredient_list = food.ingredients

	for i in ingredient_list:
		if i in Game.i_stockpile:
			Game.i_stockpile[i] -= 1
			emit_signal("ingred_consumed", i, 1)


func check_unlocked_ingredients():
	if get_tree().current_scene.name == "OnDaylight":
		var beef_block_node = get_node(
			"/root/OnDaylight/VBoxContainer/MainPanelNResto/MainPanel/MainPanel/MarginContainer/OrderIngredients/VBoxContainer/MealIngredients/BeefBlock"
		)
		var beef_node = get_node(
			"/root/OnDaylight/VBoxContainer/MainPanelNResto/MainPanel/MainPanel/MarginContainer/OrderIngredients/VBoxContainer/MealIngredients/Beef"
		)
		var pork_block_node = get_node(
			"/root/OnDaylight/VBoxContainer/MainPanelNResto/MainPanel/MainPanel/MarginContainer/OrderIngredients/VBoxContainer/MealIngredients/PorkBlock"
		)
		var pork_node = get_node(
			"/root/OnDaylight/VBoxContainer/MainPanelNResto/MainPanel/MainPanel/MarginContainer/OrderIngredients/VBoxContainer/MealIngredients/Pork"
		)
		if Game.day >= 4:
			beef_block_node.visible = false
			beef_node.visible = true
			Game.unlocked_ingredients.beef = true
		if Game.day >= 9:
			pork_block_node.visible = false
			pork_node.visible = true
			Game.unlocked_ingredients.pork = true
