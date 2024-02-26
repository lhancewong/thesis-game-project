extends Control

# Node
onready var game_console = $"%GameConsole"
onready var restaurant_view = $"%RestaurantView"
onready var animated_sprite = $KingReactions/AnimationPlayer

# Sub Scenes
onready var live_updates = $"%LiveUpdates"
onready var order_ingredients = $"%OrderIngredients"
onready var prepare_meals = $"%PrepareMeals"
onready var price_management = $"%PriceManagement"
onready var management = $"%WasteManagement"
onready var tech_upgrades = $"%TechUpgrades"
onready var statistics = $"%Statistics"

onready var sub_scenes_list = [
	live_updates,
	order_ingredients,
	prepare_meals,
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

# MealIcon Labels
onready var chkn_curry_label = $"%ChknCurryLabel"
onready var pork_curry_label = $"%PorkCurryLabel"
onready var beef_curry_label = $"%BeefCurryLabel"
onready var lemonade_label = $"%LemonadeLabel"
onready var coffee_label = $"%CoffeeLabel"

# OrderIcon Labels
onready var order_chicken_label = $"%OrderChickenLabel"
onready var order_beef_label = $"%OrderBeefLabel"
onready var order_pork_label = $"%OrderPorkLabel"
onready var order_curry_label = $"%OrderCurryLabel"
onready var order_lemon_label = $"%OrderLemonLabel"
onready var order_cucumber_label = $"%OrderCucumberLabel"
onready var order_coffee_label = $"%OrderCoffeeLabel"
onready var order_milk_label = $"%OrderMilkLabel"


func _ready():
	_toggle_show_sub_scene(live_updates)
	$PauseFrame.hide()
	$KingReactions/KingLaughSprite.hide()
	$KingReactions/KingCrySprite.hide()
	$PauseFrame/SteveHarvey.hide()
	set_physics_process(true)
	Game.day_hndlr.init_daylight_main()

	$RestaurantView.visible = false


func _process(delta):
	_update_labels()
	animated_sprite.play("king_emotes")

	$KingReactions.visible = false


func _update_labels():
	day_label.text = "Day " + str(Game.day)
	money_label.text = "Money: " + Game.get_str_money()
	waste_label.text = "Waste: %sg" % Game.get_str_waste()
	level_label.text = "Level: " + str(Game.store_level)
	satisfaction_label.text = "Satisfaction: " + Game.get_str_satisfaction()

	var stockpile = Game.i_stockpile

	stock_chicken.text = str(stockpile["chicken"])
	stock_beef.text = str(stockpile["beef"])
	stock_pork.text = str(stockpile["pork"])
	stock_curry.text = str(stockpile["curry_stock"])
	stock_lemon.text = str(stockpile["lemon"])
	stock_cucumber.text = str(stockpile["cucumber"])
	stock_coffee.text = str(stockpile["coffee_mix"])
	stock_milk.text = str(stockpile["milk"])

	var prepped_meals = Game.cookable_food

	chkn_curry_label.text = str(prepped_meals["chicken_curry"])
	pork_curry_label.text = str(prepped_meals["pork_curry"])
	beef_curry_label.text = str(prepped_meals["beef_curry"])
	lemonade_label.text = str(prepped_meals["lemonade"])
	coffee_label.text = str(prepped_meals["coffee"])

	var ordered_ingreds = Game.ingredients_ordered

	order_chicken_label.text = str(ordered_ingreds["chicken"])
	order_pork_label.text = str(ordered_ingreds["pork"])
	order_beef_label.text = str(ordered_ingreds["beef"])
	order_curry_label.text = str(ordered_ingreds["curry_stock"])
	order_lemon_label.text = str(ordered_ingreds["lemon"])
	order_cucumber_label.text = str(ordered_ingreds["cucumber"])
	order_coffee_label.text = str(ordered_ingreds["coffee_mix"])
	order_milk_label.text = str(ordered_ingreds["milk"])


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
	#restaurant_view.visible = !restaurant_view.visible
	game_console.visible = !game_console.visible

	game_console.add_text(str(Game.cookable_food))


func _on_ToTitleScreen_pressed():
	SoundHandler.button_click.play()
	Game.save_hndlr.save_game()
	get_tree().change_scene("res://interfaces/title_screen_menus/title_screen_main.tscn")
	Game.init_game()


func _on_StartDay_pressed():
	SoundHandler.button_click.play()
	game_console.add_text("")
	game_console.add_text("Day %s Started!" % str(Game.day))
	$RestaurantView.visible = true
	_on_pause_button_pressed()
	yield(Game.day_hndlr.start_day_cycle(), "completed")
	_on_pause_popup_close_pressed()
	game_console.add_text("Day %s Finished!" % str(Game.day))
	SoundHandler.progress_fill.play()


func _on_StartDev_pressed():
	game_console.add_text("")
	game_console.add_text("Day %s Started!" % str(Game.day))
	$RestaurantView.visible = true
	SoundHandler.vine_boom.play()
	Game.day_hndlr.start_dev_cycle()
	game_console.add_text("Day %s Finished!" % str(Game.day))


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
	_toggle_show_sub_scene(prepare_meals)


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
