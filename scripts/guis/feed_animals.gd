extends Control
var regex = RegEx.new()

var disposal_amount: int = 0
var old_text = ""

onready var action_line_edit = $VBoxContainer/HBoxContainer/LeftBlock/Strategy/HBoxContainer2/LineEdit
onready var inedible_waste_amnt = $VBoxContainer/HBoxContainer/LeftBlock/Waste/Amount/InedibleWasteAmnt


func _ready():
	inedible_waste_amnt.text = str("%.2f" % Game.edible_waste)
	action_line_edit.text = str(disposal_amount)
	regex.compile("^[0-9]*$")


func _physics_process(delta):
	inedible_waste_amnt.text = str("%.2f" % Game.edible_waste)
	disposal_amount = int(action_line_edit.text)


# Calls manage_waste and resets value
func _on_sendButton_pressed():
	if disposal_amount == 0:
		SoundHandler.angry_noise.play()
		return
	elif (disposal_amount) * 2 > Game.money:
		SoundHandler.angry_noise.play()
		return
	if (
		Game.strat_hndlr.cap_checker("feed_animals")
		|| (
			disposal_amount + Game.strategy_use_tracker["feed_animals"]
			> Game.strategy_cap["feed_animals"]
		)
	):
		SoundHandler.angry_noise.play()
		return
	Game.money -= (disposal_amount) * 2
	Game.strategy_use_tracker["feed_animals"] += disposal_amount
	Game.waste_hndlr.manage_waste("feed_animals", "edible_waste", disposal_amount, Game.day)
	Game.buffs_hndlr.add_animals_buff(disposal_amount)
	disposal_amount = 0
	action_line_edit.text = str(disposal_amount)
	SoundHandler.button_click_two.play()


func _on_LineEdit_text_changed(new_text):
	if regex.search(new_text):
		if int(new_text) > Game.edible_waste:
			new_text = Game.edible_waste
		old_text = str(new_text)
		disposal_amount = int(new_text)
		action_line_edit.text = old_text
		action_line_edit.set_cursor_position(action_line_edit.text.length())
	else:
		action_line_edit.text = old_text
		action_line_edit.set_cursor_position(action_line_edit.text.length())


func _on_minus_pressed():
	SoundHandler.value_change.play()
	if disposal_amount == 0:
		return
	else:
		disposal_amount -= 1
		action_line_edit.text = str(disposal_amount)


func _on_plus_pressed():
	SoundHandler.value_change.play()
	if disposal_amount < Game.edible_waste:
		disposal_amount += 1
		action_line_edit.text = str(disposal_amount)
