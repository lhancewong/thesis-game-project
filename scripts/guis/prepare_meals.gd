extends Control

var regex = RegEx.new()
var chicken_old_text = ""
var beef_old_text = ""
var pork_old_text = ""
var lemonade_old_text = ""
var coffee_old_text = ""

onready var chicken = Game.ingred_hndlr.get_ingredient("Chicken")
onready var beef = Game.ingred_hndlr.get_ingredient("Beef")
onready var pork = Game.ingred_hndlr.get_ingredient("Pork")
onready var curry = Game.ingred_hndlr.get_ingredient("Curry Powder")
onready var lemon = Game.ingred_hndlr.get_ingredient("Lemon")
onready var cucumber = Game.ingred_hndlr.get_ingredient("Cucumber")
onready var coffee = Game.ingred_hndlr.get_ingredient("Coffee Mix")
onready var milk = Game.ingred_hndlr.get_ingredient("Milk")

onready var stock_chicken = $VBoxContainer/Stock/ChickenCurry/Chicken/Stock/Label
onready var stock_beef = $VBoxContainer/Stock/BeefCurry/Beef/Stock/Label
onready var stock_pork = $VBoxContainer/Stock/PorkCurry/Pork/Stock/Label
onready var stock_curry_one = $VBoxContainer/Stock/ChickenCurry/Curry/Stock/Label
onready var stock_curry_two = $VBoxContainer/Stock/BeefCurry/Curry/Stock/Label
onready var stock_curry_three = $VBoxContainer/Stock/PorkCurry/Curry/Stock/Label
onready var stock_lemon = $VBoxContainer/Stock/Lemonade/Lemon/Stock/Label
onready var stock_cucumber = $VBoxContainer/Stock/Lemonade/Cucumber/Stock/Label
onready var stock_coffee = $VBoxContainer/Stock/Coffee/CoffeeMix/Stock/Label
onready var stock_milk = $VBoxContainer/Stock/Coffee/Milk/Stock/Label


func _ready():
	_update_labels()


func _physics_process(delta):  # change to signals
	_update_labels()


func _update_labels():
	var stockpile = Game.i_stockpile

	stock_chicken.text = str(stockpile["chicken"])
	stock_beef.text = str(stockpile["beef"])
	stock_pork.text = str(stockpile["pork"])
	stock_curry_one.text = str(stockpile["curry_stock"])
	stock_curry_two.text = str(stockpile["curry_stock"])
	stock_curry_three.text = str(stockpile["curry_stock"])
	stock_lemon.text = str(stockpile["lemon"])
	stock_cucumber.text = str(stockpile["cucumber"])
	stock_coffee.text = str(stockpile["coffee_mix"])
	stock_milk.text = str(stockpile["milk"])


func set_beef_visibility():
	$VBoxContainer/Meal/BeefBlock.visible = false
	$VBoxContainer/Stock/BeefBlock.visible = false
	$VBoxContainer/Meal/Beef.visible = true
	$VBoxContainer/Stock/BeefCurry.visible = true


func set_pork_visibility():
	$VBoxContainer/Meal/PorkBlock.visible = false
	$VBoxContainer/Stock/PorkBlock.visible = false
	$VBoxContainer/Meal/Pork.visible = true
	$VBoxContainer/Stock/PorkCurry.visible = true


func set_lemonade_visibility():
	$VBoxContainer/Meal/LemonadeBlock.visible = false
	$VBoxContainer/Stock/LemonadeBlock.visible = false
	$VBoxContainer/Meal/Lemonade.visible = true
	$VBoxContainer/Stock/Lemonade.visible = true


func set_coffee_visibility():
	$VBoxContainer/Meal/CoffeeBlock.visible = false
	$VBoxContainer/Stock/CoffeeBlock.visible = false
	$VBoxContainer/Meal/Coffee.visible = true
	$VBoxContainer/Stock/Coffee.visible = true
