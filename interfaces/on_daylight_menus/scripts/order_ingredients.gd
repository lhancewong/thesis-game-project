extends Control


# Resources
export(Resource) var ingredients

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
