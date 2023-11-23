extends Control

# Main Stats Label
onready var production_waste_label = $TabMenu/MainStats/HBoxContainer/VBoxContainer/ProductionWaste
onready var rotten_waste_label = $TabMenu/MainStats/HBoxContainer/VBoxContainer/RottenWaste
onready var leftover_waste_label = $TabMenu/MainStats/HBoxContainer/VBoxContainer/LeftoverWaste
onready var unavoidable_waste_label = $TabMenu/MainStats/HBoxContainer/VBoxContainer/UnavoidableWaste
onready var waste_cost_label = $TabMenu/MainStats/HBoxContainer/VBoxContainer/WasteCost
onready var ingredient_amnt_label = $TabMenu/MainStats/HBoxContainer/VBoxContainer/IngredientAmount

# Money Stats Label
onready var revenue_label = $TabMenu/MoneyStats/VBoxContainer/Revenue
onready var food_assets_label = $TabMenu/MoneyStats/VBoxContainer/FoodAssets
onready var capital_label = $TabMenu/MoneyStats/VBoxContainer/Capital
onready var profits_label = $TabMenu/MoneyStats/VBoxContainer/Profits
onready var gross_profit_label = $TabMenu/MoneyStats/VBoxContainer/GrossProfit
onready var gross_margin_label = $TabMenu/MoneyStats/VBoxContainer/GrossMargin
onready var ingredient_cost_label = $TabMenu/MoneyStats/VBoxContainer/IngredientCost
onready var waste_cost_label2 = $TabMenu/MoneyStats/VBoxContainer/WasteCost
onready var management_fee_label = $TabMenu/MoneyStats/VBoxContainer/ManagementFees
onready var total_expenses_label = $TabMenu/MoneyStats/VBoxContainer/TotalExpenses

# Sold Food Tab
onready var sold_food_label = $TabMenu/SoldFood/SoldFoodTable
onready var managed_waste_label = $TabMenu/ManagedWaste/ManagedWasteTable


func _physics_process(delta):
	pass


func _ready():
	set_sold_food_table()
	set_managed_waste_table()


func set_sold_food_table():
	sold_food_label.append_bbcode("[table=8]")
	for entry in Game.sold_food:
		for j in entry.values():
			sold_food_label.append_bbcode("[cell] %s [/cell]" % j)
	sold_food_label.append_bbcode("[/table]")


func set_managed_waste_table():
	managed_waste_label.append_bbcode("[table=4]")
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
