extends Control


onready var vine_boom = $VineBoom


func _on_Start_pressed():
	get_tree().change_scene("res://interfaces/title_screen_menus/title_screen_save_selection.tscn")


func _on_Options_pressed():
	get_tree().change_scene("res://interfaces/title_screen_menus/title_screen_options.tscn")


func _on_About_pressed():
	vine_boom.play()


func _on_Quit_pressed():
	get_tree().quit()
