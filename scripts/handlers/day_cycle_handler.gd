extends Node

var game_console
var king_laugh_sprite
var king_cry_sprite
var npc_spawner

signal day_ended
signal stats_leftover(money_left, ewaste_left, iwaste_left, meals_left)


func init_daylight_main():
	init_daily_statistics()
	$"../Ingredient".receive_ingredients_ordered()
	$"../Ingredient".check_unlocked_ingredients()
	$"../Strategy".check_store_level()
	$"../Strategy".load_unlocked_strats()


func init_daily_statistics():
	Game.strategy_receipts[str(Game.day)] = []
	Game.transaction_receipts[str(Game.day)] = []
	Game.stats_per_day[str(Game.day)] = {
		ingredient_costed = {
			pork = 0,
			chicken = 0,
			beef = 0,
			curry_stock = 0,
			lemon = 0,
			cucumber = 0,
			coffee_mix = 0,
			milk = 0,
		},
		meals_served = {
			pork_curry = 0,
			chicken_curry = 0,
			beef_curry = 0,
			lemonade = 0,
			coffee = 0,
		},
		ingredients_bought = {
			pork = 0,
			chicken = 0,
			beef = 0,
			curry_stock = 0,
			lemon = 0,
			cucumber = 0,
			coffee_mix = 0,
			milk = 0,
		},
		ingredients_consumed = {
			pork = 0,
			chicken = 0,
			beef = 0,
			curry_stock = 0,
			lemon = 0,
			cucumber = 0,
			coffee_mix = 0,
			milk = 0,
		},
		money_earned_from_meals = {
			pork_curry = 0,
			chicken_curry = 0,
			beef_curry = 0,
			lemonade = 0,
			coffee = 0,
		},
		transactions_failed = {
			pork_curry = [Game.meal_prices["pork_curry"], 0],  # [current_price, times_failed]
			chicken_curry = [Game.meal_prices["chicken_curry"], 0],
			beef_curry = [Game.meal_prices["beef_curry"], 0],
			lemonade = [Game.meal_prices["lemonade"], 0],
			coffee = [Game.meal_prices["coffee"], 0],
			no_meal = [0, 0],
		},
		customers_served = {
			tourist = 0,
			regular = 0,
			local = 0,
		},
		satisfaction_gained = {
			tourist = 0,
			regular = 0,
			local = 0,
		},
		meals_leftover = {
			pork_curry = 0,
			chicken_curry = 0,
			beef_curry = 0,
			lemonade = 0,
			coffee = 0,
		},
		money_left = 0,
		money_earned = 0,
		money_spent = 0,
		ewaste_produced = 0,
		ewaste_managed = 0,
		iwaste_produced = 0,
		iwaste_managed = 0,
	}

	Game.ingredients_ordered = {
		"chicken": 0,
		"beef": 0,
		"pork": 0,
		"curry_stock": 0,
		"potato": 0,
		"spinach": 0,
		"eggplant": 0,
		"cheese": 0,
		"lemon": 0,
		"cucumber": 0,
		"coffee_mix": 0,
		"milk": 0,
	}

	Game.cookable_food = {
		chicken_curry = 0,
		pork_curry = 0,
		beef_curry = 0,
		lemonade = 0,
		coffee = 0,
	}


#	Game.meal_stats[str(Game.day)] = {
#		chicken_curry = {
#			transactions_succeded = 0,
#			transactions_failed = 0,
#			money_earned = 0,
#			price_sold = 0,
#			customers_served = {
#				tourist = 0,
#				regular = 0,
#				local = 0,
#			},
#			satisfaction_gained = {
#				tourist = 0,
#				regular = 0,
#				local = 0,
#			},
#			ewaste_produced = 0,
#			iwaste_produced = 0,
#		},
#		pork_curry = {
#			transactions_succeded = 0,
#			transactions_failed = 0,
#			money_earned = 0,
#			price_sold = 0,
#			customers_served = {
#				tourist = 0,
#				regular = 0,
#				local = 0,
#			},
#			satisfaction_gained = {
#				tourist = 0,
#				regular = 0,
#				local = 0,
#			},
#			ewaste_produced = 0,
#			iwaste_produced = 0,
#		},
#		beef_curry = {
#			transactions_succeded = 0,
#			transactions_failed = 0,
#			money_earned = 0,
#			price_sold = 0,
#			customers_served = {
#				tourist = 0,
#				regular = 0,
#				local = 0,
#			},
#			satisfaction_gained = {
#				tourist = 0,
#				regular = 0,
#				local = 0,
#			},
#			ewaste_produced = 0,
#			iwaste_produced = 0,
#		},
#		lemonade = {
#			transactions_succeded = 0,
#			transactions_failed = 0,
#			money_earned = 0,
#			price_sold = 0,
#			customers_served = {
#				tourist = 0,
#				regular = 0,
#				local = 0,
#			},
#			satisfaction_gained = {
#				tourist = 0,
#				regular = 0,
#				local = 0,
#			},
#			ewaste_produced = 0,
#			iwaste_produced = 0,
#		},
#		coffee = {
#			transactions_succeded = 0,
#			transactions_failed = 0,
#			money_earned = 0,
#			price_sold = 0,
#			customers_served = {
#				tourist = 0,
#				regular = 0,
#				local = 0,
#			},
#			satisfaction_gained = {
#				tourist = 0,
#				regular = 0,
#				local = 0,
#			},
#			ewaste_produced = 0,
#			iwaste_produced = 0,
#		},
#	}

