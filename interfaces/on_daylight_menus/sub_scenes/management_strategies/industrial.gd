extends Control
var regex = RegEx.new()

var inedible_waste_amount = 0
var disposal_amount = 0
var old_text = ""

onready var ActionLineEdit = $VBoxContainer/HBoxContainer/Industrial/Strategy/HBoxContainer/LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/HBoxContainer/Industrial/Waste/Amount/InedibleWasteAmnt.text = str(inedible_waste_amount)
	ActionLineEdit.text = str(disposal_amount)
	regex.compile("^[0-9]*$")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	inedible_waste_amount = Game.waste_hndlr.get_inedible_waste()
	$VBoxContainer/HBoxContainer/Industrial/Waste/Amount/InedibleWasteAmnt.text = str(inedible_waste_amount)

# This changes the value of the amount to be composted using the buttons


# Calls manage_waste and resets value
func _on_sendButton_pressed():
	if disposal_amount == 0:
		return
	Game.waste_hndlr.manage_waste("industrial", 0, disposal_amount, 1)
	disposal_amount = 0
	ActionLineEdit.text = str(disposal_amount)


func _on_LineEdit_text_changed(new_text):
	if regex.search(new_text):
		old_text = str(new_text)
#		beef_amount = int(new_text)
	else:
		ActionLineEdit.text = old_text
		ActionLineEdit.set_cursor_position(ActionLineEdit.text.length())


func _on_minus_pressed():
	if disposal_amount == 0:
		return
	else:
		disposal_amount -= 1
		ActionLineEdit.text = str(disposal_amount)
	


func _on_plus_pressed():
	if disposal_amount < int(inedible_waste_amount):
		disposal_amount += 1
		ActionLineEdit.text = str(disposal_amount)
	else:
		pass
