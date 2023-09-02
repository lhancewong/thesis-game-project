extends Control

# SFX
onready var villager_sigh = $VillagerSigh

# Sub Scenes
onready var live_updates = $VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/LiveUpdates
onready var order_ingredients = $VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/OrderIngredients
onready var prepare_ingredients = $VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/PrepareIngredients
onready var tech_upgrades = $VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/TechUpgrades
onready var statistics = $VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/Statistics
onready var management = $VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/ManagementHander
onready var sub_scenes_list = [
	live_updates,
	order_ingredients,
	prepare_ingredients,
	tech_upgrades,
	statistics,
	management,
]


func _ready():
	_toggle_show_sub_scene(live_updates)


# Hides every sub_scene then shows the desired sub scene
func _toggle_show_sub_scene(sub_scene_name):
	var desired_sub_scene
	
	for i in (sub_scenes_list):
		if i == sub_scene_name:
			desired_sub_scene = i
		else:
			i.hide()
	
	desired_sub_scene.show()


# Button Signals
func _on_ToTitleScreen_pressed():
	get_tree().change_scene("res://interfaces/title_screen_menus/title_screen_main.tscn")

func _on_StartDay_pressed():
	villager_sigh.play()

# Sub Scene Button Signals
func _on_LiveUpdatingStats_pressed():
	_toggle_show_sub_scene(live_updates)

func _on_OrderIngredients_pressed():
	_toggle_show_sub_scene(order_ingredients)

func _on_PrepareIngredients_pressed():
	_toggle_show_sub_scene(prepare_ingredients)

func _on_TechUpgrades_pressed():
	_toggle_show_sub_scene(tech_upgrades)

func _on_Statistics_pressed():
	_toggle_show_sub_scene(statistics)

func _on_Management_pressed():
	management.set_screen()
	_toggle_show_sub_scene(management)












