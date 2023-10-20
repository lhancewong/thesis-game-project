extends Control

var regex = RegEx.new()
var chicken_old_text = ""
var beef_old_text = ""
var pork_old_text = ""
var curry_old_text = ""

# Resources
export(Resource) var ingredients
export(Resource) var restaurant
export(Resource) var order_manager

# Labels
onready var order_chicken_amount = 1
onready var order_chicken_label = $VBoxContainer/Order/Chicken/HBoxContainer/LineEdit

onready var order_beef_amount = 1
onready var order_beef_label = $VBoxContainer/Order/Beef/HBoxContainer/LineEdit

onready var order_pork_amount = 1
onready var order_pork_label = $VBoxContainer/Order/Pork/HBoxContainer/LineEdit

onready var order_curry_amount = 1
onready var order_curry_label = $VBoxContainer/Order/CurryStock/HBoxContainer/LineEdit

onready var stock_chicken = $VBoxContainer/Storage/Chicken/Amount/Amount
onready var stock_beef = $VBoxContainer/Storage/Beef/Amount/Amount
onready var stock_pork = $VBoxContainer/Storage/Pork/Amount/Amount
onready var stock_curry = $VBoxContainer/Storage/CurryStock/Amount/Amount


# Called when the node enters the scene tree for the first time.
func _ready():
	_update_labels()
	regex.compile("^[0-9]*$")


func _physics_process(delta):
	_update_labels()


func _update_labels():
	var stockpile = restaurant.get_stockpile()
	
	stock_chicken.text = str(stockpile["chicken"]) + " batches"
	stock_beef.text = str(stockpile["beef"]) + " batches"
	stock_pork.text = str(stockpile["pork"]) + " batches"
	stock_curry.text = str(stockpile["curry_powder"]) + " batches"


func _on_ChickenBuy_pressed():
	order_manager.chicken_buy()


func _on_Chicken_minus_pressed():
	$VBoxContainer/Order/Chicken/HBoxContainer/LineEdit.text = order_manager.chicken_minus()


func _on_Chicken_plus_pressed():
	$VBoxContainer/Order/Chicken/HBoxContainer/LineEdit.text = order_manager.chicken_plus()


func _on_ChickenLine_text_changed(new_text):
	if regex.search(new_text):
		chicken_old_text = str(new_text)
		order_manager.chicken_setAmount(int(new_text))
	else:
		$VBoxContainer/Order/Chicken/HBoxContainer/LineEdit.text = str(chicken_old_text)
		$VBoxContainer/Order/Chicken/HBoxContainer/LineEdit.set_cursor_position($VBoxContainer/Order/Chicken/HBoxContainer/LineEdit.text.length())



func _on_BeefBuy_pressed():
	order_manager.beef_buy()


func _on_Beef_minus_pressed():
	$VBoxContainer/Order/Beef/HBoxContainer/LineEdit.text = order_manager.beef_minus()


func _on_Beef_plus_pressed():
	$VBoxContainer/Order/Beef/HBoxContainer/LineEdit.text = order_manager.beef_plus()


func _on_BeefLine_text_changed(new_text):
	if regex.search(new_text):
		beef_old_text = str(new_text)
		order_manager.beef_setAmount(int(new_text))
	else:
		$VBoxContainer/Order/Beef/HBoxContainer/LineEdit.text = beef_old_text
		$VBoxContainer/Order/Beef/HBoxContainer/LineEdit.set_cursor_position($VBoxContainer/Order/Beef/HBoxContainer/LineEdit.text.length())


func _on_PorkBuy_pressed():
	order_manager.pork_buy()


func _on_Pork_minus_pressed():
	$VBoxContainer/Order/Pork/HBoxContainer/LineEdit.text = order_manager.pork_minus()


func _on_Pork_plus_pressed():
	$VBoxContainer/Order/Pork/HBoxContainer/LineEdit.text = order_manager.pork_plus()


func _on_PorkLine_text_changed(new_text):
	if regex.search(new_text):
		pork_old_text = str(new_text)
		order_manager.pork_setAmount(int(new_text))
	else:
		$VBoxContainer/Order/Pork/HBoxContainer/LineEdit.text = pork_old_text
		$VBoxContainer/Order/Pork/HBoxContainer/LineEdit.set_cursor_position($VBoxContainer/Order/Pork/HBoxContainer/LineEdit.text.length())


func _on_CurryBuy_pressed():
	order_manager.curry_buy()

func _on_Curry_minus_pressed():
	$VBoxContainer/Order/CurryStock/HBoxContainer/LineEdit.text = order_manager.curry_minus()

func _on_Curry_plus_pressed():
	$VBoxContainer/Order/CurryStock/HBoxContainer/LineEdit.text = order_manager.curry_plus()


func _on_CurryLine_text_changed(new_text):
	if regex.search(new_text):
		curry_old_text = str(new_text)
		order_manager.curry_setAmount(int(new_text))
	else:
		$VBoxContainer/Order/CurryStock/HBoxContainer/LineEdit.text = curry_old_text
		$VBoxContainer/Order/CurryStock/HBoxContainer/LineEdit.set_cursor_position($VBoxContainer/Order/CurryStock/HBoxContainer/LineEdit.text.length())
