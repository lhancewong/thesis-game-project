extends Node
var regex = RegEx.new()
var edibleToLandfill = 0
var inedibleToLandfill = 0
var edible_waste_amount = 0
var inedible_waste_amount = 0
var inedible_oldtext = ""
var edible_oldtext = ""

onready var inedibleWasteLabel = $VBoxContainer/HBoxContainer/Landfill/InedibleWaste/Amount/InedibleAmnt
onready var edibleWasteLabel = $VBoxContainer/HBoxContainer/Landfill/EdibleWaste/Amount/EdibleAmnt
onready var inedibleActionLineEdit = $VBoxContainer/HBoxContainer/Landfill/InedibleWaste/HBoxContainer/LineEdit
onready var edibleActionLineEdit = $VBoxContainer/HBoxContainer/Landfill/EdibleWaste/HBoxContainer/LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
    _update_labels()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    _update_labels()

func _update_labels():
    edible_waste_amount = Game.waste_hndlr.get_str_edible_waste()
    inedible_waste_amount = Game.waste_hndlr.get_str_inedible_waste()
    $VBoxContainer/HBoxContainer/Landfill/InedibleWaste/Amount/InedibleAmnt.text = str(inedible_waste_amount)
    $VBoxContainer/HBoxContainer/Landfill/EdibleWaste/Amount/EdibleAmnt.text = str(edible_waste_amount) 
    $VBoxContainer/HBoxContainer/Landfill/TotalWaste/Amount/MgmtLabel2.text = str(edibleToLandfill + inedibleToLandfill)




func _on_TrashButton_pressed():
    if edibleToLandfill == 0 && inedibleToLandfill == 0:
        return
    else:
        if edibleToLandfill > 0:
            print(Game.waste_hndlr.get_str_edible_waste())
            Game.waste_hndlr.manage_waste("landfill", 1, edibleToLandfill, 1)
            print(Game.waste_hndlr.get_str_edible_waste())
        if inedibleToLandfill > 0:
            print(Game.waste_hndlr.get_str_inedible_waste())
            Game.waste_hndlr.manage_waste("landfill", 0, inedibleToLandfill, 1)
            print(Game.waste_hndlr.get_str_inedible_waste())
        edibleToLandfill = 0
        inedibleToLandfill = 0


func _on_inedible_minus_pressed():
    if inedibleToLandfill == 0:
        return
    else:
        inedibleToLandfill -= 1
        inedibleActionLineEdit.text = str(inedibleToLandfill)


func _on_inedible_plus_pressed():
    if inedibleToLandfill < int(inedible_waste_amount):
        inedibleToLandfill += 1
        inedibleActionLineEdit.text = str(inedibleToLandfill)
    else:
        pass


func _on_inedibleLineEdit_text_changed(new_text):
    if regex.search(new_text):
        inedible_oldtext = str(new_text)
    else:
        inedibleActionLineEdit.text = inedible_oldtext
        inedibleActionLineEdit.set_cursor_position(inedibleActionLineEdit.text.length())




func _on_edible_minus_pressed():
    if edibleToLandfill == 0:
        return
    else:
        edibleToLandfill -= 1
        edibleActionLineEdit.text = str(edibleToLandfill)


func _on_edible_plus_pressed():
    if edibleToLandfill < int(edible_waste_amount):
        edibleToLandfill += 1
        edibleActionLineEdit.text = str(edibleToLandfill)
    else:
        pass


func _on_edibleLineEdit_text_changed(new_text):
    if regex.search(new_text):
        edible_oldtext = str(new_text)
    else:
        edibleActionLineEdit.text = edible_oldtext
        edibleActionLineEdit.set_cursor_position(edibleActionLineEdit.text.length())
