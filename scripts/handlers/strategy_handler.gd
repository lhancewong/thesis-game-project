extends Node


# Handles unlocking management strategies
func unlock_strategy(type):
	if get_tree().current_scene.name == "OnDaylight":
		if Game.skill_point > 0:
			Game.skill_point -= 1
		var compost_block_node = get_node(
			"/root/OnDaylight/VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/ManagementHander/MainScreen/VBoxContainer/ContentFrame/Inedible Waste/CompostBlock"
		)
		var compost_node = get_node(
			"/root/OnDaylight/VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/ManagementHander/MainScreen/VBoxContainer/ContentFrame/Inedible Waste/Compost"
		)
		var compost_unlock_button = get_node(
			"/root/OnDaylight/VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/TechUpgrades/VBoxContainer/HBoxContainer/FeedCompost/ComUnlock"
		)

		var indus_block_node = get_node(
			"/root/OnDaylight/VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/ManagementHander/MainScreen/VBoxContainer/ContentFrame/Inedible Waste/IndusBlock"
		)
		var indus_node = get_node(
			"/root/OnDaylight/VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/ManagementHander/MainScreen/VBoxContainer/ContentFrame/Inedible Waste/Industrial"
		)
		var indus_unlock_button = get_node(
			"//root/OnDaylight/VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/TechUpgrades/VBoxContainer/HBoxContainer/FeedCompost/IndusUnlock"
		)

		var ani_block_node = get_node(
			"/root/OnDaylight/VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/ManagementHander/MainScreen/VBoxContainer/ContentFrame/Edible Waste/AniBlock"
		)
		var ani_node = get_node(
			"/root/OnDaylight/VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/ManagementHander/MainScreen/VBoxContainer/ContentFrame/Edible Waste/FeedAnimals"
		)
		var ani_unlock_button = get_node(
			"/root/OnDaylight/VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/TechUpgrades/VBoxContainer/HBoxContainer/ShelterIndus/AniUnlock"
		)

		var shelter_block_node = get_node(
			"/root/OnDaylight/VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/ManagementHander/MainScreen/VBoxContainer/ContentFrame/Edible Waste/SheltBlock"
		)
		var shelter_node = get_node(
			"/root/OnDaylight/VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/ManagementHander/MainScreen/VBoxContainer/ContentFrame/Edible Waste/FoodShelter"
		)
		var shelter_unlock_button = get_node(
			"/root/OnDaylight/VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/TechUpgrades/VBoxContainer/HBoxContainer/ShelterIndus/SheltUnlock"
		)

		match type:
			1:
				compost_block_node.visible = false
				compost_node.visible = true
				compost_unlock_button.disabled = true
				compost_unlock_button.text = str("unlocked")
			#      Game.unlocked_ingredients.beef = true
			2:
				indus_block_node.visible = false
				indus_node.visible = true
				indus_unlock_button.disabled = true
				indus_unlock_button.text = str("unlocked")
			3:
				ani_block_node.visible = false
				ani_node.visible = true
				ani_unlock_button.disabled = true
				ani_unlock_button.text = str("unlocked")
			4:
				shelter_block_node.visible = false
				shelter_node.visible = true
				shelter_unlock_button.disabled = true
				shelter_unlock_button.text = str("unlocked")
