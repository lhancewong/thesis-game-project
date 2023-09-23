class_name Ingredient
extends Resource


export(Dictionary) var chicken = {
	"id": 0,
	"type": "chicken",
	"price": 2.99,
}

export(Dictionary) var beef = {
	"id": 1,
	"type": "beef",
	"price": 4.99,
}

export(Dictionary) var pork = {
	"id": 2,
	"type": "pork",
	"price": 3.49,
}

export(Dictionary) var curry_powder = {
	"id": 3,
	"type": "curry_powder",
	"price": 6.99,
}

export(Dictionary) var potato = {
	"id": 4,
	"type": "potato",
	"price": 0.79,
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

export(Dictionary) var lemon = {
	"id": 8,
	"type": "lemon",
	"price": 1,
}

export(Dictionary) var coffee_mix = {
	"id": 9,
	"type": "coffee_mix",
	"price": 5.99,
}

export(Dictionary) var sugar = {
	"id": 10,
	"type": "sugar",
	"price": 0.69,
}

export(Dictionary) var stockpile = {
	"chicken": 0, 
	"beef": 0, 
	"pork": 0, 
	"curry_powder": 0, 
	"potato": 0, 
	"spinach": 0, 
	"eggplant": 0, 
	"cheese": 0, 
	"lemon": 0, 
	"coffee_mix": 0, 
	"sugar": 0,
}

func get_stockpile() -> Dictionary:
	return stockpile


func spend_ingredients(food: Dictionary) -> void:
	var ingredient_list = food["ingredients"]
	
	for i in (ingredient_list):
		if i in stockpile:
			stockpile[i] -= 1


func buy_ingredients(type: int, amount: int) -> float:
	var ingredient
	match (type):
		0: ingredient = chicken
		1: ingredient = beef
		2: ingredient = pork
		3: ingredient = curry_powder
	
	
	var price = ingredient["price"] * amount
	stockpile[ingredient["type"]] += amount
	
	return price


# Maybe prepare curry stock, chicken stock, beef stock, and the veggies

# If the ingredients are this granulated, maybe ordering ingredients can either
# be by pre-determined batches. Like curry ingredient batch which auto-selects
# the correct amount of each ingredient.
#
# Or even better curry stock is an option to create that just "encapsulates"
# the required ingredients into one big boye. So all u need to preprepare is
# enough curry stock and the meats. (and then add some drinks and veggies)

# New storage tab that has info about rotting times (per week basis) for stored
# ingredients. Could also mention food waste but maybe its bad taste to put
# them in the same menu interface.
