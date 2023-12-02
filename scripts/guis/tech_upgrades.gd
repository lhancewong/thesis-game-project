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
		+ str(Game.skill_points)
	)


func _on_ComUnlock_pressed():
	if Game.skill_points > 0:
		Game.skill_points -= 1
		Game.strat_hndlr.unlock_strategy('composting')
		SoundHandler.happy_noise.play()
	else: 
		SoundHandler.angry_noise.play()


func _on_IndusUnlock_pressed():
	if Game.skill_points > 0:
		Game.skill_points -= 1
		Game.strat_hndlr.unlock_strategy('industrial')
		SoundHandler.happy_noise.play()
	else:
		SoundHandler.angry_noise.play()


func _on_AniUnlock_pressed():
	if Game.skill_points > 0:
		Game.skill_points -= 1
		Game.strat_hndlr.unlock_strategy('feed_animals')
		SoundHandler.happy_noise.play()
	else:
		SoundHandler.angry_noise.play()
		
		
func _on_SheltUnlock_pressed():
	if Game.skill_points > 0:
		Game.skill_points -= 1
		Game.strat_hndlr.unlock_strategy('feed_humans')
		SoundHandler.happy_noise.play()
	else:
		SoundHandler.angry_noise.play()
