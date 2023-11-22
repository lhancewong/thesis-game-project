extends Control

var regex = RegEx.new()
var chicken_old_text = ""
var beef_old_text = ""
var pork_old_text = ""
var curry_old_text = ""

onready var chicken_amount = 1
onready var chicken_line_edit = $VBoxContainer/Order/Chicken/HBoxContainer/LineEdit

onready var beef_amount = 1
onready var beef_line_edit = $VBoxContainer/Order/Beef/HBoxContainer/LineEdit

onready var pork_amount = 1
onready var pork_line_edit = $VBoxContainer/Order/Pork/HBoxContainer/LineEdit

onready var curry_amount = 1
onready var curry_line_edit = $VBoxContainer/Order/Curry/HBoxContainer/LineEdit

onready var stock_chicken = $VBoxContainer/Storage/Chicken/Amount/Amount
onready var stock_beef = $VBoxContainer/Storage/Beef/Amount/Amount
onready var stock_pork = $VBoxContainer/Storage/Pork/Amount/Amount
onready var stock_curry = $VBoxContainer/Storage/CurryStock/Amount/Amount


# Called when the node enters the scene tree for the first time.
func _ready():
  _update_labels()
  regex.compile("^[0-9]*$")
  chicken_line_edit.text = str(chicken_amount)
  pork_line_edit.text = str(pork_amount)
  beef_line_edit.text = str(beef_amount)
  curry_line_edit.text = str(curry_amount)

func _physics_process(delta): # change to signals
  _update_labels()

func _update_labels(): 
  var stockpile = Game.i_stockpile
  
  stock_chicken.text = str(stockpile["chicken"]) + " batches"
  stock_beef.text = str(stockpile["beef"]) + " batches"
  stock_pork.text = str(stockpile["pork"]) + " batches"
  stock_curry.text = str(stockpile["curry_powder"]) + " batches"

func amnt_minus(amnt):
  if amnt == 0:
    return "0"
  amnt -= 1
  return amnt



func _on_ChickenBuy_pressed():
  Game.ingred_hndlr.buy_ingredients('Chicken', chicken_amount)
  chicken_line_edit.text = str(chicken_amount)

func _on_Chicken_minus_pressed():
  chicken_amount -= 1
  if chicken_amount < 0:
    chicken_amount = 0
    chicken_line_edit.text = str(chicken_amount)

func _on_Chicken_plus_pressed():
  chicken_amount += 1
  chicken_line_edit.text = str(chicken_amount)

func _on_ChickenLine_text_changed(new_text):
  if regex.search(new_text):
    chicken_old_text = str(new_text)
    chicken_amount = int(new_text)
  else:
    chicken_line_edit.text = str(chicken_old_text)
    chicken_line_edit.set_cursor_position(chicken_line_edit.text.length())



func _on_BeefBuy_pressed():
  Game.ingred_hndlr.buy_ingredients('Beef', beef_amount)
  beef_line_edit.text = str(beef_amount)

func _on_Beef_minus_pressed():
  beef_amount -= 1
  if beef_amount < 0:
    beef_amount = 0
    beef_line_edit.text = str(beef_amount)

func _on_Beef_plus_pressed():
  beef_amount += 1 
  beef_line_edit.text = str(beef_amount)

func _on_BeefLine_text_changed(new_text):
  if regex.search(new_text):
    beef_old_text = str(new_text)
    beef_amount = int(new_text)
  else:
    beef_line_edit.text = beef_old_text
    beef_line_edit.set_cursor_position(beef_line_edit.text.length())



func _on_PorkBuy_pressed():
  Game.ingred_hndlr.buy_ingredients('Pork', pork_amount)
  pork_line_edit.text = str(pork_amount)

func _on_Pork_minus_pressed():
  pork_amount -= 1
  if pork_amount < 0:
    pork_amount = 0
    pork_line_edit.text = str(pork_amount)

func _on_Pork_plus_pressed():
  pork_amount += 1
  pork_line_edit.text = str(pork_amount)

func _on_PorkLine_text_changed(new_text):
  if regex.search(new_text):
    pork_old_text = str(new_text)
    pork_amount = int(new_text)
  else:
    pork_line_edit.text = pork_old_text
    pork_line_edit.set_cursor_position(pork_line_edit.text.length())



func _on_CurryBuy_pressed():
  Game.ingred_hndlr.buy_ingredients('Curry Powder', curry_amount)
  curry_line_edit.text = str(curry_amount)

func _on_Curry_minus_pressed():
  curry_amount -= 1
  if curry_amount < 0:
    curry_amount = 0
    curry_line_edit.text = str(curry_amount)

func _on_Curry_plus_pressed():
  curry_amount += 1
  curry_line_edit.text = str(curry_amount)

func _on_CurryLine_text_changed(new_text):
  if regex.search(new_text):
    curry_old_text = str(new_text)
    curry_amount = int(new_text)
  else:
    curry_line_edit.text = curry_old_text
    curry_line_edit.set_cursor_position(curry_line_edit.text.length())
