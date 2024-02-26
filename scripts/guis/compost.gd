extends Control
var regex = RegEx.new()

var compost_amount: int = 0
var old_text = ""

onready var action_line_edit = $VBoxContainer/HBoxContainer/Compost/Top/Strategy/HBoxContainer2/LineEdit
onready var inedible_waste_amnt = $VBoxContainer/HBoxContainer/Compost/Top/Waste/Amount/InedibleWasteAmnt
onready var composted_amount = $VBoxContainer/HBoxContainer/Compost/Bottom/Strategy/HBoxContainer2/Amount/CompostedAmount


func _ready():
	inedible_waste_amnt.text = str(Game.inedible_waste)
	action_line_edit.text = str(compost_amount)
	composted_amount.text = str(Game.get_compost_stack_sum())
	regex.compile("^[0-9]*$")


func _physics_process(delta):
	inedible_waste_amnt.text = str(Game.inedible_waste)


# Calls manage_waste and resets value
func _on_sendButton_pressed():
	if compost_amount == 0:
		SoundHandler.angry_noise.play()
		return
	elif (
		Game.strat_hndlr.cap_checker("composting")
		|| (
			compost_amount + Game.strategy_use_tracker["composting"]
			> Game.strategy_cap["composting"]
		)
	):
		SoundHandler.angry_noise.play()
		return
	else:
		Game.strategy_use_tracker["composting"] += compost_amount
		Game.compost_stack_add(compost_amount)
		Game.waste_hndlr.manage_waste("composting", "inedible_waste", compost_amount, Game.day)
		compost_amount = 0
		action_line_edit.text = str(compost_amount)
		print(Game.compost_stack)
		composted_amount.text = str(Game.get_compost_stack_sum())
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
