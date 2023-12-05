extends Node

export(Resource) var MEAL

var money: float
var edible_waste: float
var inedible_waste: float
var satisfaction: float
var day: int

var min_day_len: int
var max_day_len: int
var min_custo: int
var max_custo: int

var store_level: int
var skill_points: int

var compost_stack: Array
var last_compost_day: int

var unlocked_tech: Dictionary
var unlocked_ingredients: Dictionary
var meal_prices: Dictionary
var i_stockpile: Dictionary
var cookable_food: Dictionary

var sold_food: Array
var waste_managed: Array
var stats_per_day: Dictionary

var save_file_num: int

onready var waste_hndlr = $Waste
onready var ingred_hndlr = $Ingredient
onready var purchase_hndlr = $Purchase
onready var custo_hndlr = $Customer
onready var food_hndlr = $Food
onready var save_hndlr = $Save
onready var strat_hndlr = $Strategy
onready var day_hndlr = $DayCycle
onready var database_hndlr = $Database
onready var buffs_hndlr = $Buffs


func _ready():
	init_game()


func init_game():
	money = 1000.0
	edible_waste = 0.0
	inedible_waste = 0.0
	satisfaction = 0.0
	day = 0

	min_day_len = 6
	max_day_len = 10
	min_custo = 5
	max_custo = 10

	store_level = 0
	skill_points = 0

	compost_stack = []
	last_compost_day = 0

	unlocked_ingredients = {
		chicken = true,
		beef = false,
		pork = false,
	}
	unlocked_tech = {
		composting = true,
		industrial = true,
		feed_animals = true,
		food_shelter = true,
	}
	meal_prices = {
		chicken_curry = MEAL.menu.chicken_curry.base_price,
		beef_curry = MEAL.menu.beef_curry.base_price,
		pork_curry = MEAL.menu.pork_curry.base_price,
		lemonade = MEAL.menu.lemonade.base_price,
		coffee = MEAL.menu.coffee.base_price,
	}
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

	cookable_food = {}
	sold_food = []
	waste_managed = []
	stats_per_day = {}

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
