extends Node


func get_ingredients_bought(day):
	var day_stats = Game.stats_per_day[str(day)]
	var ingredient_bought: int = 0
	for amount in day_stats.ingredients_bought.values():
		ingredient_bought += amount
	return ingredient_bought


func get_ewaste_produced(day):
	var day_stats = Game.stats_per_day[str(day)]
	var waste_produced = day_stats.ewaste_produced
	return waste_produced


func get_iwaste_produced(day):
	var day_stats = Game.stats_per_day[str(day)]
	var waste_produced = day_stats.iwaste_produced
	return waste_produced


func get_waste_managed(day):
	var day_stats = Game.stats_per_day[str(day)]
	var waste_managed = day_stats.ewaste_managed + day_stats.iwaste_managed
	return waste_managed


func get_customers_served(day):
	var day_stats = Game.stats_per_day[str(day)]
	var customers_served: int = 0
	for amount in day_stats.customers_served.values():
		customers_served += amount
	return customers_served


func get_money_earned(day):
	var day_stats = Game.stats_per_day[str(day)]
	var money_earned = day_stats.money_earned
	return money_earned


func get_money_spent(day):
	var day_stats = Game.stats_per_day[str(day)]
	var money_spent = day_stats.money_spent
	return money_spent


func get_profit(day):
	var day_stats = Game.stats_per_day[str(day)]
	var profit = day_stats.money_earned - day_stats.money_spent
	return profit


func get_money_earned_from_meal(type, day):
	var day_stats = Game.stats_per_day[str(day)]
	var money_earned_from_meal = day_stats.money_earned_from_meals[str(type)]
	return money_earned_from_meal


func get_transactions_failed(day):
	var day_stats = Game.stats_per_day[str(day)]
	var transactions_failed: int = 0
	for data in day_stats.transactions_failed.values():
		transactions_failed += data[1]
	return transactions_failed


func _on_Waste_ewaste_produced(amount):
	Game.stats_per_day[str(Game.day)].ewaste_produced += amount
	print("ewaste " + str(amount))


func _on_Waste_ewaste_managed(amount):
	Game.stats_per_day[str(Game.day)].ewaste_managed += amount


func _on_Waste_iwaste_managed(amount):
	Game.stats_per_day[str(Game.day)].iwaste_managed += amount


func _on_Ingredient_ingred_bought(type, amount):
	Game.stats_per_day[str(Game.day)].ingredients_bought[type] += amount


func _on_Ingredient_ingred_consumed(type, amount):
	Game.stats_per_day[str(Game.day)].ingredients_consumed[type] += amount


func _on_Ingredient_money_spent(amount):
	Game.stats_per_day[str(Game.day)].money_spent += amount


func _on_DayCycle_stats_leftover(money_left, ewaste_left, iwaste_left, meals_leftover):
	Game.stats_per_day[str(Game.day)].money_left = money_left
	Game.stats_per_day[str(Game.day)].ewaste_left = ewaste_left
	Game.stats_per_day[str(Game.day)].iwaste_left = iwaste_left

	for meal in meals_leftover:
		Game.stats_per_day[str(Game.day)].meals_leftover[meal] == meals_leftover[meal]


func _on_Purchase_transaction_failed(type):
	Game.stats_per_day[str(Game.day)].transactions_failed[type][1] += 1


func _on_Purchase_transaction_succeded(meal, customer, payment, iwaste, satisfaction):
	var day = str(Game.day)
	var receipt = {
		customer = customer,
		iwaste = iwaste,
		meal_type = meal,
		payment = payment,
		satisfaction = satisfaction,
	}

	Game.stats_per_day[day].meals_served[meal] += 1
	Game.stats_per_day[day].money_earned_from_meals[meal] += payment
	Game.stats_per_day[day].customers_served[customer] += 1
	Game.stats_per_day[day].satisfaction_gained[customer] += satisfaction

	Game.stats_per_day[day].money_earned += payment
	Game.stats_per_day[day].iwaste_produced += iwaste

	Game.transaction_receipts[day].append(receipt)


func _on_Waste_strategy_used(strategy, ewaste, iwaste):
	var receipt = {
		ewaste = ewaste,
		iwaste = iwaste,
		strategy = strategy,
	}
	Game.strategy_receipts[str(Game.day)].append(receipt)
