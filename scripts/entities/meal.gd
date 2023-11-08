class_name Meal
extends Resource

export(Dictionary) var menu = {
  chicken_curry = {
  "id": 1,
  "base_price": 20,
  "type": "Chicken Curry",
  "ingredients": ["chicken", "curry_powder"],
  "toppings": ["potato", "spinach", "eggplant", "cheese"],
  },
  beef_curry = {
  "id": 2,
  "base_price": 25,
  "type": "Beef Curry",
  "ingredients": ["beef", "curry_powder"],
  "toppings": ["potato", "spinach", "eggplant", "cheese"],
  },
  pork_curry = {
  "id": 3,
  "base_price": 23,
  "type": "Pork Curry",
  "ingredients": ["pork", "curry_powder"],
  "toppings": ["potato", "spinach", "eggplant", "cheese"],
  },
  lemonade = {
  "id": 4,
  "base_price": 7,
  "type": "Lemonade",
  "ingredients": ["lemon", "sugar"],
  },
  coffee = {
  "id": 5,
  "base_price": 7,
  "type": "Coffee",
  "ingredients": ["coffee_mix", "sugar"],
  },
}
