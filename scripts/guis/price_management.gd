extends Control

var regex = RegEx.new()
var chicken_old_text = ""
var beef_old_text = ""
var pork_old_text = ""
var lemonade_old_text = ""
var coffee_old_text = ""

onready var chicken_meal = Game.food_hndlr.get_meal("chicken_curry")
onready var beef_meal = Game.food_hndlr.get_meal("beef_curry")
onready var pork_meal = Game.food_hndlr.get_meal("pork_curry")
onready var lemonade = Game.food_hndlr.get_meal("lemonade")
onready var coffee = Game.food_hndlr.get_meal("coffee")

onready var chicken_amount = Game.meal_prices["chicken_curry"]
onready var chicken_line_edit = $VBoxContainer/Meal/Chicken/HBoxContainer/LineEdit

onready var beef_amount = Game.meal_prices["beef_curry"]
onready var beef_line_edit = $VBoxContainer/Meal/Beef/HBoxContainer/LineEdit

onready var pork_amount = Game.meal_prices["pork_curry"]
onready var pork_line_edit = $VBoxContainer/Meal/Pork/HBoxContainer/LineEdit

onready var lemonade_amount = Game.meal_prices["lemonade"]
onready var lemonade_line_edit = $VBoxContainer/Meal/Lemonade/HBoxContainer/LineEdit

onready var coffee_amount = Game.meal_prices["coffee"]
onready var coffee_line_edit = $VBoxContainer/Meal/Coffee/HBoxContainer/LineEdit

onready var stock_chicken_price = $VBoxContainer/Stock/Chicken/Price/Amount
onready var stock_beef_price = $VBoxContainer/Stock/Beef/Price/Amount
onready var stock_pork_price = $VBoxContainer/Stock/Pork/Price/Amount
onready var stock_lemonade_price = $VBoxContainer/Stock/Lemonade/Price/Amount
onready var stock_coffee_price = $VBoxContainer/Stock/Coffee/Price/Amount


# Called when the node enters the scene tree for the first time.
func _ready():
	_update_labels()
	regex.compile("^[0-9]*$")
	chicken_line_edit.text = str(chicken_amount)
	pork_line_edit.text = str(pork_amount)
	beef_line_edit.text = str(beef_amount)
	lemonade_line_edit.text = str(lemonade_amount)
	coffee_line_edit.text = str(coffee_amount)


func _physics_process(delta):  # change to signals
	_update_labels()


func _update_labels():
	stock_chicken_price.text = str(Game.meal_prices["chicken_curry"])
	stock_beef_price.text = str(Game.meal_prices["beef_curry"])
	stock_pork_price.text = str(Game.meal_prices["pork_curry"])
	stock_lemonade_price.text = str(Game.meal_prices["lemonade"])
	stock_coffee_price.text = str(Game.meal_prices["coffee"])


func _on_ChickenUpdate_pressed():
	SoundHandler.button_click.play()
	Game.food_hndlr.set_meal_price("chicken_curry", chicken_amount)
	chicken_line_edit.text = str(chicken_amount)


func _on_Chicken_minus_pressed():
	SoundHandler.value_change.play()
	chicken_amount -= 1
	if chicken_amount < 0:
		chicken_amount = 0
	chicken_line_edit.text = str(chicken_amount)


func _on_Chicken_plus_pressed():
	SoundHandler.value_change.play()
	chicken_amount += 1
	chicken_line_edit.text = str(chicken_amount)


func _on_ChickenLine_text_changed(new_text):
	if regex.search(new_text):
		chicken_old_text = str(new_text)
		chicken_amount = int(new_text)
	else:
		chicken_line_edit.text = str(chicken_old_text)
		chicken_line_edit.set_cursor_position(chicken_line_edit.text.length())


func _on_BeefUpdate_pressed():
	SoundHandler.button_click.play()
	Game.food_hndlr.set_meal_price("beef_curry", beef_amount)
	beef_line_edit.text = str(beef_amount)


func _on_Beef_minus_pressed():
	SoundHandler.value_change.play()
	beef_amount -= 1
	if beef_amount < 0:
		beef_amount = 0
	beef_line_edit.text = str(beef_amount)


