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
		"i_stockpile": Game.i_stockpile,
		"sold_food": Game.sold_food,
		"waste_managed": Game.waste_managed,
		"meals_served_per_day": Game.meals_served_per_day,
		"ingreds_bought_per_day": Game.ingreds_bought_per_day,
		"ingreds_consumed_per_day": Game.ingreds_consumed_per_day,
		"custos_served_per_day": Game.custos_served_per_day,
		"satis_earned_per_day": Game.satis_earned_per_day,
		"money_left_per_day": Game.money_left_per_day,
		"money_spent_per_day": Game.money_spent_per_day,
		"money_earned_per_day": Game.money_earned_per_day,
		"e_waste_produced_per_day": Game.e_waste_produced_per_day,
		"e_waste_managed_per_day": Game.e_waste_managed_per_day,
		"e_waste_left_per_day": Game.e_waste_left_per_day,
		"i_waste_produced_per_day": Game.i_waste_produced_per_day,
		"i_waste_managed_per_day": Game.i_waste_managed_per_day,
		"i_waste_left_per_day": Game.i_waste_left_per_day,
	}
	return save_dict


func save_game(num):
	print("game save")
	var save_path = "user://savegame%s.save" % num
	var save_game = File.new()
	save_game.open(save_path, File.WRITE)
	# Store the save dictionary as a new line in the save file.
	save_game.store_line(to_json(save()))
	save_game.close()


func load_game(num):
	var save_path = "user://savegame%s.save" % num
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
				"i_stockpile":
					Game.i_stockpile = data
				"sold_food":
					Game.sold_food = data
				"waste_managed":
					Game.waste_managed = data
				"meals_served_per_day":
					Game.meals_served_per_day = data
				"ingreds_bought_per_day":
					Game.ingreds_bought_per_day = data
				"ingreds_consumed_per_day":
					Game.ingreds_consumed_per_day = data
				"custos_served_per_day":
					Game.custos_served_per_day = data
				"satis_earned_per_day":
					Game.satis_earned_per_day = data
				"money_left_per_day":
					Game.money_left_per_day = data
				"money_spent_per_day":
					Game.money_spent_per_day = data
				"money_earned_per_day":
					Game.money_earned_per_day = data
				"e_waste_produced_per_day":
					Game.e_waste_produced_per_day = data
				"e_waste_managed_per_day":
					Game.e_waste_managed_per_day = data
				"e_waste_left_per_day":
					Game.e_waste_left_per_day = data
				"i_waste_produced_per_day":
					Game.i_waste_produced_per_day = data
				"i_waste_managed_per_day":
					Game.i_waste_managed_per_day = data
				"i_waste_left_per_day":
					Game.i_waste_left_per_day = data

	save_game.close()


func delete_save(num):
	var dir = Directory.new()
	var save_path = "user://savegame%s.save" % num
	dir.remove(save_path)
