extends Node

export(Resource) var MEAL


func get_waste_performance(day):
	var waste_produced = float(
		(
			Game.database_hndlr.get_ewaste_produced(day - 1)
			+ Game.database_hndlr.get_iwaste_produced(day - 1)
		)
	)
	var waste_managed = float(Game.database_hndlr.get_waste_managed(day))

	if waste_managed == 0 or waste_produced == 0:
		return 0

	var waste_performance = (waste_managed / waste_produced) * 100

	return clamp(waste_performance, 0, 100)


func get_customer_performance(day):
	var day_stats = Game.stats_per_day[str(day)]

	var transactions_succeded_count = float(Game.transaction_receipts[str(day)].size())
	var transactions_total_count = float(
		(
			Game.transaction_receipts[str(day)].size()
			+ Game.database_hndlr.get_transactions_failed(day)
		)
	)

	if transactions_total_count == 0:
		return [0]

	var customer_performance = (transactions_succeded_count / transactions_total_count) * 100

	return [customer_performance, transactions_succeded_count, transactions_total_count]


func get_profit_performance(day):
	var day_stats = Game.stats_per_day[str(day)]

	var money_earned = float(Game.database_hndlr.get_money_earned(day))
	var money_expected = 0.0
	for i in day_stats.meals_prepared.keys():
		var quantity = day_stats.meals_prepared[i]
		match i:
			"chicken_curry":
				money_expected += quantity * MEAL.menu.chicken_curry["base_price"]
			"pork_curry":
				money_expected += quantity * MEAL.menu.pork_curry["base_price"]
			"beef_curry":
				money_expected += quantity * MEAL.menu.beef_curry["base_price"]
			"lemonade":
				money_expected += quantity * MEAL.menu.lemonade["base_price"]
			"coffee":
				money_expected += quantity * MEAL.menu.lemonade["base_price"]

	if money_expected == 0:
		return [0]

	var profit_performance = (money_earned / money_expected) * 100

	return [profit_performance, money_earned, money_expected]


func get_day_performance(day):
	var profit_performance = get_profit_performance(day)
	var customer_performance = get_customer_performance(day)
	var waste_performance = 420

	if day > 0:
		waste_performance = get_waste_performance(day)

	print("profit: %s" % str(profit_performance))
	print("customer: %s" % str(customer_performance))
	print("waste: %s" % str(waste_performance))

	return {
		"profit": profit_performance,
		"customer": customer_performance,
		"waste": waste_performance,
	}
