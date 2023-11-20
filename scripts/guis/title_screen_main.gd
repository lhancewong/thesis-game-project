extends Control


onready var vine_boom = $VineBoom

func _ready():
  randomize()

func _on_Start_pressed():
  if get_tree().change_scene("res://interfaces/title_screen_menus/title_screen_save_selection.tscn") != OK:
    print("An unexpected error occured when trying to switch to the Save Selection scene")

func _on_Options_pressed():
  if get_tree().change_scene("res://interfaces/title_screen_menus/title_screen_options.tscn") != OK:
    print("An unexpected error occured when trying to switch to the Options scene")

func _on_About_pressed():
  vine_boom.play()


func _on_Quit_pressed():
  get_tree().quit()
