extends Control

# Labels
onready var money_label = $VBoxContainer/Performance/VBoxContainer/Money
onready var customer_satisfaction_label = $VBoxContainer/Performance/VBoxContainer/CustomerSatisfaction
onready var food_waste_label = $VBoxContainer/Performance/VBoxContainer/FoodWaste

onready var stats = $VBoxContainer/FoodWaste/MarginContainer/HBoxContainer/ColorRect/Stats


func _ready():
	Game.day_hndlr.connect("day_ended", self, "_on_DayCycle_day_ended")


func _physics_process(delta):
	update_labels()


func update_labels():
	money_label.text = "Money: " + Game.get_str_money()
	customer_satisfaction_label.text = "Customer Satisfaction: " + Game.get_str_satisfaction()
	food_waste_label.text = "Food Waste: " + Game.get_str_waste()


func _on_DayCycle_day_ended():
	var day = Game.day
	var data = Game.stats_per_day[str(day)]
	var label_text = """Day %s Performance:
		Money Earned: %s
		Money Spent: %s
		Ingredients Bought: %s
		Waste Produced: %s
		Waste Managed: %s
		Customers Served: %s
		Failed Transactions: %s
		"""
	var data_array = [
		day,
		data.money_earned,
		data.money_spent,
		Game.database_hndlr.get_ingredients_bought(day),
		Game.make_pretty_num(Game.database_hndlr.get_waste_produced(day)),
		Game.make_pretty_num(Game.database_hndlr.get_waste_managed(day)),
		Game.database_hndlr.get_customers_served(day),
		Game.database_hndlr.get_transactions_failed(day),
	]
	stats.text = label_text % data_array
