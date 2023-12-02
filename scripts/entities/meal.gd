class_name Meal
extends Resource

export(Dictionary) var menu = {
	chicken_curry = {
		"id": 1,
		"base_price": 380,
		"type": "chicken_curry",
		"ingredients": ["chicken", "curry_powder"],
		"toppings": ["potato", "spinach", "eggplant", "cheese"],
	},
	beef_curry = {
		"id": 2,
		"base_price": 450,
		"type": "beef_curry",
		"ingredients": ["beef", "curry_powder"],
		"toppings": ["potato", "spinach", "eggplant", "cheese"],
	},
	pork_curry = {
		"id": 3,
		"base_price": 380,
		"type": "pork_curry",
		"ingredients": ["pork", "curry_powder"],
		"toppings": ["potato", "spinach", "eggplant", "cheese"],
	},
	lemonade = {
		"id": 4,
		"base_price": 140,
		"type": "lemonade",
		"ingredients": ["lemon", "cucumber"],
	},
	coffee = {
		"id": 5,
		"base_price": 100,
		"type": "coffee",
		"ingredients": ["coffee_mix", "milk"],
	},
}
