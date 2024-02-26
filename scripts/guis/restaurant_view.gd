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



var money_earned: int
var money_spent: int
var txn_succeded: int
var txn_failed: int
var ewaste: int
var iwaste: int

func _ready():
	init()
	_connect_signals()


func init():
	$"%QuickStats".visible = false
	$"%DayLabel".text = " Restaurant View \n Day %s" % Game.day

	money_earned = 0
	money_spent = 0
	txn_succeded = 0
	txn_failed = 0
	ewaste = 0
	iwaste = 0


func _process(delta):
	_update_labels()

func _connect_signals():
	Game.day_hndlr.connect("day_ended", self, "_on_DayCycle_day_ended")
	Game.purchase_hndlr.connect("transaction_succeded", self, "_on_Purchase_transaction_succeded")
	Game.purchase_hndlr.connect("transaction_failed", self, "_on_Purchase_transaction_failed")
	Game.waste_hndlr.connect("iwaste_produced", self, "_on_Waste_iwaste_produced")
	Game.waste_hndlr.connect("ewaste_produced", self, "_on_Waste_ewaste_produced")


func _update_labels():
	chkn_label.text = str(Game.cookable_food["chicken_curry"])
	pork_label.text = str(Game.cookable_food["pork_curry"])
	beef_label.text = str(Game.cookable_food["beef_curry"])
	lemonade_label.text = str(Game.cookable_food["lemonade"])
	coffee_label.text = str(Game.cookable_food["coffee"])

	earned_label.text = "Earned: %s~" % str(money_earned)
	spent_label.text = "Spent: %s~" % str(money_spent)
	succeded_label.text = "Succeded: %s~" % str(txn_succeded)
	failed_label.text = "Failed: %s~" % str(txn_failed)
	edible_label.text = "E Waste: %s~" % str(ewaste)
	inedible_label.text = "I Waste: %s~" % str(iwaste)


func _set_performance_label():
	var performance = Game.performance_hndlr.get_day_performance(Game.day)
	$"%PerformanceLabel".text = (
		""" 
		TODAY'S PERFORMANCE
		Profits: %.0s%%
		Customer: %.0s%%
		Waste: %.0s%%
		"""
	) % [performance.profit[0], performance.customer[0], performance.waste]


# Signals
func _on_DayCycle_day_ended():
	_set_performance_label()
	$"%QuickStats".visible = true


func _on_Purchase_transaction_succeded(meal, customer, payment, iwaste, satisfaction):
	money_earned += int(payment)
	txn_succeded += 1


func _on_Purchase_transaction_failed(type):
	txn_failed += 1


func _on_Waste_iwaste_produced(amount):
	iwaste += int(amount)


func _on_Waste_ewaste_produced(amount):
	ewaste += int(amount)


func _on_ReturnButton_pressed():
	visible = false
