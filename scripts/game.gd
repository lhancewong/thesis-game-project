extends Node

# Game variables
onready var money = 100.0
onready var edible_waste = 0.0
onready var inedible_waste = 0.0
onready var satisfaction = 0.0
onready var day = 0
onready var unlocked_ingredients = {
	chicken = true,
	beef = false,
	pork = false,
}
onready var store_level = 0
onready var skill_point = 4

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
	"coffee_mix": 0,
	"sugar": 0,
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
		"coffee_mix": 0,
		"sugar": 0,
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
	per_day_stats = []

	# Day end
	meals_served_per_day = []
	ingreds_bought_per_day = []
	ingreds_consumed_per_day = []
	custos_served_per_day = []
	satis_earned_per_day = []
	money_left_per_day = []
	money_spent_per_day = []
	money_earned_per_day = []
	e_waste_produced_per_day = []
	e_waste_managed_per_day = []
	e_waste_left_per_day = []
	i_waste_left_per_day = []
	i_waste_produced_per_day = []
	i_waste_managed_per_day = []

	save_file_num = -1


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


func init_daily_statistics():
	stats_per_day[str(day)] = {
		meals_served = {pork_curry = 0, chicken_curry = 0, beef_curry = 0},
		ingredients_bought = {pork = 0, chicken = 0, beef = 0, curry_powder = 0},
		ingredients_consumed = {pork = 0, chicken = 0, beef = 0, curry_powder = 0},
		customers_served = {tourist = 0, regular = 0, local = 0},
		money_earned_from_meals = {pork_curry = 0, chicken_curry = 0, beef_curry = 0},
		satisfaction_gained = 0.0,
		money_left = 0.0,
		money_spent = 0.0,
		money_earned = 0.0,
		ewaste_produced = 0.0,
		ewaste_managed = 0.0,
		ewaste_left = 0.0,
		iwaste_produced = 0.0,
		iwaste_managed = 0.0,
		iwaste_left = 0.0,
	}
