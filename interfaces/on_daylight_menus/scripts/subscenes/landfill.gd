extends Node


export(Resource) var waste_handler
var edibleToLandfill = 0
var inedibleToLandfill = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/HBoxContainer/VBoxContainer/InedibleWaste/HSlider.max_value = waste_handler.returnInedibleWaste()
	$"VBoxContainer/HBoxContainer/VBoxContainer/Edible Waste/HSlider".max_value = waste_handler.returnEdibleWaste()
	$VBoxContainer/HBoxContainer/VBoxContainer/InedibleWaste/Amount/InedibleAmnt.text = str(inedibleToLandfill)
	$"VBoxContainer/HBoxContainer/VBoxContainer/Edible Waste/Amount/EdibleAmnt".text = str(edibleToLandfill)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$VBoxContainer/HBoxContainer/VBoxContainer/InedibleWaste/HSlider.max_value = waste_handler.returnInedibleWaste()
	$"VBoxContainer/HBoxContainer/VBoxContainer/Edible Waste/HSlider".max_value = waste_handler.returnEdibleWaste()
	$VBoxContainer/HBoxContainer/VBoxContainer/InedibleWaste/Amount/InedibleAmnt.text = str(inedibleToLandfill)
	$"VBoxContainer/HBoxContainer/VBoxContainer/Edible Waste/Amount/EdibleAmnt".text = str(edibleToLandfill)


func _on_InedibleSlider_value_changed(value):
	inedibleToLandfill = $VBoxContainer/HBoxContainer/VBoxContainer/InedibleWaste/HSlider.value


func _on_EdibleSlider_value_changed(value):
	edibleToLandfill = $"VBoxContainer/HBoxContainer/VBoxContainer/Edible Waste/HSlider".value


func _on_TrashButton_pressed():
	if edibleToLandfill == 0 && inedibleToLandfill == 0:
		return
	else:
		if edibleToLandfill > 0:
			print(waste_handler.returnEdibleWaste())
			waste_handler.manage_waste("landfill", 1, edibleToLandfill, 1)
			print(waste_handler.returnEdibleWaste())
		if inedibleToLandfill > 0:
			print(waste_handler.returnInedibleWaste())
			waste_handler.manage_waste("landfill", 0, inedibleToLandfill, 1)
			print(waste_handler.returnInedibleWaste())
		edibleToLandfill = 0
		inedibleToLandfill = 0
		$"VBoxContainer/HBoxContainer/VBoxContainer/Edible Waste/HSlider".value = 0
		$VBoxContainer/HBoxContainer/VBoxContainer/InedibleWaste/HSlider.value = 0
	
	
