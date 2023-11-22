extends Node

export(Resource) var INGRED

func buy_ingredients(type: String, amount: int) -> void:
  var ingredient
  var price
  var debug_msg
  
  match (type):
    'Chicken': ingredient = INGRED.chicken
    'Beef': ingredient = INGRED.beef
    'Pork': ingredient = INGRED.pork
    'Curry Powder': ingredient = INGRED.curry_powder
    _: push_error('Buy Ingredients error')
  
  price = ingredient.price * amount
  
  if Game.money >= price:
    Game.i_stockpile[ingredient.type] += amount
    Game.money -= price
    
    Game.ingreds_bought_per_day[Game.day][ingredient.type] += 1
    Game.money_spent_per_day[Game.day] += price
  
    debug_msg = "Bought %.2f dollars of %s"
  else:
    debug_msg = "You broke ass bitch you can't afford %.2f dollars of %s"
  
  if get_tree().current_scene.name == "OnDaylight":
    var terminal = get_node("/root/OnDaylight/VBoxContainer/HBoxContainer/GameConsole")
    terminal.add_text(debug_msg % [price, type])

func spend_ingredients(food: Dictionary) -> void:
  var ingredient_list = food.ingredients
  
  for i in (ingredient_list):
    if i in Game.i_stockpile:
      Game.i_stockpile[i] -= 1
      Game.ingreds_consumed_per_day[Game.day][str(i)] += 1


func unlock_ingredients():
  if get_tree().current_scene.name == "OnDaylight":
    var order_ingred_node = get_node("/root/OnDaylight/VBoxContainer/HBoxContainer/VBoxContainer/middle/MarginContainer/OrderIngredients/PaperContainer")
    for i in Game.unlocked_ingredients:
      for order_blocker in order_ingred_node.get_children():
        if Game.unlocked_ingredients[i] && i == order_blocker.name:
          order_blocker.visible = false