#	Game.waste_stats[str(Game.day)] = {
#		ewaste_data = {
#			total_produced = 0,
#			total_managed = 0,
#			from_meals = {
#				pork_curry = 0,
#				chicken_curry = 0,
#				beef_curry = 0,
#				lemonade = 0,
#				coffee = 0,
#			},
#			strategies_used = {
#				food_shelter = 0,
#				feed_animals = 0,
#				landfill = 0,
#			}
#		},
#	}


func start_day_cycle():
	_on_day_start()  #dawn-noon DAY0
	yield(_day_start(), "completed")  #noon-midnight DAY0
	_on_day_end()  # +DAY1


func start_dev_cycle():
	_on_day_start()
	_dev_start()
	_on_day_end()


func _on_day_start():
	# Adds a 0 entry to the compost_stack
	Game.compost_stack.append(0)
	Game.compost_stack = Game.compost_stack.slice(-3, Game.compost_stack.size())
	Game.strat_hndlr.reset_strat_use()

	# Calculates min and max customer amount based on day
	if Game.buffs_hndlr.compost_debuff():
		print("Customer Debuffed!")
		Game.min_custo = (5 + Game.day) * 0.6
		Game.max_custo = (10 + Game.day) * 0.6
	else:
		Game.min_custo = 5 + Game.day
		Game.max_custo = 10 + Game.day
	# Initializes key nodes from the daylight scene
	if get_tree().current_scene.name == "OnDaylight":
		king_laugh_sprite = get_node("/root/OnDaylight/KingReactions/KingLaughSprite")
		king_cry_sprite = get_node("/root/OnDaylight/KingReactions/KingCrySprite")
		game_console = get_node("/root/OnDaylight/%GameConsole")
		npc_spawner = get_node("/root/OnDaylight/NPCs/Spawner")


func _day_start():
	# Length of the day in seconds
	var day_length = rand_range(Game.min_day_len, Game.max_day_len)
	# Amount of customers per day
	var customer_amount = rand_range(Game.min_custo, Game.max_custo)

	for i in customer_amount:
		var entry = $"../Purchase".create_transaction()
		if entry.size() != 7:
			game_console.add_text("Failed Transaction: " + str(entry))  # show result in game debug screen
			king_laugh_sprite.visible = false
			king_cry_sprite.visible = true
			SoundHandler.king_cry.play()
		else:
			game_console.add_entry(entry)  # show result in game debug screen
			king_cry_sprite.visible = false
			king_laugh_sprite.visible = true
			SoundHandler.king_laugh.play()
			npc_spawner.spawnNPC()

		var wait = rand_range(0.7, 1.3) * (day_length / customer_amount)
		yield(get_tree().create_timer(wait), "timeout")
		king_cry_sprite.visible = false
		king_laugh_sprite.visible = false


# Faster Day
func _dev_start():
	# Amount of customers per day
	var customer_amount = rand_range(Game.min_custo, Game.max_custo)

	for i in customer_amount:
		var entry = $"../Purchase".create_transaction()
		if entry.size() != 7:
			game_console.add_text("Failed Transaction: " + str(entry))
		else:
			game_console.add_entry(entry)


func _on_day_end():
	# before day end so that live updates displays correct values
	$"../Waste".dispose_leftover_prepared_meals()

	# Handles leftover money, ewaste, and iwaste per day
	emit_signal("day_ended")
	emit_signal(
		"stats_leftover", Game.money, Game.edible_waste, Game.inedible_waste, Game.cookable_food
	)

	Game.day += 1

	$"../Ingredient".receive_ingredients_ordered()
	$"../Ingredient".check_unlocked_ingredients()
	$"../Strategy".check_store_level()
	$"../Strategy".load_unlocked_strats()

	init_daily_statistics()
