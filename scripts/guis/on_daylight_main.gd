extends Control

# Node
onready var game_console = $"%GameConsole"
onready var restaurant_view = $"%RestaurantView"
onready var _animated_sprite = $KingReactions/AnimationPlayer

# Sub Scenes
onready var live_updates = $"%LiveUpdates"
onready var order_ingredients = $"%OrderIngredients"
onready var order_drinks = $"%OrderDrinks"
onready var price_management = $"%PriceManagement"
onready var management = $"%WasteManagement"
onready var tech_upgrades = $"%TechUpgrades"
onready var statistics = $"%Statistics"

onready var sub_scenes_list = [
	live_updates,
	order_ingredients,
	order_drinks,
	price_management,
	management,
	tech_upgrades,
	statistics,
]

# TopBar Labels
onready var day_label = $"%DayLabel"
onready var money_label = $"%MoneyLabel"
onready var waste_label = $"%WasteLabel"
onready var level_label = $"%LevelLabel"
onready var satisfaction_label = $"%SatisfactionLabel"

# FoodIcon Labels
onready var stock_chicken = $"%StockChicken"
onready var stock_beef = $"%StockBeef"
onready var stock_pork = $"%StockPork"
onready var stock_curry = $"%StockCurry"
onready var stock_lemon = $"%StockLemon"
onready var stock_cucumber = $"%StockCucumber"
onready var stock_coffee = $"%StockCoffee"
onready var stock_milk = $"%StockMilk"


func _ready():
	_toggle_show_sub_scene(live_updates)
	$PauseFrame.hide()
	$KingReactions/KingLaughSprite.hide()
	$KingReactions/KingCrySprite.hide()
	$PauseFrame/SteveHarvey.hide()
	set_physics_process(true)
	Game.day_hndlr.init_daylight_main()


func _process(delta):
	_update_labels()
	_animated_sprite.play("king_laugh")
	_animated_sprite.play("king_cry")


func _update_labels():
	day_label.text = "Day " + str(Game.day)
	money_label.text = "Money: " + Game.get_str_money()
	waste_label.text = "Waste: " + Game.get_str_waste()
	level_label.text = "Level: " + str(Game.store_level)
	satisfaction_label.text = "Satisfaction: " + Game.get_str_satisfaction()

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
	SoundHandler.button_click.play()
	restaurant_view.visible = !restaurant_view.visible
	game_console.visible = !game_console.visible


func _on_ToTitleScreen_pressed():
	SoundHandler.button_click.play()
	Game.save_hndlr.save_game()
	get_tree().change_scene("res://interfaces/title_screen_menus/title_screen_main.tscn")
	Game.init_game()


func _on_StartDay_pressed():
	SoundHandler.button_click.play()
	game_console.add_text("Day Started!")
	_on_pause_button_pressed()
	yield(Game.day_hndlr.start_day_cycle(), "completed")
	_on_pause_popup_close_pressed()
	game_console.add_text("Day Finished!")
	SoundHandler.progress_fill.play()


func _on_pause_button_pressed():
	$PauseFrame.show()


# Un-greys out entire screen
func _on_pause_popup_close_pressed():
	$PauseFrame.hide()


# Sub Scene Button Signals
func _on_LiveUpdatingStats_pressed():
	SoundHandler.button_click.play()
	_toggle_show_sub_scene(live_updates)


func _on_OrderIngredients_pressed():
	SoundHandler.button_click.play()
	_toggle_show_sub_scene(order_ingredients)


func _on_OrderDrinks_pressed():
	SoundHandler.button_click.play()
	_toggle_show_sub_scene(order_drinks)


func _on_PriceManagement_pressed():
	SoundHandler.button_click.play()
	_toggle_show_sub_scene(price_management)


func _on_TechUpgrades_pressed():
	SoundHandler.button_click.play()
	_toggle_show_sub_scene(tech_upgrades)


func _on_Statistics_pressed():
	SoundHandler.button_click.play()
	_toggle_show_sub_scene(statistics)


func _on_Management_pressed():
	SoundHandler.button_click.play()
	management.set_screen()
	_toggle_show_sub_scene(management)
