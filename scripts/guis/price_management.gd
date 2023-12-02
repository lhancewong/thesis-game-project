extends Control

var regex = RegEx.new()
var chicken_old_text = ""
var beef_old_text = ""
var pork_old_text = ""
var lemonade_old_text = ""
var coffee_old_text = ""

onready var chicken_meal = Game.food_hndlr.get_food("chicken_curry")
onready var beef_meal = Game.food_hndlr.get_food("beef_curry")
onready var pork_meal = Game.food_hndlr.get_food("pork_curry")
onready var lemonade = Game.food_hndlr.get_food("lemonade")
onready var coffee = Game.food_hndlr.get_food("coffee")

onready var chicken_amount = chicken_meal.base_price
onready var chicken_line_edit = $VBoxContainer/Meal/Chicken/HBoxContainer/LineEdit

onready var beef_amount = beef_meal.base_price
onready var beef_line_edit = $VBoxContainer/Meal/Beef/HBoxContainer/LineEdit

onready var pork_amount = pork_meal.base_price
onready var pork_line_edit = $VBoxContainer/Meal/Pork/HBoxContainer/LineEdit

onready var lemon_amount = lemonade.base_price
onready var lemon_line_edit = $VBoxContainer/Meal/Lemon/HBoxContainer/LineEdit

onready var coffee_amount = coffee.base_price
onready var coffee_line_edit = $VBoxContainer/Meal/Coffee/HBoxContainer/LineEdit

onready var stock_chicken_price = $VBoxContainer/Stock/Chicken/Price/Amount
onready var stock_beef_price = $VBoxContainer/Stock/Beef/Price/Amount
onready var stock_pork_price = $VBoxContainer/Stock/Pork/Price/Amount
onready var stock_lemon_price = $VBoxContainer/Stock/Lemon/Price/Amount
onready var stock_coffee_price = $VBoxContainer/Stock/Coffee/Price/Amount


# Called when the node enters the scene tree for the first time.
func _ready():
	_update_labels()
	regex.compile("^[0-9]*$")
	chicken_line_edit.text = str(chicken_amount)
	pork_line_edit.text = str(pork_amount)
	beef_line_edit.text = str(beef_amount)
	lemon_line_edit.text = str(lemon_amount)
	coffee_line_edit.text = str(coffee_amount)
	Game.food_hndlr.unlock_meals()


func _physics_process(delta):  # change to signals
	_update_labels()


func _update_labels():
	var stockpile = Game.i_stockpile

	stock_chicken_price.text = str(chicken_meal.base_price)
	stock_beef_price.text = str(beef_meal.base_price)
	stock_pork_price.text = str(pork_meal.base_price)
	stock_lemon_price.text = str(lemonade.base_price)
	stock_coffee_price.text = str(coffee.base_price)


func _on_ChickenUpdate_pressed():
	Game.food_hndlr.set_meal_price("chicken_curry", chicken_amount)
	chicken_line_edit.text = str(chicken_amount)


func _on_Chicken_minus_pressed():
	chicken_amount -= 1
	if chicken_amount < 0:
		chicken_amount = 0
	chicken_line_edit.text = str(chicken_amount)


func _on_Chicken_plus_pressed():
	if chicken_amount < 100:
		chicken_amount += 1
	chicken_line_edit.text = str(chicken_amount)


func _on_ChickenLine_text_changed(new_text):
	if regex.search(new_text) and int(new_text) <= 100:
		chicken_old_text = str(new_text)
		chicken_amount = int(new_text)
	else:
		chicken_line_edit.text = str(chicken_old_text)
		chicken_line_edit.set_cursor_position(chicken_line_edit.text.length())


func _on_BeefUpdate_pressed():
	Game.food_hndlr.set_meal_price("beef_curry", beef_amount)
	beef_line_edit.text = str(beef_amount)


func _on_Beef_minus_pressed():
	beef_amount -= 1
	if beef_amount < 0:
		beef_amount = 0
	beef_line_edit.text = str(beef_amount)


func _on_Beef_plus_pressed():
	if beef_amount < 100:
		beef_amount += 1
	beef_line_edit.text = str(beef_amount)


func _on_BeefLine_text_changed(new_text):
	if regex.search(new_text) and int(new_text) <= 100:
		beef_old_text = str(new_text)
		beef_amount = int(new_text)
	else:
		beef_line_edit.text = beef_old_text
		beef_line_edit.set_cursor_position(beef_line_edit.text.length())


func _on_PorkUpdate_pressed():
	Game.food_hndlr.set_meal_price("pork_curry", pork_amount)
	pork_line_edit.text = str(pork_amount)


func _on_Pork_minus_pressed():
	pork_amount -= 1
	if pork_amount < 0:
		pork_amount = 0
	pork_line_edit.text = str(pork_amount)


func _on_Pork_plus_pressed():
	if pork_amount < 100:
		pork_amount += 1
	pork_line_edit.text = str(pork_amount)


func _on_PorkLine_text_changed(new_text):
	if regex.search(new_text) and int(new_text) <= 100:
		pork_old_text = str(new_text)
		pork_amount = int(new_text)
	else:
		pork_line_edit.text = pork_old_text
		pork_line_edit.set_cursor_position(pork_line_edit.text.length())
