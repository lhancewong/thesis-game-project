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

func _physics_process(delta):
    pass
