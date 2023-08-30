extends Control


onready var villager_sigh = $VillagerSigh
onready var BGM = $BGM


func _on_ToTitleScreen_pressed():
	get_tree().change_scene("res://interfaces/title_screen_menus/title_screen_main.tscn")


func _on_StartDay_pressed():
	villager_sigh.play()
