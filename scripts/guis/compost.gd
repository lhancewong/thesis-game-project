extends Control
var regex = RegEx.new()

var compost_amount: int = 0
var old_text = ""

onready var action_line_edit = $VBoxContainer/HBoxContainer/Compost/Strategy/HBoxContainer2/LineEdit
onready var inedible_waste_amnt = $VBoxContainer/HBoxContainer/Compost/Waste/Amount/InedibleWasteAmnt


func _ready():
	inedible_waste_amnt.text = str(Game.inedible_waste)
	action_line_edit.text = str(compost_amount)
	regex.compile("^[0-9]*$")


func _physics_process(delta):
	inedible_waste_amnt.text = str(Game.inedible_waste)


# Calls manage_waste and resets value
func _on_sendButton_pressed():
	if compost_amount == 0:
		SoundHandler.angry_noise.play()
		return
	compost_stack_add(compost_amount)
	Game.waste_hndlr.manage_waste("composting", "inedible_waste", compost_amount, Game.day)
	compost_amount = 0
	action_line_edit.text = str(compost_amount)
	print(Game.compost_stack)
	SoundHandler.button_click_two.play()


func _on_LineEdit_text_changed(new_text):
	if regex.search(new_text):
		if int(new_text) > Game.inedible_waste:
			print("overload")
			new_text = Game.inedible_waste
		old_text = str(new_text)
		compost_amount = int(new_text)
		action_line_edit.text = old_text
		action_line_edit.set_cursor_position(action_line_edit.text.length())
	else:
		action_line_edit.text = old_text
		action_line_edit.set_cursor_position(action_line_edit.text.length())


# These changes the value of the amount to be composted using the buttons
func _on_minus_pressed():
	SoundHandler.value_change.play()
	if compost_amount == 0:
		return
	else:
		compost_amount -= 1
		action_line_edit.text = str(compost_amount)


func _on_plus_pressed():
	SoundHandler.value_change.play()
	if compost_amount < Game.inedible_waste:
		compost_amount += 1
		action_line_edit.text = str(compost_amount)


# creates an array that compiles the amount composted per day and only keeps last 3 days
func compost_stack_add(amount):
	if Game.last_compost_day != Game.day:
#		if Game.day - Game.last_compost_day > 1:
#			for i in range(Game.day - Game.last_compost_day - 1):
#				Game.compost_stack.append(0)
		Game.last_compost_day = Game.day
		Game.compost_stack.append(amount)
	else:
		Game.compost_stack[-1] += amount
	Game.compost_stack = Game.compost_stack.slice(-3, Game.compost_stack.size())
