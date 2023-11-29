extends Control
var regex = RegEx.new()

var compost_amount: int = 0
var old_text = ""
#var compost_stack = []
#var last_compost_day = 0

onready var ActionLineEdit = $VBoxContainer/HBoxContainer/Compost/Strategy/HBoxContainer2/LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/HBoxContainer/Compost/Waste/Amount/InedibleWasteAmnt.text = str(
		Game.inedible_waste
	)
	ActionLineEdit.text = str(compost_amount)
	regex.compile("^[0-9]*$")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$VBoxContainer/HBoxContainer/Compost/Waste/Amount/InedibleWasteAmnt.text = str(
		Game.inedible_waste
	)


# Calls manage_waste and resets value
func _on_sendButton_pressed():
	if compost_amount == 0:
		return
	compost_stack_add(compost_amount)
	Game.waste_hndlr.manage_waste("composting", "inedible_waste", compost_amount, Game.day)
	compost_amount = 0
	ActionLineEdit.text = str(compost_amount)
	print(Game.compost_stack)


func _on_LineEdit_text_changed(new_text):
	if regex.search(new_text):
		if int(new_text) > Game.inedible_waste:
			print("overload")
			new_text = Game.inedible_waste
		old_text = str(new_text)
		compost_amount = int(new_text)
		ActionLineEdit.text = old_text
		ActionLineEdit.set_cursor_position(ActionLineEdit.text.length())
	else:
		ActionLineEdit.text = old_text
		ActionLineEdit.set_cursor_position(ActionLineEdit.text.length())


# These changes the value of the amount to be composted using the buttons
func _on_minus_pressed():
	if compost_amount == 0:
		return
	else:
		compost_amount -= 1
		ActionLineEdit.text = str(compost_amount)


func _on_plus_pressed():
	if compost_amount < Game.inedible_waste:
		compost_amount += 1
		ActionLineEdit.text = str(compost_amount)
	else:
		pass


# creates an array that compiles the amount composted per day and only keeps last 3 days
func compost_stack_add(amount):
	if Game.last_compost_day != Game.day:
		if Game.day - Game.last_compost_day > 1:
			for i in range(Game.day - Game.last_compost_day - 1):
				Game.compost_stack.append(0)
		Game.last_compost_day = Game.day
		Game.compost_stack.append(amount)
	else:
		Game.compost_stack[-1] += amount
	Game.compost_stack = Game.compost_stack.slice(-3, Game.compost_stack.size())
