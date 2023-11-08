extends Control

# Node
onready var terminal = $VBoxContainer/HBoxContainer/GameConsole

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
    $PauseFrame.hide()
    $PauseFrame/SteveHarvey.hide()
    set_physics_process(true)

func _physics_process(delta):
    $VBoxContainer/topbar/HBoxContainer/Day.text = "Day " + str(Game.day)
    $VBoxContainer/topbar/HBoxContainer/Money.text = "Money: " + Game.get_str_money()
    $VBoxContainer/topbar/HBoxContainer/Waste.text = "Waste: " + Game.get_str_waste()
    $VBoxContainer/topbar/HBoxContainer/Satisfaction.text = "Satisfaction: " + Game.get_str_satisfaction()

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
func _on_Debug_pressed():
    Game.food_hndlr.update_cookable_food()
    $PauseFrame/SteveHarvey.visible = !$PauseFrame/SteveHarvey.visible
    terminal.add_text(str(Game.cookable_food))
    terminal.add_text(Game.food_hndlr.get_rand_cookable_food())

func _on_ToTitleScreen_pressed():
    get_tree().change_scene("res://interfaces/title_screen_menus/title_screen_main.tscn")

# Main update sequence handler for now
func _on_StartDay_pressed():
    terminal.add_text("Day Started!")
    
    _on_pause_button_pressed()
    yield(Game.purchase_hndlr.start_day(), "completed")
    _on_pause_popup_close_pressed()
    
    terminal.add_text("Day Finished!")
    Game.day += 1

# Greys out entire screen
func _on_pause_button_pressed():
    get_tree().paused = true
    $PauseFrame.show()

# Un-greys out entire screen
func _on_pause_popup_close_pressed():
    $PauseFrame.hide()
    get_tree().paused = false


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
