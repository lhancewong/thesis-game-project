class_name Waste_Manager
extends Resource

# Declare member variables here. Examples:
export(float) var edible_waste = 0.0
export(float) var inedible_waste = 0.0
export(Array) var waste_managed_entries

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
		inedible_waste += waste_amount
	if waste_type == 1:
		edible_waste += waste_amount

func manage_waste( management_strategy:String, waste_type:int, waste_amount:float, date:int):
	
	var type
	
	match waste_type:
		0: type = "Inedible"
		1: type = "Edible"
	var waste_entry = [management_strategy, type, waste_amount, date] 
	waste_managed_entries.append(waste_entry)
	if type == "Inedible":
		inedible_waste -= waste_amount
	elif type == "Edible":
		edible_waste -= waste_amount
	print(waste_managed_entries)

func get_edible_waste():
	return ("%.2f" % (edible_waste))

func get_inedible_waste():
	return ("%.2f" % (inedible_waste))

func get_waste():
	return ("%.2f" % (edible_waste + inedible_waste))
