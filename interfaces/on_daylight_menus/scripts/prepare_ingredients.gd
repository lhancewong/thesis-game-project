extends Node


# Resources
export var stock_ingredient1 = 0
export var stock_ingredient2 = 0

export var food1 = 0
export var food2 = 0

export var prepared_ingredient1 = 0
export var prepared_ingredient2 = 0

# SFX
onready var villager_sigh = $VillagerSigh


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_food1plus_pressed():
	food1 = int($MainContainer/MiddleLine/Middle1/HBoxContainer/LineEdit.text)
	food1 += 1
	$MainContainer/MiddleLine/Middle1/HBoxContainer/LineEdit.text = str(food1)
	


func _on_food1minus_pressed():
	food1 = int($MainContainer/MiddleLine/Middle1/HBoxContainer/LineEdit.text)
	if food1 == 0:
		return
	food1 -= 1
	$MainContainer/MiddleLine/Middle1/HBoxContainer/LineEdit.text = str(food1)


func _on_food2plus_pressed():
	food2 = int($MainContainer/MiddleLine/Middle2/HBoxContainer/LineEdit.text)
	food2 += 1
	$MainContainer/MiddleLine/Middle2/HBoxContainer/LineEdit.text = str(food2)

func _on_food2minus_pressed():
	food2 = int($MainContainer/MiddleLine/Middle2/HBoxContainer/LineEdit.text)
	if food2 == 0:
		return
	food2 -= 1
	$MainContainer/MiddleLine/Middle2/HBoxContainer/LineEdit.text = str(food2)

