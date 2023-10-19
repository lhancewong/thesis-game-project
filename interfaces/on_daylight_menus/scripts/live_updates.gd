extends Control

# Labels
onready var money_label = $VBoxContainer/Performance/VBoxContainer/Money
onready var customer_satisfaction_label = $VBoxContainer/Performance/VBoxContainer/CustomerSatisfaction
onready var food_waste_label = $VBoxContainer/Performance/VBoxContainer/FoodWaste

# Resources
export(Resource) var resto
export(Resource) var management_handler

func _physics_process(delta):
	money_label.text = "Money: " + resto.get_money()
	customer_satisfaction_label.text = "Customer Satisfaction: " + resto.get_satisfaction()
	food_waste_label.text = "Food Waste: " + management_handler.get_waste()
	
