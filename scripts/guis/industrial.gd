extends Control
var regex = RegEx.new()

var disposal_amount = 0
var old_text = ""

onready var action_line_edit = $VBoxContainer/HBoxContainer/Industrial/Strategy/HBoxContainer/LineEdit
onready var inedible_waste_amnt = $VBoxContainer/HBoxContainer/Industrial/Waste/Amount/InedibleWasteAmnt


# Called when the node enters the scene tree for the first time.
func _ready():
	inedible_waste_amnt.text = str(Game.inedible_waste)
	action_line_edit.text = str(disposal_amount)
	regex.compile("^[0-9]*$")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	inedible_waste_amnt.text = str(Game.inedible_waste)


# Calls manage_waste and resets value
func _on_sendButton_pressed():
	if (disposal_amount) * 10 > Game.money:
		SoundHandler.angry_noise.play()
		return
	if disposal_amount == 0:
		SoundHandler.angry_noise.play()
		return
	if (
		Game.strat_hndlr.cap_checker("industrial")
		|| (
			disposal_amount + Game.strategy_use_tracker["industrial"]
			> Game.strategy_cap["industrial"]
		)
	):
		SoundHandler.angry_noise.play()
		return
	Game.money -= (disposal_amount) * 10
	Game.strategy_use_tracker["industrial"] += disposal_amount
	Game.waste_hndlr.manage_waste("industrial", "inedible_waste", disposal_amount, Game.day)
	disposal_amount = 0
	action_line_edit.text = str(disposal_amount)
	SoundHandler.button_click_two.play()


func _on_LineEdit_text_changed(new_text):
	if regex.search(new_text):
		if int(new_text) > Game.inedible_waste:
			print("overload")
			new_text = Game.inedible_waste
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
	if disposal_amount < Game.inedible_waste:
		disposal_amount += 1
		action_line_edit.text = str(disposal_amount)
