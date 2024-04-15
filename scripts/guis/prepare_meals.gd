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

onready var chicken_curry_amount = 1
onready var chicken_curry_line_edit = $VBoxContainer/Meal/Chicken/HBoxContainer/LineEdit

onready var beef_curry_amount = 1
onready var beef_curry_line_edit = $VBoxContainer/Meal/Beef/HBoxContainer/LineEdit

onready var pork_curry_amount = 1
onready var pork_curry_line_edit = $VBoxContainer/Meal/Pork/HBoxContainer/LineEdit

onready var coffee_amount = 1
onready var coffee_line_edit = $VBoxContainer/Meal/Coffee/HBoxContainer/LineEdit

onready var lemonade_amount = 1
onready var lemonade_line_edit = $VBoxContainer/Meal/Lemonade/HBoxContainer/LineEdit


func _ready():
	_update_labels()
	regex.compile("^[0-9]*$")
	chicken_curry_line_edit.text = str(chicken_curry_amount)
	pork_curry_line_edit.text = str(pork_curry_amount)
	beef_curry_line_edit.text = str(beef_curry_amount)
	lemonade_line_edit.text = str(lemonade_amount)
	coffee_line_edit.text = str(coffee_amount)


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


func _on_ChickenPrepare_pressed():
	Game.food_hndlr.pre_prepare_meal("chicken_curry", chicken_curry_amount)


func _on_Chicken_plus_pressed():
	SoundHandler.value_change.play()
	chicken_curry_amount += 1
	chicken_curry_line_edit.text = str(chicken_curry_amount)


func _on_Chicken_minus_pressed():
	SoundHandler.value_change.play()
	chicken_curry_amount -= 1
	if chicken_curry_amount < 0:
		chicken_curry_amount = 0
	chicken_curry_line_edit.text = str(chicken_curry_amount)


func _on_ChickenLineEdit_text_changed(new_text):
	if regex.search(new_text):
		chicken_old_text = str(new_text)
		chicken_curry_amount = int(new_text)
	else:
		chicken_curry_line_edit.text = str(chicken_old_text)
		chicken_curry_line_edit.set_cursor_position(chicken_curry_line_edit.text.length())


func _on_Beef_Minus_pressed():
	SoundHandler.value_change.play()
	beef_curry_amount -= 1
	if beef_curry_amount < 0:
		beef_curry_amount = 0
	beef_curry_line_edit.text = str(beef_curry_amount)


func _on_Beef_Plus_pressed():
	SoundHandler.value_change.play()
	beef_curry_amount += 1
	beef_curry_line_edit.text = str(beef_curry_amount)


func _on_BeefPrepare_pressed():
	Game.food_hndlr.pre_prepare_meal("beef_curry", beef_curry_amount)


func _on_BeefLineEdit_text_changed(new_text):
	if regex.search(new_text):
		beef_old_text = str(new_text)
		beef_curry_amount = int(new_text)
	else:
		beef_curry_line_edit.text = beef_old_text
		beef_curry_line_edit.set_cursor_position(beef_curry_line_edit.text.length())


func _on_Pork_Minus_pressed():
	SoundHandler.value_change.play()
	pork_curry_amount -= 1
	if pork_curry_amount < 0:
		pork_curry_amount = 0
	pork_curry_line_edit.text = str(pork_curry_amount)


func _on_Pork_Plus_pressed():
	SoundHandler.value_change.play()
	pork_curry_amount += 1
	pork_curry_line_edit.text = str(pork_curry_amount)


func _on_PorkPrepare_pressed():
	Game.food_hndlr.pre_prepare_meal("pork_curry", pork_curry_amount)


func _on_PorkLineEdit_text_changed(new_text):
	if regex.search(new_text):
		pork_old_text = str(new_text)
		pork_curry_amount = int(new_text)
	else:
		pork_curry_line_edit.text = pork_old_text
		pork_curry_line_edit.set_cursor_position(pork_curry_line_edit.text.length())


func _on_Coffee_Minus_pressed():
	SoundHandler.value_change.play()
	coffee_amount -= 1
	if coffee_amount < 0:
		coffee_amount = 0
	coffee_line_edit.text = str(coffee_amount)


func _on_Coffee_Plus_pressed():
	SoundHandler.value_change.play()
	coffee_amount += 1
	coffee_line_edit.text = str(coffee_amount)


func _on_CoffeePrepare_pressed():
	Game.food_hndlr.pre_prepare_meal("coffee", coffee_amount)


func _on_CoffeeLineEdit_text_changed(new_text):
	if regex.search(new_text):
		coffee_old_text = str(new_text)
		coffee_amount = int(new_text)
	else:
		coffee_line_edit.text = str(coffee_old_text)
		coffee_line_edit.set_cursor_position(coffee_line_edit.text.length())


func _on_Lemonade_Minus_pressed():
	SoundHandler.value_change.play()
	lemonade_amount -= 1
	if lemonade_amount < 0:
		lemonade_amount = 0
	lemonade_line_edit.text = str(lemonade_amount)


func _on_Lemonade_Plus_pressed():
	SoundHandler.value_change.play()
	lemonade_amount += 1
	lemonade_line_edit.text = str(lemonade_amount)


func _on_LemonadePrepare_pressed():
	Game.food_hndlr.pre_prepare_meal("lemonade", lemonade_amount)


func _on_LemonadeLineEdit_text_changed(new_text):
	if regex.search(new_text):
		lemonade_old_text = str(new_text)
		lemonade_amount = int(new_text)
	else:
		lemonade_line_edit.text = str(lemonade_old_text)
		lemonade_line_edit.set_cursor_position(lemonade_line_edit.text.length())
