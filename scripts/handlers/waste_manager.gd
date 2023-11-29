extends Node

signal iwaste_produced(amount)
signal ewaste_produced(amount)
signal iwaste_managed(amount)
signal ewaste_managed(amount)

enum { edible, inedible }

export(Dictionary) var composting = {
	"id": 1,
	"type": "composting",
}

export(Dictionary) var landfill = {
	"id": 2,
	"type": "landfill",
}


func add_waste(waste_type: String, waste_amount: float):
	if waste_type == "inedible_waste":
		Game.inedible_waste += waste_amount
		emit_signal("iwaste_produced", waste_amount)
	if waste_type == "edible_waste":
		Game.edible_waste += waste_amount
		emit_signal("ewaste_produced", waste_amount)


func manage_waste(management_strategy: String, waste_type: String, waste_amount: float, date: int):
	var type

	if waste_type == "inedible_waste" && Game.inedible_waste != 0:
		Game.inedible_waste -= waste_amount
		emit_signal("iwaste_managed", waste_amount)
	elif waste_type == "edible_waste" && Game.edible_waste != 0:
		Game.edible_waste -= waste_amount
		emit_signal("ewaste_managed", waste_amount)
	else:
		return

	var waste_entry = {
		management_strategy = management_strategy,
		waste_type = waste_type,
		waste_amount = waste_amount,
		date = date
	}
	Game.waste_managed.append(waste_entry)
	print(Game.waste_managed)


func get_str_edible_waste():
	return "%.2f" % (Game.edible_waste)


func get_str_inedible_waste():
	return "%.2f" % (Game.inedible_waste)


func get_str_waste():
	return "%.2f" % (Game.edible_waste + Game.inedible_waste)


func save():
	var save_dict = {
		"edible": Game.edible_waste,
		"inedible": Game.inedible_waste,
		"entries": Game.waste_managed,
	}
	return save_dict
