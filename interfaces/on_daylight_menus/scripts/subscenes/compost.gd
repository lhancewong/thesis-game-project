extends Control


# Declare member variables here. Examples:
export(Resource) var waste_handler
var waste_amount = 0
var compost_amount = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	waste_amount = waste_handler.returnInedibleWaste()
	$VBoxContainer/HBoxContainer/Compost/Waste/Amount/InedibleWasteAmnt.text = str(waste_amount)
	$VBoxContainer/HBoxContainer/Compost/Strategy/Amount/CompostAmnt.text = str(compost_amount)
	$VBoxContainer/HBoxContainer/Compost/Strategy/HSlider.max_value = waste_amount


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# This changes the value of the amount to be composted using the slider
func _on_HSlider_value_changed(value):
	compost_amount = $VBoxContainer/HBoxContainer/Compost/Strategy/HSlider.value
	_ready()



# TODO: Make Send button work
func _on_sendButton_pressed():
	pass # Replace with function body.
