class_name Waste_Manager
extends Resource

# Declare member variables here. Examples:
export(float) var edible_waste = 100
export(float) var inedible_waste = 70
export(Array) var waste_managed_entries

export(Dictionary) var composting = {
	"id": 1,
	"type": "composting",
}

export(Dictionary) var landfill = {
	"id": 2,
	"type": "landfill",
}


func manage_waste( management_strategy:Dictionary, waste_type:bool, waste_amount:float, date:String):
	waste_managed_entries.append(management_strategy, waste_type, waste_amount, date)

func returnEdibleWaste():
	return edible_waste

func returnInedibleWaste():
	return inedible_waste

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
