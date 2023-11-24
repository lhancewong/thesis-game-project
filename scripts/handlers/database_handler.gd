extends Node


func _on_Waste_ewaste_managed(amount):
	Game.stats_per_day[Game.day].ewaste_managed += amount


func _on_Waste_ewaste_produced(amount):
	Game.stats_per_day[Game.day].ewaste_produced += amount


func _on_Waste_iwaste_managed(amount):
	Game.stats_per_day[Game.day].iwaste_managed += amount


func _on_Waste_iwaste_produced(amount):
	Game.stats_per_day[Game.day].iwaste_produced += amount


func _on_Ingredient_ingred_bought(type, amount):
	Game.stats_per_day[Game.day].ingreds_bought[type] += amount


func _on_Ingredient_ingred_consumed(type, amount):
	Game.stats_per_day[Game.day].ingreds_consumed[type] += amount


func _on_Ingredient_money_spent(amount):
	Game.stats_per_day[Game.day].money_spent += amount


func _on_Purchase_customer_served(type):
	Game.stats_per_day[Game.day].custos_served[type] += 1


func _on_Purchase_meal_served(type):
	Game.stats_per_day[Game.day].meals_served[type] += 1


func _on_Purchase_money_earned(amount):
	Game.stats_per_day[Game.day].money_earned += amount


func _on_Purchase_satsifation_gained(amount):
	Game.stats_per_day[Game.day].satis_gained += amount


func _on_DayCycle_day_ended(money_left, ewaste_left, iwaste_left):
	Game.stats_per_day[Game.day].money_left = money_left
	Game.stats_per_day[Game.day].ewaste_left = ewaste_left
	Game.stats_per_day[Game.day].iwaste_left = iwaste_left
