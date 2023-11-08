class_name Restaurant
extends Resource

export(Resource) var CUSTO
export(Resource) var MEAL
export(Resource) var INGRED

export(float) var money = 100.0
export(float) var waste = 0.0
export(float) var satisfaction = 0.0
export(int) var day = 0

# Stores a temporary list of currently cookable food (aka what can be sold)
export(Dictionary) var cookable_food

# Stores ingredients current in stock
export(Dictionary) var i_stockpile = {
    "chicken": 0, 
    "beef": 0, 
    "pork": 0, 
    "curry_powder": 0, 
    "potato": 0, 
    "spinach": 0, 
    "eggplant": 0, 
    "cheese": 0, 
    "lemon": 0, 
    "coffee_mix": 0, 
    "sugar": 0,
}


"""
Helper Methods
"""

# Turns numbers into a Tycoon compatible format
func _make_pretty_numbers( num:float, precission:int=2  ) -> String:
    var unit:String
    if num > 1000000000:
        num /= 1000000000
        unit = "giga"
    elif num > 1000000:
        num /= 1000000
        unit = "M"
    elif num > 1000:
        num /= 1000
        unit = "K"
    else:
        unit = ""
    
    return str("%."+str(precission)+"f"+unit) % [num]

# Adds noise to a float value
func _noisefy(num: float):
    return rand_range(0.95, 1.05) * num

"""
Customer Methods
"""

func get_rand_customer() -> Dictionary:
    # Chooses the customer number (for now they are all equally likely to appear)
    var id = randi() % 3
    var stats
    
    # Basically a switch statement
    match id:
        0: stats = CUSTO.tourist
        1: stats = CUSTO.regular
        2: stats = CUSTO.local
    
    return stats


"""
Purchase Methods
"""

func create_purchase() -> Dictionary:
    update_cookable_food()
    
    var customer = get_rand_customer()
    var food = get_rand_cookable_food()
    var entry
    
    # Checks if theres any cookable food
    if str(food.type) == "No Food!": 
        return {"food_id": "No Food!"}
    
    spend_ingredients(food)
    entry = create_entry(food, customer)
    add_purchase(entry)
    
    update_cookable_food()
    
    return entry

func add_purchase(entry: Dictionary) -> void:
    money += entry.food_payment
    waste += entry.waste
    satisfaction += entry.satisfaction

func create_entry(food: Dictionary, customer: Dictionary) -> Dictionary:
    var food_id = food.id
    var food_type = food.type
    var food_payment = food.base_price
    
    var customer_type = customer.type
    var waste_amnt = int(_noisefy(CUSTO.BASE_WASTE * customer.waste_factor))
    var satisfaction_amnt = _noisefy(CUSTO.BASE_SATISFACTION * customer.satisfaction_factor)
    
    return {
        "food_id": food_id,
        "food_type": food_type,
        "food_payment": food_payment,
        "customer": customer_type,
        "waste": waste_amnt,
        "satisfaction": satisfaction_amnt,
    } 


"""
Food Methods
"""

# Calculates possible food items that can be cooked given 
# the current ingredient stockpile
func update_cookable_food():
    var food_list = MEAL.menu.values()

    for food in food_list:
        var cookable = true
        var temp_igdt_list = []
        for i_name in food["ingredients"]:
            var i_stock = i_stockpile[str(i_name)]
            if i_stock < 1:
                cookable = false
                break
            else:
                temp_igdt_list.append(i_stock)
        
        if cookable:
            var cookable_amnt = temp_igdt_list.min()
            cookable_food[food["type"]] = cookable_amnt
        else:
            cookable_food.erase(food["type"])

func get_rand_cookable_food() -> Dictionary:
    var c_food_keys = cookable_food.keys()
    if c_food_keys:
        var food_name = c_food_keys[randi() % c_food_keys.size()]
        return get_food(food_name)
    else:
        return {"type": "No Food!"}

func get_food(name: String) -> Dictionary:
    match (name):
        "Chicken Curry": return MEAL.menu.chicken_curry
        "Beef Curry": return MEAL.menu.beef_curry
        "Pork Curry": return MEAL.menu.pork_curry
        "Lemonade": return MEAL.menu.lemonade
        "Coffee": return MEAL.menu.coffee
        _: return MEAL.menu.spinach

"""
Ingredient Methods
"""

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
    
    if money >= price:
        i_stockpile[ingredient.type] += amount
        money -= price
        
        debug_msg = "Bought %.2f dollars of %s"
    else:
        debug_msg = "You broke ass bitch you can't afford %.2f dollars of %s"
    
    print(debug_msg % [price, type])

func spend_ingredients(food: Dictionary) -> void:
    var ingredient_list = food.ingredients
    
    for i in (ingredient_list):
        if i in i_stockpile:
            i_stockpile[i] -= 1

"""
Getter Methods
"""

func get_money() -> String:
    return "$" + _make_pretty_numbers(money)

func get_satisfaction() -> String:
    return _make_pretty_numbers(satisfaction) + " happy"

func get_stockpile() -> Dictionary:
    return i_stockpile

func save():
    var save_dict = {
        "day": day,
        "money": money,
        "satisfaction": satisfaction,
        "i_stockpile": i_stockpile,
    }
    return save_dict
