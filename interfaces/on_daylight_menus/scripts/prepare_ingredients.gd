extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Resources
var food1 = 0

# SFX
onready var villager_sigh = $VillagerSigh


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_food1plus_pressed():
	food1 += 1
	$MainContainer/MiddleLine/Middle1/HBoxContainer/LineEdit.text = str(food1)
	


func _on_food1minus_pressed():
	if food1 == 0:
		return
	food1 -= 1
	$MainContainer/MiddleLine/Middle1/HBoxContainer/LineEdit.text = str(food1)