func _on_Beef_plus_pressed():
	SoundHandler.value_change.play()
	beef_amount += 1
	beef_line_edit.text = str(beef_amount)


func _on_BeefLine_text_changed(new_text):
	if regex.search(new_text):
		beef_old_text = str(new_text)
		beef_amount = int(new_text)
	else:
		beef_line_edit.text = beef_old_text
		beef_line_edit.set_cursor_position(beef_line_edit.text.length())


func _on_PorkUpdate_pressed():
	SoundHandler.button_click.play()
	Game.food_hndlr.set_meal_price("pork_curry", pork_amount)
	pork_line_edit.text = str(pork_amount)


func _on_Pork_minus_pressed():
	SoundHandler.value_change.play()
	pork_amount -= 1
	if pork_amount < 0:
		pork_amount = 0
	pork_line_edit.text = str(pork_amount)


func _on_Pork_plus_pressed():
	SoundHandler.value_change.play()
	pork_amount += 1
	pork_line_edit.text = str(pork_amount)


func _on_PorkLine_text_changed(new_text):
	if regex.search(new_text):
		pork_old_text = str(new_text)
		pork_amount = int(new_text)
	else:
		pork_line_edit.text = pork_old_text
		pork_line_edit.set_cursor_position(pork_line_edit.text.length())


func _on_LemonadeUpdate_pressed():
	SoundHandler.button_click.play()
	Game.food_hndlr.set_meal_price("lemonade", lemonade_amount)
	lemonade_line_edit.text = str(lemonade_amount)


func _on_Lemonade_minus_pressed():
	SoundHandler.value_change.play()
	lemonade_amount -= 1
	if lemonade_amount < 0:
		lemonade_amount = 0
	lemonade_line_edit.text = str(lemonade_amount)


func _on_Lemonade_plus_pressed():
	SoundHandler.value_change.play()
	lemonade_amount += 1
	lemonade_line_edit.text = str(lemonade_amount)


func _on_LemonadeLine_text_changed(new_text):
	if regex.search(new_text):
		lemonade_old_text = str(new_text)
		lemonade_amount = int(new_text)
	else:
		lemonade_line_edit.text = lemonade_old_text
		lemonade_line_edit.set_cursor_position(lemonade_line_edit.text.length())


func _on_CoffeeUpdate_pressed():
	SoundHandler.button_click.play()
	Game.food_hndlr.set_meal_price("coffee", coffee_amount)
	coffee_line_edit.text = str(coffee_amount)


func _on_Coffee_minus_pressed():
	SoundHandler.value_change.play()
	coffee_amount -= 1
	if coffee_amount < 0:
		coffee_amount = 0
	coffee_line_edit.text = str(coffee_amount)


func _on_Coffee_plus_pressed():
	SoundHandler.value_change.play()
	coffee_amount += 1
	coffee_line_edit.text = str(coffee_amount)


func _on_CoffeeLine_text_changed(new_text):
	if regex.search(new_text):
		coffee_old_text = str(new_text)
		coffee_amount = int(new_text)
	else:
		coffee_line_edit.text = coffee_old_text
		coffee_line_edit.set_cursor_position(coffee_line_edit.text.length())


func set_beef_visibility():
	$"%BeefBlock1".visible = false
	$"%BeefBlock2".visible = false
	$VBoxContainer/Stock/Beef.visible = true
	$VBoxContainer/Meal/Beef.visible = true


func set_pork_visibility():
	$"%PorkBlock1".visible = false
	$"%PorkBlock2".visible = false
	$VBoxContainer/Stock/Pork.visible = true
	$VBoxContainer/Meal/Pork.visible = true


func set_lemonade_visibility():
	$"%LemonBlock1".visible = false
	$"%LemonBlock2".visible = false
	$VBoxContainer/Stock/Lemonade.visible = true
	$VBoxContainer/Meal/Lemonade.visible = true


func set_coffee_visibility():
	$"%CoffeeBlock1".visible = false
	$"%CoffeeBlock2".visible = false
	$VBoxContainer/Stock/Coffee.visible = true
	$VBoxContainer/Meal/Coffee.visible = true
