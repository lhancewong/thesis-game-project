extends Control

# Resources
export(Resource) var resto
export(Resource) var custo

# SFX
onready var villager_sigh = $VillagerSigh
onready var vine_boom = $VineBoom

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

func _physics_process(delta):
	$VBoxContainer/topbar/HBoxContainer/Label.text = "Money: " + resto.get_money()
	$VBoxContainer/topbar/HBoxContainer/Label2.text = "Waste: " + resto.get_waste()
	$VBoxContainer/topbar/HBoxContainer/Label3.text = "Satisfaction: " + resto.get_satisfaction()

# Hides every sub_scene then shows the desired sub scene
func _toggle_show_sub_scene(sub_scene_name):
	var desired_sub_scene
	
	for i in (sub_scenes_list):
		if i == sub_scene_name:
			desired_sub_scene = i
		else:
			i.hide()
	
	desired_sub_scene.show()

func _purchase_handler() -> void:
	var day_length = rand_range(6,10)
	var customer_amount = rand_range(5,10)
	
	for i in customer_amount:
		var timer = rand_range(0.9, 1.1) * (day_length/customer_amount)
		yield(get_tree().create_timer(timer),"timeout")
		resto.add_purchase(custo.purchase_food())
		vine_boom.play()
	
	emit_signal("completed")

# Button Signals
func _on_ToTitleScreen_pressed():
	get_tree().change_scene("res://interfaces/title_screen_menus/title_screen_main.tscn")

func _on_StartDay_pressed():
	villager_sigh.play()
	_purchase_handler()
	yield(_purchase_handler(), "completed")
	

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












