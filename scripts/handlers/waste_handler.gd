extends Node

export(Resource) var MEAL

signal iwaste_produced(amount)
signal ewaste_produced(amount)
signal iwaste_managed(amount)
signal ewaste_managed(amount)
signal strategy_used(strategy, ewaste, iwaste)

enum { edible, inedible }

export(Dictionary) var composting = {
	"id": 1,
	"type": "composting",
}

export(Dictionary) var landfill = {
	"id": 2,
	"type": "landfill",
}


func dispose_leftover_prepared_meals():
	for leftover in Game.cookable_food:
		var waste_amount = 100 * Game.cookable_food[leftover]
		if waste_amount >= 0:
			add_waste("edible_waste", waste_amount)
	# Resets cookable food
	Game.cookable_food = {
		chicken_curry = 0,
		beef_curry = 0,
		pork_curry = 0,
		lemonade = 0,
		coffee = 0,
	}


func add_waste(waste_type: String, waste_amount: float):
	if waste_type == "inedible_waste":
		Game.inedible_waste += waste_amount
#		emit_signal("iwaste_produced", waste_amount)
	if waste_type == "edible_waste":
		Game.edible_waste += waste_amount


#		emit_signal("ewaste_produced", waste_amount)


func manage_waste(management_strategy: String, waste_type: String, waste_amount: float, date: int):
	if waste_type == "inedible_waste" && Game.inedible_waste != 0:
		Game.inedible_waste -= waste_amount
		emit_signal("iwaste_managed", waste_amount)
		emit_signal("strategy_used", management_strategy, 0, waste_amount)
	elif waste_type == "edible_waste" && Game.edible_waste != 0:
		Game.edible_waste -= waste_amount
		emit_signal("ewaste_managed", waste_amount)
		emit_signal("strategy_used", management_strategy, waste_amount, 0)
	else:
		return

	var waste_entry = {
		management_strategy = management_strategy,
		waste_type = waste_type,
		waste_amount = waste_amount,
		date = date
	}


func get_str_edible_waste():
	return "%.2f" % (Game.edible_waste)


func get_str_inedible_waste():
	return "%.2f" % (Game.inedible_waste)


func get_str_waste():
	return "%.2f" % (Game.edible_waste + Game.inedible_waste)
