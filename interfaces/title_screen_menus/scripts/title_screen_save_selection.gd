extends Control


func _on_ToTitleScreen_pressed():
	if get_tree().change_scene("res://interfaces/title_screen_menus/title_screen_main.tscn") != OK:
		print("An unexpected error occured when trying to switch to the Title Screen scene")

func _on_SaveFile1_pressed():
	if get_tree().change_scene("res://interfaces/on_daylight_menus/on_daylight_main.tscn") != OK:
		print("An unexpected error occured when trying to switch to the Main Game scene")
