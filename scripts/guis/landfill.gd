extends Node
var regex = RegEx.new()
var edibleToLandfill: int = 0
var inedibleToLandfill: int = 0
var inedible_oldtext = ""
var edible_oldtext = ""

onready var inedibleWasteLabel = $VBoxContainer/HBoxContainer/Landfill/InedibleWaste/Amount/InedibleAmnt
onready var edibleWasteLabel = $VBoxContainer/HBoxContainer/Landfill/EdibleWaste/Amount/EdibleAmnt
onready var inedibleActionLineEdit = $VBoxContainer/HBoxContainer/Landfill/InedibleWaste/HBoxContainer/LineEdit
onready var edibleActionLineEdit = $VBoxContainer/HBoxContainer/Landfill/EdibleWaste/HBoxContainer/LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	_update_labels()
	regex.compile("^[0-9]*$")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	_update_labels()


func _update_labels():
	$VBoxContainer/HBoxContainer/Landfill/InedibleWaste/Amount/InedibleAmnt.text = str(
		Game.inedible_waste
	)
	$VBoxContainer/HBoxContainer/Landfill/EdibleWaste/Amount/EdibleAmnt.text = str(
		Game.edible_waste
	)
	$VBoxContainer/HBoxContainer/Landfill/TotalWaste/Amount/MgmtLabel2.text = str(
		edibleToLandfill + inedibleToLandfill
	)


func _on_TrashButton_pressed():
	Game.money -= (edibleToLandfill + inedibleToLandfill) * 10
	if edibleToLandfill == 0 && inedibleToLandfill == 0:
		return
	else:
		if edibleToLandfill > 0:
			print(Game.waste_hndlr.get_str_edible_waste())
			Game.waste_hndlr.manage_waste("landfill", "edible_waste", edibleToLandfill, Game.day)
			print(Game.waste_hndlr.get_str_edible_waste())
		if inedibleToLandfill > 0:
			print(Game.waste_hndlr.get_str_inedible_waste())
			Game.waste_hndlr.manage_waste(
				"landfill", "inedible_waste", inedibleToLandfill, Game.day
			)
			print(Game.waste_hndlr.get_str_inedible_waste())
		edibleToLandfill = 0
		inedibleToLandfill = 0
	edibleActionLineEdit.text = str(edibleToLandfill)
	inedibleActionLineEdit.text = str(inedibleToLandfill)


func _on_inedible_minus_pressed():
	if inedibleToLandfill == 0:
		return
	else:
		inedibleToLandfill -= 1
		inedibleActionLineEdit.text = str(inedibleToLandfill)


func _on_inedible_plus_pressed():
	if inedibleToLandfill < Game.inedible_waste:
		inedibleToLandfill += 1
		inedibleActionLineEdit.text = str(inedibleToLandfill)
	else:
		pass


func _on_inedibleLineEdit_text_changed(new_text):
	if regex.search(new_text):
		print("inedibleaccept")
		inedible_oldtext = str(new_text)
		if int(new_text) > Game.inedible_waste:
			print("overload")
			new_text = Game.inedible_waste
		inedible_oldtext = str(new_text)
		inedibleToLandfill = int(new_text)
		inedibleActionLineEdit.text = inedible_oldtext
		inedibleActionLineEdit.set_cursor_position(inedibleActionLineEdit.text.length())
	else:
		print("inediblerejet")
		inedibleActionLineEdit.text = inedible_oldtext
		inedibleActionLineEdit.set_cursor_position(inedibleActionLineEdit.text.length())


func _on_edible_minus_pressed():
	if edibleToLandfill == 0:
		return
	else:
		edibleToLandfill -= 1
		edibleActionLineEdit.text = str(edibleToLandfill)


func _on_edible_plus_pressed():
	if edibleToLandfill < Game.edible_waste:
		edibleToLandfill += 1
		edibleActionLineEdit.text = str(edibleToLandfill)
	else:
		pass


func _on_edibleLineEdit_text_changed(new_text):
	if regex.search(new_text):
		if int(new_text) > Game.edible_waste:
			print("overload")
			new_text = Game.edible_waste
		edible_oldtext = str(new_text)
		edibleToLandfill = int(new_text)
		edibleActionLineEdit.text = edible_oldtext
		edibleActionLineEdit.set_cursor_position(edibleActionLineEdit.text.length())
	else:
		edibleActionLineEdit.text = edible_oldtext
		edibleActionLineEdit.set_cursor_position(edibleActionLineEdit.text.length())
