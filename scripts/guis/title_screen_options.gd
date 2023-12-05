extends Control


func _on_ToTitleScreen_pressed():
	SoundHandler.button_click.play()
	if get_tree().change_scene("res://interfaces/title_screen_menus/title_screen_main.tscn") != OK:
		print("An unexpected error occured when trying to switch to the Title Screen scene")


func _on_Audio_pressed():
	SoundHandler.button_click.play()
	SoundHandler.master_mute()


func _on_Developer_pressed():
	SoundHandler.button_click.play()
	pass
