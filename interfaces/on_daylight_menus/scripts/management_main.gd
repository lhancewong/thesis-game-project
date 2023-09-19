extends Control

onready var main = $MainScreen
onready var compost = $Compost
onready var industrial = $Industrial
onready var feed_animals = $FeedAnimals
onready var food_shelter = $FoodShelter
onready var landfill = $Landfill
onready var sub_scenes_list = [main, compost, industrial, feed_animals, food_shelter, landfill]
export(Resource) var waste_handler 


func set_screen():
	_toggle_show_sub_scene(main)
	$"MainScreen/VBoxContainer/ContentFrame/Inedible Waste/Waste/Amount/InedibleAmnt".text = str(waste_handler.returnInedibleWaste())
	$"MainScreen/VBoxContainer/ContentFrame/Edible Waste/Waste/Amount/EdibleAmnt".text = str(waste_handler.returnEdibleWaste())


func _physics_process(delta):
	$"MainScreen/VBoxContainer/ContentFrame/Inedible Waste/Waste/Amount/InedibleAmnt".text = str(waste_handler.returnInedibleWaste())
	$"MainScreen/VBoxContainer/ContentFrame/Edible Waste/Waste/Amount/EdibleAmnt".text = str(waste_handler.returnEdibleWaste())

# Hides every sub_scene then shows the desired sub scene
func _toggle_show_sub_scene(sub_scene_name):
	var desired_sub_scene
	
	for i in (sub_scenes_list):
		if i == sub_scene_name:
			desired_sub_scene = i
		else:
			i.hide()
	
	desired_sub_scene.show()


func _on_Compost_pressed():
	_toggle_show_sub_scene(compost)


func _on_Industrial_pressed():
	_toggle_show_sub_scene(industrial)


func _on_FeedAnimals_pressed():
	_toggle_show_sub_scene(feed_animals)


func _on_FoodShelter_pressed():
	_toggle_show_sub_scene(food_shelter)


func _on_Landfill_pressed():
	_toggle_show_sub_scene(landfill)

