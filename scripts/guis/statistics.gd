extends Control

# Sold Food Tab
onready var sold_food_label = $"%SoldFoodTable"
onready var managed_waste_label = $"%ManagedWasteTable"


func _ready():
	$TabMenu/Forecast.queue_free()

	set_sold_food_table()
	set_managed_waste_table()

	Game.day_hndlr.connect("day_ended", self, "add_sold_food")
	Game.day_hndlr.connect("day_ended", self, "add_managed_waste")


func set_sold_food_table():
	if Game.day == 0:
		return
	var day_list = Game.transaction_receipts.keys()
	day_list.pop_back()
	for day in day_list:  # Each day (all receipts for all days)
		sold_food_label.append_bbcode("[table=1]")
		sold_food_label.append_bbcode("[cell] ========== Day %s ========== [/cell]" % day)
		if Game.transaction_receipts[day].empty():
			sold_food_label.append_bbcode(
				"[cell][/cell][cell] -.- No receipts -.- [/cell][cell][/cell]"
			)
			sold_food_label.newline()
		else:
			sold_food_label.append_bbcode("[table=6]")
			for cell_label in Game.transaction_receipts[day][0].keys():  # prints out cell labels
				sold_food_label.append_bbcode("[cell] %s [/cell]" % cell_label)
			for receipt in Game.transaction_receipts[day]:  # A day's
				for value in receipt.values():
					sold_food_label.append_bbcode("[cell] %s [/cell]" % value)
			sold_food_label.append_bbcode("[/table]")
			sold_food_label.newline()


func set_managed_waste_table():
	if Game.day == 0:
		return
	var day_list = Game.strategy_receipts.keys()
	day_list.pop_back()
	for day in day_list:  # Each day (all receipts for all days)
		managed_waste_label.append_bbcode("[table=1]")
		managed_waste_label.append_bbcode("[cell] ========== Day %s ========== [/cell]" % day)
		if Game.strategy_receipts[day].empty():
			managed_waste_label.append_bbcode(
				"[cell][/cell][cell] -.- No receipts -.- [/cell][cell][/cell]"
			)
			managed_waste_label.newline()
		else:
			managed_waste_label.append_bbcode("[table=3]")
			for cell_label in Game.strategy_receipts[day][0].keys():  # prints out cell labels
				managed_waste_label.append_bbcode("[cell] %s [/cell]" % cell_label)
			for receipt in Game.strategy_receipts[day]:  # A day's
				for value in receipt.values():
					managed_waste_label.append_bbcode("[cell] %s [/cell]" % value)
			managed_waste_label.append_bbcode("[/table]")
			managed_waste_label.newline()


func add_sold_food():
	var day = str(Game.day)
	sold_food_label.append_bbcode("[table=1]")
	sold_food_label.append_bbcode("[cell] ========== Day %s ========== [/cell]" % day)
	if Game.transaction_receipts[day].empty():
		sold_food_label.append_bbcode(
			"[cell][/cell][cell] -.- No receipts -.- [/cell][cell][/cell]"
		)
		sold_food_label.newline()
	else:
		sold_food_label.append_bbcode("[table=6]")
		for cell_label in Game.transaction_receipts[day][0].keys():  # prints out cell labels
			sold_food_label.append_bbcode("[cell] %s [/cell]" % cell_label)
		for receipt in Game.transaction_receipts[day]:  # All of a day's receipts
			for value in receipt.values():
				sold_food_label.append_bbcode("[cell] %s [/cell]" % value)
		sold_food_label.append_bbcode("[/table]")
		sold_food_label.newline()


func add_managed_waste():
	var day = str(Game.day)
	managed_waste_label.append_bbcode("[table=1]")
	managed_waste_label.append_bbcode("[cell] ========== Day %s ========== [/cell]" % day)
	if Game.strategy_receipts[day].empty():
		managed_waste_label.append_bbcode(
			"[cell][/cell][cell] -.- No receipts -.- [/cell][cell][/cell]"
		)
		managed_waste_label.newline()
	else:
		managed_waste_label.append_bbcode("[table=3]")
		for cell_label in Game.strategy_receipts[day][0].keys():  # prints out cell labels
			managed_waste_label.append_bbcode("[cell] %s [/cell]" % cell_label)
		for receipt in Game.strategy_receipts[day]:  # All of a day's receipts
			for value in receipt.values():
				managed_waste_label.append_bbcode("[cell] %s [/cell]" % value)
		managed_waste_label.append_bbcode("[/table]")
		managed_waste_label.newline()
