extends Node

var edibleToLandfill = 0
var inedibleToLandfill = 0

# Called when the node enters the scene tree for the first time.
func _ready():
    _update_labels()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    _update_labels()

func _update_labels():
    $VBoxContainer/HBoxContainer/Landfill/InedibleWaste/Amount/InedibleAmnt.text = str(inedibleToLandfill)
    $VBoxContainer/HBoxContainer/Landfill/EdibleWaste/Amount/EdibleAmnt.text = str(edibleToLandfill)


func _on_InedibleSlider_value_changed(value):
    inedibleToLandfill = $VBoxContainer/HBoxContainer/VBoxContainer/InedibleWaste/HSlider.value


func _on_EdibleSlider_value_changed(value):
    edibleToLandfill = $"VBoxContainer/HBoxContainer/VBoxContainer/Edible Waste/HSlider".value


func _on_TrashButton_pressed():
    if edibleToLandfill == 0 && inedibleToLandfill == 0:
        return
    else:
        if edibleToLandfill > 0:
            print(Game.waste_hndlr.get_edible_waste())
            Game.waste_hndlr.manage_waste("landfill", 1, edibleToLandfill, 1)
            print(Game.waste_hndlr.get_edible_waste())
        if inedibleToLandfill > 0:
            print(Game.waste_hndlr.get_inedible_waste())
            Game.waste_hndlr.manage_waste("landfill", 0, inedibleToLandfill, 1)
            print(Game.waste_hndlr.get_inedible_waste())
        edibleToLandfill = 0
        inedibleToLandfill = 0
