extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$VBoxContainer/HBoxContainer/Text/Amount/AmntLabel.text = (
		"Skill Points: "
		+ str(Game.skill_point)
	)


func _on_ComUnlock_pressed():
	if Game.skill_point > 0:
		Game.skill_point -= 1
		Game.strat_hndlr.unlock_strategy(1)
	else:
		return


func _on_IndusUnlock_pressed():
	if Game.skill_point > 0:
		Game.skill_point -= 1
		Game.strat_hndlr.unlock_strategy(2)
	else:
		return


func _on_AniUnlock_pressed():
	if Game.skill_point > 0:
		Game.skill_point -= 1
		Game.strat_hndlr.unlock_strategy(3)
	else:
		return


func _on_SheltUnlock_pressed():
	if Game.skill_point > 0:
		Game.skill_point -= 1
		Game.strat_hndlr.unlock_strategy(4)
	else:
		return
