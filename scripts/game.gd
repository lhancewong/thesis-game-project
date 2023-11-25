extends Node

# Game variables
var money = 100.0
var edible_waste = 0.0
var inedible_waste = 0.0
var satisfaction = 0.0
var day = 0
var unlocked_ingredients = {
	chicken = true,
	beef = false,
	pork = false,
}

# Stores ingredients currently in stock
var i_stockpile = {
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
var min_day_len = 6
var max_day_len = 10
var min_custo = 5
var max_custo = 10

# Stores a temporary list of currently cookable food (aka what can be sold)
var cookable_food = {}

# Handlers
onready var waste_hndlr = $Waste
onready var ingred_hndlr = $Ingredient
onready var purchase_hndlr = $Purchase
onready var custo_hndlr = $Customer
onready var food_hndlr = $Food
onready var save_hndlr = $Save
onready var day_hndlr = $DayCycle
onready var database_hndlr = $Database

# Entries
var sold_food: Array
var waste_managed: Array

# Day end
var stats_per_day: Dictionary


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
	stats_per_day[day] = {
		meals_served = {pork_curry = 0, chicken_curry = 0, beef_curry = 0},
		ingreds_bought = {pork = 0, chicken = 0, beef = 0, curry_powder = 0},
		ingreds_consumed = {pork = 0, chicken = 0, beef = 0, curry_powder = 0},
		custos_served = {tourist = 0, regular = 0, local = 0},
		satis_gained = 0.0,
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
