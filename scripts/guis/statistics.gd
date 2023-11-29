extends Control

# Sold Food Tab
onready var sold_food_label = $TabMenu/SoldFood/SoldFoodTable
onready var managed_waste_label = $TabMenu/ManagedWaste/ManagedWasteTable


func _ready():
	set_sold_food_table()
	set_managed_waste_table()


func set_sold_food_table():
	if Game.sold_food.empty():
		return
	sold_food_label.append_bbcode("[table=8]")
	for key in Game.sold_food[0].keys():
		sold_food_label.append_bbcode("[cell] %s [/cell]" % key)
	for entry in Game.sold_food:
		for value in entry.values():
			sold_food_label.append_bbcode("[cell] %s [/cell]" % value)
	sold_food_label.append_bbcode("[/table]")


func set_managed_waste_table():
	if Game.waste_managed.empty():
		return
	managed_waste_label.append_bbcode("[table=4]")
	for key in Game.waste_managed[0].keys():
		managed_waste_label.append_bbcode("[cell] %s [/cell]" % key)
	for entry in Game.waste_managed:
		for j in entry:
			managed_waste_label.append_bbcode("[cell] %s [/cell]" % j)
	managed_waste_label.append_bbcode("[/table]")


func add_sold_food(entry):
	for j in entry.values():
		sold_food_label.append_bbcode("[cell] %s [/cell]" % j)


func add_managed_waste(entry):
	for j in entry:
		managed_waste_label.append_bbcode("[cell] %s [/cell]" % j)
