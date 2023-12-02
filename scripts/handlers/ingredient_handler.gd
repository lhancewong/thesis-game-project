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

	if Game.money >= price:
		Game.i_stockpile[ingredient.type] += amount
		Game.money -= price
		emit_signal("money_spent", price)
		emit_signal("ingred_bought", ingredient.type, amount)

		debug_msg = "Bought %.2f dollars of %s"
	else:
		debug_msg = "You broke ass bitch you can't afford %.2f pesos of %s"

	if get_tree().current_scene.name == "OnDaylight":
		var terminal = get_node(
			"/root/OnDaylight/VBoxContainer/HBoxContainer/VBoxContainer2/GameConsole"
		)
		terminal.add_text(debug_msg % [price, type])


func spend_ingredients(food: Dictionary) -> void:
	var ingredient_list = food.ingredients

	for i in ingredient_list:
		if i in Game.i_stockpile:
			Game.i_stockpile[i] -= 1
			emit_signal("ingred_consumed", i, 1)


func check_unlocked_ingredients():
	if get_tree().current_scene.name == "OnDaylight":
		var beef_block_node = get_node(
			"/root/OnDaylight/VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/OrderIngredients/VBoxContainer/Order/BeefBlock"
		)
		var beef_node = get_node(
			"/root/OnDaylight/VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/OrderIngredients/VBoxContainer/Order/Beef"
		)
		var pork_block_node = get_node(
			"/root/OnDaylight/VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/OrderIngredients/VBoxContainer/Order/PorkBlock"
		)
		var pork_node = get_node(
			"/root/OnDaylight/VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/OrderIngredients/VBoxContainer/Order/Pork"
		)
		if Game.day >= 4:
			beef_block_node.visible = false
			beef_node.visible = true
			Game.unlocked_ingredients.beef = true
		if Game.day >= 9:
			pork_block_node.visible = false
			pork_node.visible = true
			Game.unlocked_ingredients.pork = true
