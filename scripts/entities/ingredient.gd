class_name Ingredient
extends Resource

# https://thegoodmeat.ph/product/breasts-860g/
export(Dictionary) var chicken = {
	"id": 0,
	"type": "chicken",
	"price": 30.25,  # 0.23 per gram, 130 grams per serving
}

# https://thegoodmeat.ph/product/beef-cubes-500g/
export(Dictionary) var beef = {
	"id": 1,
	"type": "beef",
	"price": 68.0,  # 0.52 per gram, 130 grams per serving
}

# https://thegoodmeat.ph/product/pork-tonkatsu-500g/
export(Dictionary) var pork = {
	"id": 2,
	"type": "pork",
	"price": 60.0,  # 0.46 per gram, 130 grams per serving
}

export(Dictionary) var curry_powder = {
	"id": 3,
	"type": "curry_powder",
	"price": 120.0,  # guesstimate
}

# https://safeselect.ph/products/lemon
export(Dictionary) var lemon = {
	"id": 8,
	"type": "lemon",
	"price": 44.25,
}

# https://safeselect.ph/products/cucumber-regular
export(Dictionary) var cucumber = {
	"id": 9,
	"type": "cucumber",
	"price": 42.25,
}

# https://tinyurl.com/5n8sfhzf
export(Dictionary) var coffee_mix = {
	"id": 10,
	"type": "coffee_mix",
	"price": 17.50,
}

# https://gourmetdirectph.myshopify.com/products/hmi-35-milk
export(Dictionary) var milk = {
	"id": 11,
	"type": "milk",
	"price": 31.40,
}

export(Dictionary) var potato = {
	"id": 4,
	"type": "potato",
	"price": 0,
}

export(Dictionary) var spinach = {
	"id": 5,
	"type": "spinach",
	"price": 2.49,
}

export(Dictionary) var eggplant = {
	"id": 6,
	"type": "eggplant",
	"price": 1.99,
}

export(Dictionary) var cheese = {
	"id": 7,
	"type": "cheese",
	"price": 5.49,
}
