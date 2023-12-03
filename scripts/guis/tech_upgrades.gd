extends Control


func _process(delta):
	$VBoxContainer/HBoxContainer/Text/Amount/AmntLabel.text = (
		"Skill Points: "
		+ str(Game.skill_points)
	)


func _on_UnlockCompostButton_pressed():
	if Game.skill_points > 0:
		Game.skill_points -= 1
		Game.strat_hndlr.unlock_strategy("composting")


func _on_UnlockIndustrialButton_pressed():
	if Game.skill_points > 0:
		Game.skill_points -= 1
		Game.strat_hndlr.unlock_strategy("industrial")


func _on_UnlockFeedAnimalsButton_pressed():
	if Game.skill_points > 0:
		Game.skill_points -= 1
		Game.strat_hndlr.unlock_strategy("feed_animals")


func _on_UnlockFoodShelterButton_pressed():
	if Game.skill_points > 0:
		Game.skill_points -= 1
		Game.strat_hndlr.unlock_strategy("food_shelter")
