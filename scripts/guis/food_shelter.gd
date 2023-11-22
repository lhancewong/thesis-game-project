extends Control
var regex = RegEx.new()

var disposal_amount: int = 0
var old_text = ""

onready var ActionLineEdit = $"VBoxContainer/HBoxContainer/Left Block/Strategy/HBoxContainer2/LineEdit"

# Called when the node enters the scene tree for the first time.
func _ready():
  $"VBoxContainer/HBoxContainer/Left Block/Waste/Amount/InedibleWasteAmnt".text = str(Game.edible_waste)
  ActionLineEdit.text = str(disposal_amount)
  regex.compile("^[0-9]*$")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
  $"VBoxContainer/HBoxContainer/Left Block/Waste/Amount/InedibleWasteAmnt".text = str(Game.edible_waste)

# This changes the value of the amount to be composted using the buttons


# Calls manage_waste and resets value
func _on_sendButton_pressed():
  if disposal_amount == 0:
    return
  Game.waste_hndlr.manage_waste("food_shelter", 1, disposal_amount, 1)
  disposal_amount = 0
  ActionLineEdit.text = str(disposal_amount)


func _on_LineEdit_text_changed(new_text):
  if regex.search(new_text):
    if int(new_text) > Game.edible_waste:
      print("overload")
      new_text = Game.edible_waste
    old_text = str(new_text)
    disposal_amount = int(new_text)
    ActionLineEdit.text = old_text
    ActionLineEdit.set_cursor_position(ActionLineEdit.text.length())
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
  if disposal_amount < Game.edible_waste:
    disposal_amount += 1
    ActionLineEdit.text = str(disposal_amount)
  else:
    pass
