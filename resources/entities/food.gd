class_name Food
extends Resource

export(Dictionary) var chicken_curry = {
	"id": 1,
	"base_price": 20,
	"type": "Chicken Curry",
	"ingredients": ["chicken", "curry_powder"],
	"toppings": ["potato", "spinach", "eggplant", "cheese"],
}

export(Dictionary) var beef_curry = {
	"id": 2,
	"base_price": 25,
	"type": "Beef Curry",
	"ingredients": ["beef", "curry_powder"],
	"toppings": ["potato", "spinach", "eggplant", "cheese"],
}

export(Dictionary) var pork_curry = {
	"id": 3,
	"base_price": 23,
	"type": "Pork Curry",
	"ingredients": ["pork", "curry_powder"],
	"toppings": ["potato", "spinach", "eggplant", "cheese"],
}

export(Dictionary) var lemonade = {
	"id": 4,
	"base_price": 7,
	"type": "Lemonade",
	"ingredients": ["lemon", "sugar"],
}

export(Dictionary) var coffee = {
	"id": 5,
	"base_price": 7,
	"type": "Coffee",
	"ingredients": ["coffee_mix", "sugar"],
}

var dict = {
	"Chicken Curry": chicken_curry,
	"Beef Curry": beef_curry,
	"Pork Curry": pork_curry,
	"Lemonade": lemonade,
	"Coffee": coffee,
	}

func get_rand_food() -> Dictionary:
	var list = dict.values()
	var food = list[randi() % list.size()]
	
	return food

func get_food_list() -> Array:
	return dict.values()

func get_food(name: String) -> Dictionary:
	return dict[name]
	
