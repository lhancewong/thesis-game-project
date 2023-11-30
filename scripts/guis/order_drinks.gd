extends Control

var regex = RegEx.new()
var lemon_old_text = ""
var cucumber_old_text = ""
var coffee_old_text = ""
var milk_old_text = ""

onready var lemon_amount = 1
onready var lemon_line_edit = $VBoxContainer/Order/Lemon/HBoxContainer/LineEdit

onready var cucumber_amount = 1
onready var cucumber_line_edit = $VBoxContainer/Order/Cucumber/HBoxContainer/LineEdit

onready var coffee_amount = 1
onready var coffee_line_edit = $VBoxContainer/Order/Coffee/HBoxContainer/LineEdit

onready var milk_amount = 1
onready var milk_line_edit = $VBoxContainer/Order/Milk/HBoxContainer/LineEdit


onready var stock_lemon = $VBoxContainer/Storage/Lemon/Amount/Amount
onready var stock_cucumber = $VBoxContainer/Storage/Cucumber/Amount/Amount
onready var stock_coffee = $VBoxContainer/Storage/Coffee/Amount/Amount
onready var stock_milk = $VBoxContainer/Storage/Milk/Amount/Amount



# Called when the node enters the scene tree for the first time.
func _ready():
	_update_labels()
	regex.compile("^[0-9]*$")
	lemon_line_edit.text = str(lemon_amount)
	cucumber_line_edit.text = str(cucumber_amount)
	coffee_line_edit.text = str(coffee_amount)
	milk_line_edit.text = str(milk_amount)

func _physics_process(delta):  # change to signals
	_update_labels()


func _update_labels():
	var stockpile = Game.i_stockpile

	stock_lemon.text = str(stockpile["lemon"]) + " batches"
	stock_cucumber.text = str(stockpile["cucumber"]) + " batches"
	stock_coffee.text = str(stockpile["coffee_mix"]) + " batches"
	stock_milk.text = str(stockpile["milk"]) + " batches"


func _on_LemonBuy_pressed():
	Game.ingred_hndlr.buy_ingredients("lemon", lemon_amount)
	lemon_line_edit.text = str(lemon_amount)


func _on_Lemon_minus_pressed():
	lemon_amount -= 1
	if lemon_amount < 0:
		lemon_amount = 0
	lemon_line_edit.text = str(lemon_amount)


func _on_Lemon_plus_pressed():
	lemon_amount += 1
	lemon_line_edit.text = str(lemon_amount)


func _on_LemonLine_text_changed(new_text):
	if regex.search(new_text):
		lemon_old_text = str(new_text)
		lemon_amount = int(new_text)
	else:
		lemon_line_edit.text = str(lemon_old_text)
		lemon_line_edit.set_cursor_position(lemon_line_edit.text.length())


func _on_CucumberBuy_pressed():
	Game.ingred_hndlr.buy_ingredients("cucumber", cucumber_amount)
	cucumber_line_edit.text = str(cucumber_amount)


func _on_Cucumber_minus_pressed():
	cucumber_amount -= 1
	if cucumber_amount < 0:
		cucumber_amount = 0
	cucumber_line_edit.text = str(cucumber_amount)


func _on_Cucumber_plus_pressed():
	cucumber_amount += 1
	cucumber_line_edit.text = str(cucumber_amount)


func _on_CucumberLine_text_changed(new_text):
	if regex.search(new_text):
		cucumber_old_text = str(new_text)
		cucumber_amount = int(new_text)
	else:
		cucumber_line_edit.text = str(cucumber_old_text)
		cucumber_line_edit.set_cursor_position(cucumber_line_edit.text.length())


func _on_CoffeeBuy_pressed():
	Game.ingred_hndlr.buy_ingredients("coffee", coffee_amount)
	coffee_line_edit.text = str(coffee_amount)


func _on_Coffee_minus_pressed():
	coffee_amount -= 1
	if coffee_amount < 0:
		coffee_amount = 0
	coffee_line_edit.text = str(coffee_amount)


func _on_Coffee_plus_pressed():
	coffee_amount += 1
	coffee_line_edit.text = str(coffee_amount)


func _on_CoffeeLine_text_changed(new_text):
	if regex.search(new_text):
		coffee_old_text = str(new_text)
		coffee_amount = int(new_text)
	else:
		coffee_line_edit.text = coffee_old_text
		coffee_line_edit.set_cursor_position(coffee_line_edit.text.length())


func _on_MilkBuy_pressed():
	Game.ingred_hndlr.buy_ingredients("milk", milk_amount)
	milk_line_edit.text = str(milk_amount)


func _on_Milk_minus_pressed():
	milk_amount -= 1
	if milk_amount < 0:
		milk_amount = 0
	milk_line_edit.text = str(milk_amount)


func _on_Milk_plus_pressed():
	milk_amount += 1
	milk_line_edit.text = str(milk_amount)


func _on_MilkLine_text_changed(new_text):
	if regex.search(new_text):
		milk_old_text = str(new_text)
		milk_amount = int(new_text)
	else:
		milk_line_edit.text = milk_old_text
		milk_line_edit.set_cursor_position(milk_line_edit.text.length())
