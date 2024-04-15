extends Control

var regex = RegEx.new()
var chicken_old_text = ""
var beef_old_text = ""
var pork_old_text = ""
var curry_old_text = ""
var lemon_old_text = ""
var cucumber_old_text = ""
var coffee_old_text = ""
var milk_old_text = ""

onready var chicken = Game.ingred_hndlr.get_ingredient("Chicken")
onready var beef = Game.ingred_hndlr.get_ingredient("Beef")
onready var pork = Game.ingred_hndlr.get_ingredient("Pork")
onready var curry = Game.ingred_hndlr.get_ingredient("Curry Powder")
onready var lemon = Game.ingred_hndlr.get_ingredient("Lemon")
onready var cucumber = Game.ingred_hndlr.get_ingredient("Cucumber")
onready var coffee = Game.ingred_hndlr.get_ingredient("Coffee Mix")
onready var milk = Game.ingred_hndlr.get_ingredient("Milk")

onready var chicken_amount = 1
onready var chicken_line_edit = $"%ChickenOrder/HBoxContainer/LineEdit"

onready var beef_amount = 1
onready var beef_line_edit = $"%BeefOrder/HBoxContainer/LineEdit"

onready var pork_amount = 1
onready var pork_line_edit = $"%PorkOrder/HBoxContainer/LineEdit"

onready var curry_amount = 1
onready var curry_line_edit = $"%CurryOrder/HBoxContainer/LineEdit"

onready var lemon_amount = 1
onready var lemon_line_edit = $"%LemonOrder/HBoxContainer/LineEdit"

onready var cucumber_amount = 1
onready var cucumber_line_edit = $"%CucumberOrder/HBoxContainer/LineEdit"

onready var coffee_amount = 1
onready var coffee_line_edit = $"%CoffeeOrder/HBoxContainer/LineEdit"

onready var milk_amount = 1
onready var milk_line_edit = $"%MilkOrder/HBoxContainer/LineEdit"

onready var stock_chicken = $"%ChickenOrder/Price/Amount"
onready var stock_beef = $"%BeefOrder/Price/Amount"
onready var stock_pork = $"%PorkOrder/Price/Amount"
onready var stock_curry = $"%CurryOrder/Price/Amount"
onready var stock_lemon = $"%LemonOrder/Price/Amount"
onready var stock_cucumber = $"%CucumberOrder/Price/Amount"
onready var stock_coffee = $"%CoffeeOrder/Price/Amount"
onready var stock_milk = $"%MilkOrder/Price/Amount"


func _ready():
	_update_labels()
	regex.compile("^[0-9]*$")
	chicken_line_edit.text = str(chicken_amount)
	pork_line_edit.text = str(pork_amount)
	beef_line_edit.text = str(beef_amount)
	curry_line_edit.text = str(curry_amount)
	lemon_line_edit.text = str(lemon_amount)
	cucumber_line_edit.text = str(cucumber_amount)
	coffee_line_edit.text = str(coffee_amount)
	milk_line_edit.text = str(milk_amount)

	Game.ingred_hndlr.check_unlocked_ingredients()


func _physics_process(delta):  # change to signals
	_update_labels()


func _update_labels():
	stock_chicken.text = "₱ " + str(chicken.price * chicken_amount)
	stock_beef.text = "₱ " + str(beef.price * beef_amount)
	stock_pork.text = "₱ " + str(pork.price * pork_amount)
	stock_curry.text = "₱ " + str(curry.price * curry_amount)
	stock_lemon.text = "₱ " + str(lemon.price * lemon_amount)
	stock_cucumber.text = "₱ " + str(cucumber.price * cucumber_amount)
	stock_coffee.text = "₱ " + str(coffee.price * coffee_amount)
	stock_milk.text = "₱ " + str(milk.price * milk_amount)


func amnt_minus(amnt):
	if amnt == 0:
		return "0"
	amnt -= 1
	return amnt


func _on_ChickenBuy_pressed():
	Game.ingred_hndlr.buy_ingredients("Chicken", chicken_amount)
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


func _on_BeefBuy_pressed():
	Game.ingred_hndlr.buy_ingredients("Beef", beef_amount)
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


func _on_PorkBuy_pressed():
	Game.ingred_hndlr.buy_ingredients("Pork", pork_amount)
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


func _on_CurryBuy_pressed():
	Game.ingred_hndlr.buy_ingredients("Curry Powder", curry_amount)
	curry_line_edit.text = str(curry_amount)


func _on_Curry_minus_pressed():
	SoundHandler.value_change.play()
	curry_amount -= 1
	if curry_amount < 0:
		curry_amount = 0
	curry_line_edit.text = str(curry_amount)


func _on_Curry_plus_pressed():
	SoundHandler.value_change.play()
	curry_amount += 1
	curry_line_edit.text = str(curry_amount)


func _on_CurryLine_text_changed(new_text):
	if regex.search(new_text):
		curry_old_text = str(new_text)
		curry_amount = int(new_text)
	else:
		curry_line_edit.text = curry_old_text
		curry_line_edit.set_cursor_position(curry_line_edit.text.length())


func _on_LemonBuy_pressed():
	Game.ingred_hndlr.buy_ingredients("Lemon", lemon_amount)
	lemon_line_edit.text = str(lemon_amount)


func _on_Lemon_minus_pressed():
	SoundHandler.value_change.play()
	lemon_amount -= 1
	if lemon_amount < 0:
		lemon_amount = 0
	lemon_line_edit.text = str(lemon_amount)


func _on_Lemon_plus_pressed():
	SoundHandler.value_change.play()
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
	Game.ingred_hndlr.buy_ingredients("Cucumber", cucumber_amount)
	cucumber_line_edit.text = str(cucumber_amount)


func _on_Cucumber_minus_pressed():
	SoundHandler.value_change.play()
	cucumber_amount -= 1
	if cucumber_amount < 0:
		cucumber_amount = 0
	cucumber_line_edit.text = str(cucumber_amount)


func _on_Cucumber_plus_pressed():
	SoundHandler.value_change.play()
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
	Game.ingred_hndlr.buy_ingredients("Coffee Mix", coffee_amount)
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


func _on_MilkBuy_pressed():
	Game.ingred_hndlr.buy_ingredients("Milk", milk_amount)
	milk_line_edit.text = str(milk_amount)


func _on_Milk_minus_pressed():
	SoundHandler.value_change.play()
	milk_amount -= 1
	if milk_amount < 0:
		milk_amount = 0
	milk_line_edit.text = str(milk_amount)


func _on_Milk_plus_pressed():
	SoundHandler.value_change.play()
	milk_amount += 1
	milk_line_edit.text = str(milk_amount)


func _on_MilkLine_text_changed(new_text):
	if regex.search(new_text):
		milk_old_text = str(new_text)
		milk_amount = int(new_text)
	else:
		milk_line_edit.text = milk_old_text
		milk_line_edit.set_cursor_position(milk_line_edit.text.length())


func set_beef_visibility():
	$"%BeefBlock".visible = false
	$"%BeefOrder".visible = true


func set_pork_visibility():
	$"%PorkBlock".visible = false
	$"%PorkOrder".visible = true


func set_lemonade_visibility():
	$"%LemonBlock".visible = false
	$"%CucumberBlock".visible = false
	$"%LemonOrder".visible = true
	$"%CucumberOrder".visible = true


func set_coffee_visibility():
	$"%CoffeeBlock".visible = false
	$"%MilkBlock".visible = false
	$"%CoffeeOrder".visible = true
	$"%MilkOrder".visible = true
