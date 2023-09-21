extends Control


# Declare member variables here. Examples:
export(Resource) var waste_handler
var waste_amount = 0
var compost_amount = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/HBoxContainer/Compost/Waste/Amount/InedibleWasteAmnt.text = str(waste_amount)
	$VBoxContainer/HBoxContainer/Compost/Strategy/Amount/CompostAmnt.text = str(compost_amount)
	$VBoxContainer/HBoxContainer/Compost/Strategy/HSlider.max_value = waste_amount


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	waste_amount = waste_handler.get_inedible_waste()
	$VBoxContainer/HBoxContainer/Compost/Waste/Amount/InedibleWasteAmnt.text = str(waste_amount)
	$VBoxContainer/HBoxContainer/Compost/Strategy/Amount/CompostAmnt.text = str(compost_amount)
	$VBoxContainer/HBoxContainer/Compost/Strategy/HSlider.max_value = float(waste_amount)

# This changes the value of the amount to be composted using the slider
func _on_HSlider_value_changed(value):
	compost_amount = $VBoxContainer/HBoxContainer/Compost/Strategy/HSlider.value

# Calls manage_waste and resets slider value
func _on_sendButton_pressed():
	if compost_amount == 0:
		return
	waste_handler.manage_waste("composting", 1, compost_amount, 1)
	compost_amount = 0
	$VBoxContainer/HBoxContainer/Compost/Strategy/HSlider.value = 0
