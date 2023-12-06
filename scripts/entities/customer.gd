class_name Customer
extends Resource

const BASE_WASTE = 100
const BASE_SATISFACTION = 1

# Customer Types
export(Dictionary) var tourist = {
	"type": "tourist",
	"waste_factor": 1.00,
	"satisfaction_factor": 0.60,
	"buy_factor": -5,  # flat change to buy percent chance
}

export(Dictionary) var regular = {
	"type": "regular",
	"waste_factor": 0.70,
	"satisfaction_factor": 1.50,
	"buy_factor": 15,  # flat change to buy percent chance
}

export(Dictionary) var local = {
	"type": "local",
	"waste_factor": 0.80,
	"satisfaction_factor": 0.50,
	"buy_factor": 5,  # flat change to buy percent chance
}
