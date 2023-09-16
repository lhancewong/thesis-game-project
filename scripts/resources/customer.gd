class_name Customer
extends Resource

export(int) var BASE_WASTE = 10
export(int) var BASE_SATISFACTION = 1
export(int) var BASE_PAYMENT = 50

var rng = RandomNumberGenerator.new()

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

# Purchase function to handle buying food
#
# Returns a list [payment, food_waste, satisfaction]
func purchase_food() -> Dictionary:
	
	# Chooses the customer number (for now they are all equally likely to appear)
	var id = rand_range(1,3)
	var stats
	
	# Basically a switch statement
	match int(id):
		1: stats = tourist
		2: stats = regular
		3: stats = local
	
	# Randomizes values
	var food_id = int(rand_range(1,2))
	var customer = stats.type
	var payment = _noisefy(BASE_PAYMENT)
	var waste = _noisefy(BASE_WASTE * stats.waste_factor)
	var satisfaction = _noisefy(BASE_SATISFACTION * stats.satisfaction_factor)
	
	return {
		"food_id": food_id,
		"customer": customer,
		"payment": payment,
		"waste": waste,
		"satisfaction": satisfaction
	} 

# Adds noise to a float value
func _noisefy(num: float):
	return rng.randfn(1, 0.1) * num
