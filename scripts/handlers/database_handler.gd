extends Node


func get_waste_produced(day):
	if day == 0:
		return 0
	var day_stats = Game.stats_per_day[str(day)]
	var waste_produced = day_stats.ewaste_produced + day_stats.iwaste_produced
	return waste_produced


func get_customers_served(day):
	if day == 0:
		return 0
	var day_stats = Game.stats_per_day[str(day)]
	var customers_served: int = 0
	for amount in day_stats.customers_served.values():
		customers_served += amount
	return customers_served


func get_money_earned(day):
	if day == 0:
		return 0
	var day_stats = Game.stats_per_day[str(day)]
	var money_earned = day_stats.money_earned
	return money_earned


func get_money_spent(day):
	if day == 0:
		return 0
	var day_stats = Game.stats_per_day[str(day)]
	var money_spent = day_stats.money_spent
	return money_spent


func get_profit(day):
	if day == 0:
		return 0
	var day_stats = Game.stats_per_day[str(day)]
	var profit = day_stats.money_earned - day_stats.money_spent
	return profit


func get_money_earned_from_meal(type, day):
	if day == 0:
		return 0
	var day_stats = Game.stats_per_day[str(day)]
	var money_earned_from_meal = day_stats.money_earned_from_meals[str(type)]
	return money_earned_from_meal


func _on_Waste_ewaste_managed(amount):
	Game.stats_per_day[str(Game.day)].ewaste_managed += amount


func _on_Waste_ewaste_produced(amount):
	Game.stats_per_day[str(Game.day)].ewaste_produced += amount


func _on_Waste_iwaste_managed(amount):
	Game.stats_per_day[str(Game.day)].iwaste_managed += amount


func _on_Waste_iwaste_produced(amount):
	Game.stats_per_day[str(Game.day)].iwaste_produced += amount


func _on_Ingredient_ingred_bought(type, amount):
	Game.stats_per_day[str(Game.day)].ingredients_bought[type] += amount


func _on_Ingredient_ingred_consumed(type, amount):
	Game.stats_per_day[str(Game.day)].ingredients_consumed[type] += amount


func _on_Ingredient_money_spent(amount):
	Game.stats_per_day[str(Game.day)].money_spent += amount


func _on_Purchase_customer_served(type):
	Game.stats_per_day[str(Game.day)].customers_served[type] += 1


func _on_Purchase_meal_served(type, amount):
	Game.stats_per_day[str(Game.day)].meals_served[type] += 1
	Game.stats_per_day[str(Game.day)].money_earned_from_meals[type] += amount


func _on_Purchase_money_earned(amount):
	Game.stats_per_day[str(Game.day)].money_earned += amount


func _on_Purchase_satsifation_gained(amount):
	Game.stats_per_day[str(Game.day)].satisfaction_gained += amount


func _on_DayCycle_day_ended(money_left, ewaste_left, iwaste_left):
	Game.stats_per_day[str(Game.day)].money_left = money_left
	Game.stats_per_day[str(Game.day)].ewaste_left = ewaste_left
	Game.stats_per_day[str(Game.day)].iwaste_left = iwaste_left
