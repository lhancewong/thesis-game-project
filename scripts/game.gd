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

func save():
    var save_dict = {
        "money": money,
        "edible_waste": edible_waste,
        "inedible_waste": inedible_waste,
        "satisfaction": satisfaction,
        "day": day,
        "min_day": min_day,
        "max_day": max_day,
        "min_custo": min_custo,
        "max_custo": max_custo,
        "i_stockpile": i_stockpile,
        "sold_food": sold_food,
        "waste_managed": waste_managed,
    }
    return save_dict

# Note: This can be called from anywhere inside the tree. This function is
# path independent.
# Go through everything in the persist category and ask them to return a
# dict of relevant variables.
func save_game(num):
    print('game save')
    var save_path = "user://savegame%s.save" % num
    var save_game = File.new()
    save_game.open(save_path, File.WRITE)
    # Store the save dictionary as a new line in the save file.
    save_game.store_line(to_json(save()))
    save_game.close()

# Note: This can be called from anywhere inside the tree. This function
# is path independent.
func load_game(num):
    print('game load')
    var save_path = "user://savegame%s.save" % num
    var save_game = File.new()
    if not save_game.file_exists(save_path):
        return # Error! We don't have a save to load.
    # Load the file line by line and process that dictionary to restore
    # the object it represents.
    save_game.open(save_path, File.READ)
    while save_game.get_position() < save_game.get_len():
        # Get the saved dictionary from the next line in the save file
        var save_data = parse_json(save_game.get_line())
        # Now we set the remaining variables.
        for i in save_data.keys():
            print(i)
            var data = save_data[i]
            match i:
                "money" : money = data
                "edible_waste" : edible_waste = data
                "inedible_waste" : inedible_waste = data
                "satisfaction" : satisfaction = data
                "day" : day = data
                "min_day" : min_day = data
                "max_day" : max_day = data
                "min_custo" : min_custo = data
                "max_custo" : max_custo = data
                "i_stockpile" : i_stockpile = data
                "sold_food" : sold_food = data
                "waste_managed" : waste_managed = data
    save_game.close()


func delete_save(num):
    var dir = Directory.new()
    var save_path = "user://savegame%s.save" % num
    dir.remove(save_path)
