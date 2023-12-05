extends Node
var regex = RegEx.new()
var ewaste_to_landfill: int = 0
var iwaste_to_landfill: int = 0
var inedible_old_text = ""
var edible_old_text = ""

onready var inedible_waste_label = $VBoxContainer/HBoxContainer/Landfill/InedibleWaste/Amount/InedibleAmnt
onready var edible_waste_label = $VBoxContainer/HBoxContainer/Landfill/EdibleWaste/Amount/EdibleAmnt
onready var total_waste_label = $VBoxContainer/HBoxContainer/Landfill/TotalWaste/Amount/TotalWasteLabel
onready var inedible_action_line_edit = $VBoxContainer/HBoxContainer/Landfill/InedibleWaste/HBoxContainer/LineEdit
onready var edible_action_line_edit = $VBoxContainer/HBoxContainer/Landfill/EdibleWaste/HBoxContainer/LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	_update_labels()
	regex.compile("^[0-9]*$")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	_update_labels()


func _update_labels():
	inedible_waste_label.text = str(Game.inedible_waste)
	edible_waste_label.text = str(Game.edible_waste)
	total_waste_label.text = str(Game.inedible_waste + Game.edible_waste)


func _on_TrashButton_pressed():
	Game.money -= (ewaste_to_landfill + iwaste_to_landfill) * 10
	if ewaste_to_landfill == 0 && iwaste_to_landfill == 0:
		SoundHandler.angry_noise.play()
		return
	else:
		if ewaste_to_landfill > 0:
			print(Game.waste_hndlr.get_str_edible_waste())
			Game.waste_hndlr.manage_waste("landfill", "edible_waste", ewaste_to_landfill, Game.day)
			print(Game.waste_hndlr.get_str_edible_waste())
		if iwaste_to_landfill > 0:
			print(Game.waste_hndlr.get_str_inedible_waste())
			Game.waste_hndlr.manage_waste(
				"landfill", "inedible_waste", iwaste_to_landfill, Game.day
			)
			print(Game.waste_hndlr.get_str_inedible_waste())
		ewaste_to_landfill = 0
		iwaste_to_landfill = 0
	edible_action_line_edit.text = str(ewaste_to_landfill)
	inedible_action_line_edit.text = str(iwaste_to_landfill)
	SoundHandler.crimson_moon.play()


func _on_inedible_minus_pressed():
	if iwaste_to_landfill == 0:
		return
	else:
		iwaste_to_landfill -= 1
		inedible_action_line_edit.text = str(iwaste_to_landfill)


func _on_inedible_plus_pressed():
	SoundHandler.value_change.play()
	if iwaste_to_landfill < Game.inedible_waste:
		iwaste_to_landfill += 1
		inedible_action_line_edit.text = str(iwaste_to_landfill)


func _on_inedibleLineEdit_text_changed(new_text):
	if regex.search(new_text):
		print("inedibleaccept")
		inedible_old_text = str(new_text)
		if int(new_text) > Game.inedible_waste:
			print("overload")
			new_text = Game.inedible_waste
		inedible_old_text = str(new_text)
		iwaste_to_landfill = int(new_text)
		inedible_action_line_edit.text = inedible_old_text
		inedible_action_line_edit.set_cursor_position(inedible_action_line_edit.text.length())
	else:
		print("inediblerejet")
		inedible_action_line_edit.text = inedible_old_text
		inedible_action_line_edit.set_cursor_position(inedible_action_line_edit.text.length())


func _on_edible_minus_pressed():
	SoundHandler.value_change.play()
	if ewaste_to_landfill == 0:
		return
	else:
		ewaste_to_landfill -= 1
		edible_action_line_edit.text = str(ewaste_to_landfill)


func _on_edible_plus_pressed():
	SoundHandler.value_change.play()
	if ewaste_to_landfill < Game.edible_waste:
		ewaste_to_landfill += 1
		edible_action_line_edit.text = str(ewaste_to_landfill)


func _on_edibleLineEdit_text_changed(new_text):
	if regex.search(new_text):
		if int(new_text) > Game.edible_waste:
			print("overload")
			new_text = Game.edible_waste
		edible_old_text = str(new_text)
		ewaste_to_landfill = int(new_text)
		edible_action_line_edit.text = edible_old_text
		edible_action_line_edit.set_cursor_position(edible_action_line_edit.text.length())
	else:
		edible_action_line_edit.text = edible_old_text
		edible_action_line_edit.set_cursor_position(edible_action_line_edit.text.length())
