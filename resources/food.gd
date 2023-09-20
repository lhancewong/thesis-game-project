class_name Food
extends Resource


export(Dictionary) var list = {
	0: chicken_curry,
	1: beef_curry,
	2: pork_curry,
	3: lemonade,
	4: coffee,
}

export(Dictionary) var chicken_curry = {
	"id": 1,
	"base_price": 10,
	"ingredients": ["chicken", "curry_powder"],
	"toppings": ["potato", "spinach", "eggplant", "cheese"],
}

export(Dictionary) var beef_curry = {
	"id": 2,
	"base_price": 15,
	"ingredients": ["beef", "curry_powder"],
	"toppings": ["potato", "spinach", "eggplant", "cheese"],
}

export(Dictionary) var pork_curry = {
	"id": 3,
	"base_price": 13,
	"ingredients": ["pork", "curry_powder"],
	"toppings": ["potato", "spinach", "eggplant", "cheese"],
}

export(Dictionary) var lemonade = {
	"id": 4,
	"base_price": 5,
	"ingredients": ["lemon", "sugar"],
}

export(Dictionary) var coffee = {
	"id": 5,
	"base_price": 5,
	"ingredients": ["coffee_mix", "sugar"],
}
