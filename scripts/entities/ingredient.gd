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
