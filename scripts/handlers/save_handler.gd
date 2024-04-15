extends Node


func save():
	var save_dict = {
		"money": Game.money,
		"edible_waste": Game.edible_waste,
		"inedible_waste": Game.inedible_waste,
		"satisfaction": Game.satisfaction,
		"day": Game.day,
		"min_day_len": Game.min_day_len,
		"max_day_len": Game.max_day_len,
		"min_custo": Game.min_custo,
		"max_custo": Game.max_custo,
		"store_level": Game.store_level,
		"skill_points": Game.skill_points,
		"compost_stack": Game.compost_stack,
		"last_compost_day": Game.last_compost_day,
		"total_animals_fed": Game.total_animals_fed,
		"strategy_use_tracker": Game.strategy_use_tracker,
		"strategy_cap": Game.strategy_cap,
		"unlocked_ingredients": Game.unlocked_ingredients,
		"unlocked_tech": Game.unlocked_tech,
		"meal_prices": Game.meal_prices,
		"i_stockpile": Game.i_stockpile,
		"cookable_food": Game.cookable_food,
		"ingredients_ordered": Game.ingredients_ordered,
		"stats_per_day": Game.stats_per_day,
		"transaction_receipts": Game.transaction_receipts,
		"strategy_receipts": Game.strategy_receipts,
		"waste_managed": Game.waste_managed,
	}
	return save_dict


func save_game():
	var save_path = "user://savegame%s.save" % Game.save_file_num
	var save_game = File.new()
	save_game.open(save_path, File.WRITE)
	# Store the save dictionary as a new line in the save file.
	save_game.store_line(to_json(save()))
	save_game.close()


func load_game():
	var save_path = "user://savegame%s.save" % Game.save_file_num
	var save_game = File.new()
	if not save_game.file_exists(save_path):
		return  # Error! We don't have a save to load.
	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	save_game.open(save_path, File.READ)
	while save_game.get_position() < save_game.get_len():
		# Get the saved dictionary from the next line in the save file
		var save_data = parse_json(save_game.get_line())
		# Now we set the remaining variables.
		for i in save_data.keys():
			var data = save_data[i]
			match i:
				"money":
					Game.money = data
				"edible_waste":
					Game.edible_waste = data
				"inedible_waste":
					Game.inedible_waste = data
				"satisfaction":
					Game.satisfaction = data
				"day":
					Game.day = data
				"min_day_len":
					Game.min_day_len = data
				"max_day_len":
					Game.max_day_len = data
				"min_custo":
					Game.min_custo = data
				"max_custo":
					Game.max_custo = data

				"store_level":
					Game.store_level = data
				"skill_points":
					Game.skill_points = data

				"compost_stack":
					Game.compost_stack = data
				"last_compost_day":
					Game.last_compost_day = data
				"total_animals_fed":
					Game.total_animals_fed = data

				"strategy_use_tracker":
					Game.strategy_use_tracker = data
				"strategy_cap":
					Game.strategy_cap = data
				"unlocked_ingredients":
					Game.unlocked_ingredients = data
				"unlocked_tech":
					Game.unlocked_tech = data
				"meal_prices":
					Game.meal_prices = data
				"i_stockpile":
					Game.i_stockpile = data
				"cookable_food":
					Game.cookable_food = data
				"ingredients_ordered":
					Game.ingredients_ordered = data
				"stats_per_day":
					Game.stats_per_day = data
				"transaction_receipts":
					Game.transaction_receipts = data
				"strategy_receipts":
					Game.strategy_receipts = data

				"waste_managed":
					Game.waste_managed = data

	save_game.close()


func delete_save(num):
	SoundHandler.scream.play()
	var dir = Directory.new()
	var save_path = "user://savegame%s.save" % num
	dir.remove(save_path)
