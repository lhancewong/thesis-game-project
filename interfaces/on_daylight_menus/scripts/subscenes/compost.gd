extends Control
var regex = RegEx.new()

var waste_amount = 0
var compost_amount = 0
var old_text = ""

onready var CompostLineEdit = $VBoxContainer/HBoxContainer/Compost/Strategy/HBoxContainer2/LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/HBoxContainer/Compost/Waste/Amount/InedibleWasteAmnt.text = str(waste_amount)
	CompostLineEdit.text = str(compost_amount)
	regex.compile("^[0-9]*$")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	waste_amount = Game.waste_hndlr.get_inedible_waste()
	$VBoxContainer/HBoxContainer/Compost/Waste/Amount/InedibleWasteAmnt.text = str(waste_amount)

# This changes the value of the amount to be composted using the buttons


# Calls manage_waste and resets value
func _on_sendButton_pressed():
	if compost_amount == 0:
		return
	Game.waste_hndlr.manage_waste("composting", 0, compost_amount, 1)
	compost_amount = 0
	CompostLineEdit.text = str(compost_amount)


func _on_LineEdit_text_changed(new_text):
	if regex.search(new_text):
		old_text = str(new_text)
#		beef_amount = int(new_text)
	else:
		CompostLineEdit.text = old_text
		CompostLineEdit.set_cursor_position(CompostLineEdit.text.length())


func _on_minus_pressed():
	if compost_amount == 0:
		return
	else:
		compost_amount -= 1
		CompostLineEdit.text = str(compost_amount)
	


func _on_plus_pressed():
	compost_amount += 1
	CompostLineEdit.text = str(compost_amount)
