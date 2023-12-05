extends Node


# Handles unlocking management strategies
func unlock_strategy(type):
	if get_tree().current_scene.name == "OnDaylight":
		var waste_management_node = get_node("/root/OnDaylight/%WasteManagement")
		var tech_upgrade_node = get_node("/root/OnDaylight/%TechUpgrades")

		var compost_block_node = waste_management_node.get_node("%CompostBlock")
		var compost_node = waste_management_node.get_node("%CompostButton")
		var compost_unlock_button = tech_upgrade_node.get_node("%UnlockCompostButton")

		var indus_block_node = waste_management_node.get_node("%IndustrialBlock")
		var indus_node = waste_management_node.get_node("%IndustrialButton")
		var indus_unlock_button = tech_upgrade_node.get_node("%UnlockIndustrialButton")

		var ani_block_node = waste_management_node.get_node("%FeedAnimalsBlock")
		var ani_node = waste_management_node.get_node("%FeedAnimalsButton")
		var ani_unlock_button = tech_upgrade_node.get_node("%UnlockFeedAnimalsButton")

		var shelter_block_node = waste_management_node.get_node("%FoodShelterBlock")
		var shelter_node = waste_management_node.get_node("%FoodShelterButton")
		var shelter_unlock_button = tech_upgrade_node.get_node("%UnlockFoodShelterButton")

		match type:
			"composting":
				Game.unlocked_tech["compost"] = true
				compost_block_node.visible = false
				compost_node.visible = true
				compost_unlock_button.disabled = true
				compost_unlock_button.text = str("unlocked")
			"industrial":
				Game.unlocked_tech["industrial"] = true
				indus_block_node.visible = false
				indus_node.visible = true
				indus_unlock_button.disabled = true
				indus_unlock_button.text = str("unlocked")
			"feed_animals":
				Game.unlocked_tech["feed_animals"] = true
				ani_block_node.visible = false
				ani_node.visible = true
				ani_unlock_button.disabled = true
				ani_unlock_button.text = str("unlocked")
			"food_shelter":
				Game.unlocked_tech["food_shelter"] = true
				shelter_block_node.visible = false
				shelter_node.visible = true
				shelter_unlock_button.disabled = true
				shelter_unlock_button.text = str("unlocked")


func check_store_level():
	if Game.satisfaction >= 50:
		Game.store_level += 1
		Game.satisfaction = 0
		Game.skill_points += 1


func landfill_cost(amount):
	Game.money -= amount * 2


func load_unlocked_strats():
	for key in Game.unlocked_tech:
		if Game.unlocked_tech[str(key)]:
			unlock_strategy(str(key))


func cap_checker(strategy):
	if Game.strategy_use_tracker[strategy] >= Game.strategy_cap[strategy]:
		return true
	return false


func reset_strat_use():
	for key in Game.strategy_use_tracker:
		Game.strategy_use_tracker[str(key)] = 0
