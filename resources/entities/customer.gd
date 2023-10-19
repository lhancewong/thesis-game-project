class_name Customer
extends Resource

const BASE_WASTE = 10
const BASE_SATISFACTION = 1

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
