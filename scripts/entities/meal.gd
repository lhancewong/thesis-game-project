class_name Meal
extends Resource

# Small restaurant = 69 grams per meal
# Large restaurant = 132 grams per meal
export(Dictionary) var menu = {
	chicken_curry = {
		"base_price": 260,
		"base_ewaste": 250,
		"base_iwaste": 65,
		"type": "chicken_curry",
		"ingredients": ["chicken", "curry_stock"],
		"toppings": ["potato", "spinach", "eggplant", "cheese"],
	},
	beef_curry = {
		"base_price": 310,
		"base_ewaste": 250,
		"base_iwaste": 75,
		"type": "beef_curry",
		"ingredients": ["beef", "curry_stock"],
		"toppings": ["potato", "spinach", "eggplant", "cheese"],
	},
	pork_curry = {
		"base_price": 290,
		"base_ewaste": 250,
		"base_iwaste": 75,
		"type": "pork_curry",
		"ingredients": ["pork", "curry_stock"],
		"toppings": ["potato", "spinach", "eggplant", "cheese"],
	},
	lemonade = {
		"base_price": 120,
		"base_ewaste": 30,
		"base_iwaste": 30,
		"type": "lemonade",
		"ingredients": ["lemon", "cucumber"],
	},
	coffee = {
		"base_price": 80,
		"base_ewaste": 50,
		"base_iwaste": 50,
		"type": "coffee",
		"ingredients": ["coffee_mix", "milk"],
	},
}
