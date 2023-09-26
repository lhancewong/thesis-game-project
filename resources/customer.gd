class_name Customer
extends Resource

const BASE_WASTE = 10
const BASE_SATISFACTION = 1

var rng = RandomNumberGenerator.new()

# Customer Types
export(Dictionary) var tourist = {
	"id": 1,
	"type": "tourist",
	"waste_factor": 1.25,
	"satisfaction_factor": 0.60,
}

export(Dictionary) var regular = {
	"id": 2,
	"type": "regular",
	"waste_factor": 1,
	"satisfaction_factor": 1.50,
}

export(Dictionary) var local = {
	"id": 3,
	"type": "local",
	"waste_factor": 0.25,
	"satisfaction_factor": 0.50,
}

func get_rand_type() -> Dictionary:
	# Chooses the customer number (for now they are all equally likely to appear)
	var id = rng.randi_range(1,3)
	var stats
	
	# Basically a switch statement
	match id:
		1: stats = tourist
		2: stats = regular
		3: stats = local
	
	return stats

# Purchase function to handle buying food
#
# Returns a list [payment, food_waste, satisfaction]
func purchase_food(food: Dictionary) -> Dictionary:
	
	# Chooses the customer number (for now they are all equally likely to appear)
	var id = rng.randi_range(1,3)
	var stats
	
	# Basically a switch statement
	match id:
		1: stats = tourist
		2: stats = regular
		3: stats = local
	
	# Randomizes values
	var food_id = food["id"]
	var food_type = food["type"]
	var food_payment = food["base_price"]
	
	var customer = stats.type
	var waste = int(_noisefy(BASE_WASTE * stats.waste_factor))
	var satisfaction = _noisefy(BASE_SATISFACTION * stats.satisfaction_factor)
	
	return {
		"food_id": food_id,
		"food_type": food_type,
		"food_payment": food_payment,
		"customer": customer,
		"waste": waste,
		"satisfaction": satisfaction
	} 

# Adds noise to a float value
func _noisefy(num: float):
	return rng.randfn(1, 0.1) * num
