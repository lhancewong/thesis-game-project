extends Node

export(Resource) var MEAL

# Calculates possible food items that can be cooked given 
# the current ingredient stockpile
func update_cookable_food():
    var food_list = MEAL.menu.values()
    
    for food in food_list:
        var cookable = true
        var temp_igdt_list = []
        for i_name in food["ingredients"]:
            var i_stock = Game.i_stockpile[str(i_name)]
            if i_stock < 1:
                cookable = false
                break
            else:
                temp_igdt_list.append(i_stock)

        if cookable:
            var cookable_amnt = temp_igdt_list.min()
            Game.cookable_food[food["type"]] = cookable_amnt
        else:
            Game.cookable_food.erase(food["type"])

func get_rand_cookable_food() -> String:
    var c_food_keys = Game.cookable_food.keys()
    if c_food_keys:
        var food_name = c_food_keys[randi() % c_food_keys.size()]
        return food_name
    else:
        return "No Food"

func get_food(name: String) -> Dictionary:
    match (name):
        "Chicken Curry": return MEAL.menu.chicken_curry
        "Beef Curry": return MEAL.menu.beef_curry
        "Pork Curry": return MEAL.menu.pork_curry
        "Lemonade": return MEAL.menu.lemonade
        "Coffee": return MEAL.menu.coffee
        "No Food", _: return {}
