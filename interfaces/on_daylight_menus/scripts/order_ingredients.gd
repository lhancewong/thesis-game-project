extends Control


# Resources
export(Resource) var ingredients
export(Resource) var restaurant

# Labels
onready var order_chicken = $VBoxContainer/Order/Chicken/Amount/Amount
onready var order_beef = $VBoxContainer/Order/Beef/Amount/Amount
onready var order_pork = $VBoxContainer/Order/Pork/Amount/Amount
onready var order_curry = $VBoxContainer/Order/CurryStock/Amount/Amount

onready var stock_chicken = $VBoxContainer/Storage/Chicken/Amount/Amount
onready var stock_beef = $VBoxContainer/Storage/Beef/Amount/Amount
onready var stock_pork = $VBoxContainer/Storage/Pork/Amount/Amount
onready var stock_curry = $VBoxContainer/Storage/CurryStock/Amount/Amount


# Called when the node enters the scene tree for the first time.
func _ready():
	_update_labels()


func _physics_process(delta):
	_update_labels()


func _update_labels():
	var stockpile = ingredients.get_stockpile()
	
	stock_chicken.text = str(stockpile["chicken"]) + " batches"
	stock_beef.text = str(stockpile["beef"]) + " batches"
	stock_pork.text = str(stockpile["pork"]) + " batches"
	stock_curry.text = str(stockpile["curry_powder"]) + " batches"


func _on_ChickenSlider_value_changed(value):
	order_chicken.text = "Amount: " + str(value)


func _on_BeefSlider_value_changed(value):
	order_beef.text = "Amount: " + str(value)


func _on_PorkSlider_value_changed(value):
	order_pork.text = "Amount: " + str(value)


func _on_CurrySlider_value_changed(value):
	order_curry.text = "Amount: " + str(value)


func _on_ChickenBuy_pressed():
	var price = ingredients.buy_ingredients(0, int(order_chicken.text))
	restaurant.money -= price

func _on_BeefBuy_pressed():
	var price = ingredients.buy_ingredients(1, int(order_beef.text))
	restaurant.money -= price

func _on_PorkBuy_pressed():
	var price = ingredients.buy_ingredients(2, int(order_pork.text))
	restaurant.money -= price

func _on_CurryBuy_pressed():
	var price = ingredients.buy_ingredients(3, int(order_curry.text))
	restaurant.money -= price
