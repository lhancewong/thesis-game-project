extends Control

# Labels
onready var money_label = $VBoxContainer/Performance/VBoxContainer/Money
onready var customer_satisfaction_label = $VBoxContainer/Performance/VBoxContainer/CustomerSatisfaction
onready var food_waste_label = $VBoxContainer/Performance/VBoxContainer/FoodWaste

func _physics_process(delta):
    money_label.text = "Money: " + str(Game.money)
    customer_satisfaction_label.text = "Customer Satisfaction: " + str(Game.satisfaction)
    food_waste_label.text = "Food Waste: " + Game.waste_hndlr.get_waste()
    
