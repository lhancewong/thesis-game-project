extends Node

# Game variables
onready var money = 100.0
onready var edible_waste = 0.0
onready var inedible_waste = 0.0
onready var satisfaction = 0.0
onready var day = 0

onready var store_level = 0
onready var skill_point = 0
onready var compost_stack = []
onready var last_compost_day = 0

onready var unlocked_ingredients = {
	chicken = true,
	beef = false,
	pork = false,
}
onready var unlocked_tech = {
	feed_humans = false,
	feed_animals = false,
	industrial = false,
	composting = false,
}

# Stores ingredients currently in stock
onready var i_stockpile = {
	"chicken": 0,
	"beef": 0,
	"pork": 0,
	"curry_powder": 0,
	"potato": 0,
	"spinach": 0,
	"eggplant": 0,
	"cheese": 0,
	"lemon": 0,
	"cucumber": 0,
	"coffee_mix": 0,
	"milk": 0,
}

# Game behavior
onready var min_day_len = 6
onready var max_day_len = 10
onready var min_custo = 5
onready var max_custo = 10

# Stores a temporary list of currently cookable food (aka what can be sold)
onready var cookable_food = {}

# Handlers
onready var waste_hndlr = $Waste
onready var ingred_hndlr = $Ingredient
onready var purchase_hndlr = $Purchase
onready var custo_hndlr = $Customer
onready var food_hndlr = $Food
onready var save_hndlr = $Save
onready var strat_hndlr = $Strategy
onready var day_hndlr = $DayCycle
onready var database_hndlr = $Database

# Entries
var sold_food: Array
var waste_managed: Array

# Day end
var stats_per_day: Dictionary

# Menu
onready var save_file_num = -1


func init_var():
	# Game variables
	money = 100.0
	edible_waste = 0.0
	inedible_waste = 0.0
	satisfaction = 0.0
	day = 0

	unlocked_ingredients = {
		chicken = true,
		beef = false,
		pork = false,
	}

	# Stores ingredients currently in stock
	i_stockpile = {
		"chicken": 0,
		"beef": 0,
		"pork": 0,
		"curry_powder": 0,
		"potato": 0,
		"spinach": 0,
		"eggplant": 0,
		"cheese": 0,
		"lemon": 0,
		"cucumber": 0,
		"coffee_mix": 0,
		"milk": 0,
	}

	# Game behavior
	min_day_len = 6
	max_day_len = 10
	min_custo = 5
	max_custo = 10

	# Stores a temporary list of currently cookable food (aka what can be sold)
	cookable_food = {}

	# Entries
	sold_food = []
	waste_managed = []


# Turns numbers into a Tycoon compatible format
func make_pretty_num(num: float, precission: int = 2) -> String:
	var unit: String
	if num > 1000000000:
		num /= 1000000000
		unit = "giga"
	elif num > 1000000:
		num /= 1000000
		unit = "M"
	elif num > 1000:
		num /= 1000
		unit = "K"
	else:
		unit = ""

	return str("%." + str(precission) + "f" + unit) % [num]


func get_str_money() -> String:
	return make_pretty_num(money)


func get_str_waste() -> String:
	return make_pretty_num(edible_waste + inedible_waste)


func get_str_satisfaction() -> String:
	return make_pretty_num(satisfaction)
