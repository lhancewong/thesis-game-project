extends Control

onready var main = $MainScreen
onready var compost = $Compost
onready var industrial = $Industrial
onready var feed_animals = $FeedAnimals
onready var food_shelter = $FoodShelter
onready var landfill = $Landfill
onready var sub_scenes_list = [
	main,
	compost,
	industrial,
	feed_animals,
	food_shelter,
	landfill,
]

onready var inedible_amnt = $"%InedibleAmnt"
onready var edible_amnt = $"%EdibleAmnt"


func set_screen():
	_toggle_show_sub_scene(main)
	inedible_amnt.text = Game.waste_hndlr.get_str_inedible_waste()
	edible_amnt.text = Game.waste_hndlr.get_str_edible_waste()


func _physics_process(delta):
	inedible_amnt.text = Game.waste_hndlr.get_str_inedible_waste()
	edible_amnt.text = Game.waste_hndlr.get_str_edible_waste()


# Hides every sub_scene then shows the desired sub scene
func _toggle_show_sub_scene(sub_scene_name):
	var desired_sub_scene

	for i in sub_scenes_list:
		if i == sub_scene_name:
			desired_sub_scene = i
		else:
			i.hide()

	desired_sub_scene.show()


func _on_Compost_pressed():
	SoundHandler.button_click.play()
	_toggle_show_sub_scene(compost)


func _on_Industrial_pressed():
	SoundHandler.button_click.play()
	_toggle_show_sub_scene(industrial)


func _on_FeedAnimals_pressed():
	SoundHandler.button_click.play()
	_toggle_show_sub_scene(feed_animals)


func _on_FoodShelter_pressed():
	SoundHandler.button_click.play()
	_toggle_show_sub_scene(food_shelter)


func _on_Landfill_pressed():
	SoundHandler.button_click.play()
	_toggle_show_sub_scene(landfill)
