extends Node

var steve_harvey
var terminal
var npc_spawner

signal day_ended(money_left, ewaste_left, iwaste_left)


func init_daylight_main():
	init_daily_statistics()
	$"../Ingredient".check_unlocked_ingredient()
	$"../Strategy".check_store_level()


func init_daily_statistics():
	Game.stats_per_day[str(Game.day)] = {
		meals_served = {pork_curry = 0, chicken_curry = 0, beef_curry = 0},
		ingredients_bought = {pork = 0, chicken = 0, beef = 0, curry_powder = 0},
		ingredients_consumed = {pork = 0, chicken = 0, beef = 0, curry_powder = 0},
		customers_served = {tourist = 0, regular = 0, local = 0},
		money_earned_from_meals = {pork_curry = 0, chicken_curry = 0, beef_curry = 0},
		satisfaction_gained = 0.0,
		money_left = 0.0,
		money_spent = 0.0,
		money_earned = 0.0,
		ewaste_produced = 0.0,
		ewaste_managed = 0.0,
		ewaste_left = 0.0,
		iwaste_produced = 0.0,
		iwaste_managed = 0.0,
		iwaste_left = 0.0,
	}


func start_day_cycle():
	_on_day_start()  #dawn-noon DAY0
	yield(_day_start(), "completed")  #noon-midnight DAY0
	_on_day_end()  # +DAY1


# Prepares the dictionary to store daily statistics
func _on_day_start():
	# Calculates min and max customer amount based on day
	Game.min_custo = 5 + Game.day
	Game.max_custo = 10 + Game.day
	# Initializes key nodes from the daylight scene
	if get_tree().current_scene.name == "OnDaylight":
		steve_harvey = get_node("/root/OnDaylight/PauseFrame/SteveHarvey")
		terminal = get_node("/root/OnDaylight/VBoxContainer/HBoxContainer/GameConsole")
		npc_spawner = get_node("/root/OnDaylight/NPCs/Spawner")

	$"../Ingredient".check_unlock_ingredient()
	$"../Strategy".check_upgrade_store_level()

func _day_start():
	# Length of the day in seconds
	var day_length = rand_range(Game.min_day_len, Game.max_day_len)
	# Amount of customers per day
	var customer_amount = rand_range(Game.min_custo, Game.max_custo)

	for i in customer_amount:
		var entry = $"../Purchase".create_transaction()

		if entry.empty():
			terminal.add_text("No Food!" + str(entry))
			SoundHandler.get_node("DryFart").play()
		else:
			terminal.add_entry(entry)
			SoundHandler.get_node("VineBoom").play()
			npc_spawner.spawnNPC()
			steve_harvey.visible = !steve_harvey.visible

		var wait = rand_range(0.7, 1.3) * (day_length / customer_amount)
		yield(get_tree().create_timer(wait), "timeout")


func _on_day_end():
	# Handles leftover money, ewaste, and iwaste per day
	emit_signal("day_ended", Game.money, Game.edible_waste, Game.inedible_waste)

	Game.day += 1
	init_daily_statistics()
