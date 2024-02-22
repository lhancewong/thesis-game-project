extends Control

onready var chkn_label = $"%ChknLabel"
onready var pork_label = $"%PorkLabel"
onready var beef_label = $"%BeefLabel"
onready var lemonade_label = $"%LemonadeLabel"
onready var coffee_label = $"%CoffeeLabel"

onready var earned_label = $"%EarnedLabel"
onready var spent_label = $"%SpentLabel"
onready var succeded_label = $"%SuccededLabel"
onready var failed_label = $"%FailedLabel"
onready var edible_label = $"%EdibleLabel"
onready var inedible_label = $"%InedibleLabel"

func _ready():
	$"%ReturnButton".visible = false
	_connect_signals()

func _process(delta):
	_update_labels()

func _connect_signals():
	Game.day_hndlr.connect("day_ended", self, "_on_DayCycle_day_ended")

func _update_labels():
	chkn_label.text = str(Game.cookable_food["chicken_curry"])
	pork_label.text = str(Game.cookable_food["pork_curry"])
	beef_label.text = str(Game.cookable_food["beef_curry"])
	lemonade_label.text = str(Game.cookable_food["lemonade"])
	coffee_label.text = str(Game.cookable_food["coffee"])

func _on_DayCycle_day_ended():
	$"%ReturnButton".visible = true


func _on_ReturnButton_pressed():
	visible = false
