extends Node

# Game variables
var money = 100.0
var edible_waste = 0.0
var inedible_waste = 0.0
var satisfaction = 0.0
var day = 0

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
var min_day = 6
var max_day = 10
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

# Entries
var sold_food: Array
var waste_managed: Array

# Turns numbers into a Tycoon compatible format
func make_pretty_num( num:float, precission:int=2  ) -> String:
    var unit:String
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
    
    return str("%."+str(precission)+"f"+unit) % [num]

func get_str_money() -> String:
    return make_pretty_num(money)

func get_str_waste() -> String:
    return make_pretty_num(edible_waste + inedible_waste)

func get_str_satisfaction() -> String:
    return make_pretty_num(satisfaction)
