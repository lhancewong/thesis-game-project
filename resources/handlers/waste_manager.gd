extends Node

enum {edible, inedible}

export(Dictionary) var composting = {
	"id": 1,
	"type": "composting",
}

export(Dictionary) var landfill = {
	"id": 2,
	"type": "landfill",
}

func add_waste(waste_type:int, waste_amount:float):
	if waste_type == 0:
		Game.inedible_waste += waste_amount
	if waste_type == 1:
		Game.edible_waste += waste_amount

func manage_waste( management_strategy:String, waste_type:int, waste_amount:float, date:int):
	var type
	
	match waste_type:
		0: type = "Inedible"
		1: type = "Edible"
	if type == "Inedible" && Game.inedible_waste != 0:
		Game.inedible_waste -= waste_amount
	elif type == "Edible" && Game.edible_waste != 0:
		Game.edible_waste -= waste_amount
	else:
		return
	
	var waste_entry = [management_strategy, type, waste_amount, date] 
	Game.waste_managed.append(waste_entry)
	print(Game.waste_managed)

func get_edible_waste():
	return ("%.2f" % (Game.edible_waste))

func get_inedible_waste():
	return ("%.2f" % (Game.inedible_waste))

func get_waste():
	return ("%.2f" % (Game.edible_waste + Game.inedible_waste))

func save():
	var save_dict = {
		"edible": Game.edible_waste,
		"inedible": Game.inedible_waste,
		"entries": Game.waste_managed,
	}
	return save_dict
