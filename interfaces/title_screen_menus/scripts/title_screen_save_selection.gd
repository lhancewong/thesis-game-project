extends Control


func _on_ToTitleScreen_pressed():
	get_tree().change_scene("res://interfaces/title_screen_menus/title_screen_main.tscn")


func _on_SaveFile1_pressed():
	get_tree().change_scene("res://interfaces/on_daylight_menus/on_daylight_main.tscn")
