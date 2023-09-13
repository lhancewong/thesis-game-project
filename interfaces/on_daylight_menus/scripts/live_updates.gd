extends Control

# Labels
onready var money_label = $VBoxContainer/Performance/VBoxContainer/Money
onready var cust_stfcn_label = $VBoxContainer/Performance/VBoxContainer/CustomerSatisfaction
onready var food_waste_label = $VBoxContainer/Performance/VBoxContainer/FoodWaste

# Resources
export(Resource) var resto

func _physics_process(delta):
	# money_label.text = resto.money
	pass
