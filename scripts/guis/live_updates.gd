extends Control

# Labels
onready var money_label = $VBoxContainer/Performance/VBoxContainer/Money
onready var customer_satisfaction_label = $VBoxContainer/Performance/VBoxContainer/CustomerSatisfaction
onready var food_waste_label = $VBoxContainer/Performance/VBoxContainer/FoodWaste

func _physics_process(delta):
    money_label.text = "Money: " + Game.get_str_money()
    customer_satisfaction_label.text = "Customer Satisfaction: " + Game.get_str_satisfaction()
    food_waste_label.text = "Food Waste: " + Game.get_str_waste()
    
