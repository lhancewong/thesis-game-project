extends Control

# Node
onready var terminal = $VBoxContainer/HBoxContainer/VBoxContainer2/GameConsole

# Sub Scenes
onready var live_updates = $VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/LiveUpdates
onready var order_ingredients = $VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/OrderIngredients
onready var order_drinks = $VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/OrderDrinks
onready var price_management = $VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/PriceManagement
onready var tech_upgrades = $VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/TechUpgrades
onready var statistics = $VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/Statistics
onready var management = $VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/ManagementHander
onready var sub_scenes_list = [
	live_updates,
	order_ingredients,
	order_drinks,
	price_management,
	tech_upgrades,
	statistics,
	management,
]

# labels
onready var day_lbl = $VBoxContainer/topbar/HBoxContainer/Day
onready var money_lbl = $VBoxContainer/topbar/HBoxContainer/Money
onready var waste_lbl = $VBoxContainer/topbar/HBoxContainer/Waste
onready var satisfaction_lbl = $VBoxContainer/topbar/HBoxContainer/Satisfaction

onready var stock_chicken = $VBoxContainer/HBoxContainer/VBoxContainer2/food_icons/VBoxContainer/HBoxContainer/ChickenAmnt
onready var stock_beef = $VBoxContainer/HBoxContainer/VBoxContainer2/food_icons/VBoxContainer/HBoxContainer/BeefAmnt
onready var stock_pork = $VBoxContainer/HBoxContainer/VBoxContainer2/food_icons/VBoxContainer/HBoxContainer/PorkAmnt
onready var stock_curry = $VBoxContainer/HBoxContainer/VBoxContainer2/food_icons/VBoxContainer/HBoxContainer/CurryAmnt

onready var stock_lemon = $VBoxContainer/HBoxContainer/VBoxContainer2/food_icons/VBoxContainer/HBoxContainer2/LemonAmnt
onready var stock_cucumber = $VBoxContainer/HBoxContainer/VBoxContainer2/food_icons/VBoxContainer/HBoxContainer2/CucumberAmnt
onready var stock_coffee = $VBoxContainer/HBoxContainer/VBoxContainer2/food_icons/VBoxContainer/HBoxContainer2/CoffeeAmnt
onready var stock_milk = $VBoxContainer/HBoxContainer/VBoxContainer2/food_icons/VBoxContainer/HBoxContainer2/MilkAmnt


func _ready():
	_toggle_show_sub_scene(live_updates)
	$PauseFrame.hide()
	$PauseFrame/SteveHarvey.hide()
	set_physics_process(true)
	Game.day_hndlr.init_daylight_main()


func _process(delta):
	_update_labels()


func _update_labels():
	day_lbl.text = "Day " + str(Game.day)
	money_lbl.text = "Money: " + Game.get_str_money()
	waste_lbl.text = "Waste: " + Game.get_str_waste()
	satisfaction_lbl.text = ("Satisfaction: " + Game.get_str_satisfaction())

	var stockpile = Game.i_stockpile

	stock_chicken.text = str(stockpile["chicken"])
	stock_beef.text = str(stockpile["beef"])
	stock_pork.text = str(stockpile["pork"])
	stock_curry.text = str(stockpile["curry_powder"])

	stock_lemon.text = str(stockpile["lemon"])
	stock_cucumber.text = str(stockpile["cucumber"])
	stock_coffee.text = str(stockpile["coffee_mix"])
	stock_milk.text = str(stockpile["milk"])


# Hides every sub_scene then shows the desired sub scene
func _toggle_show_sub_scene(sub_scene_name):
	var desired_sub_scene

	for i in sub_scenes_list:
		if i == sub_scene_name:
			desired_sub_scene = i
		else:
			i.hide()

	desired_sub_scene.show()


# Button Signals
func _on_Debug_pressed():
	Game.food_hndlr.update_cookable_food()
	terminal.add_text(str(Game.cookable_food) + " " + Game.food_hndlr.get_rand_cookable_food())
	$RestaurantView.visible = !$RestaurantView.visible


func _on_ToTitleScreen_pressed():
	Game.save_hndlr.save_game()

	get_tree().change_scene("res://interfaces/title_screen_menus/title_screen_main.tscn")

	Game.init_var()


# Main update sequence handler for now
func _on_StartDay_pressed():
	terminal.add_text("Day Started!")
	_on_pause_button_pressed()
	yield(Game.day_hndlr.start_day_cycle(), "completed")
	_on_pause_popup_close_pressed()
	terminal.add_text("Day Finished!")


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


func _on_OrderDrinks_pressed():
	_toggle_show_sub_scene(order_drinks)


func _on_PriceManagement_pressed():
	_toggle_show_sub_scene(price_management)


func _on_TechUpgrades_pressed():
	_toggle_show_sub_scene(tech_upgrades)


func _on_Statistics_pressed():
	_toggle_show_sub_scene(statistics)


func _on_Management_pressed():
	management.set_screen()
	_toggle_show_sub_scene(management)
