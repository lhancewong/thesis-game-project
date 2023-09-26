class_name Restaurant
extends Resource

export(Resource) var custo
export(Resource) var food
export(Resource) var ingredient

export(float) var money = 100
export(float) var waste = 0
export(float) var satisfaction = 0
export(int) var day = 0

export(Dictionary) var cookable_food


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

func update():
	update_cookable_food()


##### PURCHASE SHIZ #####

func create_purchase() -> Dictionary:
	var stats = custo.get_rand_type()
	var food = get_rand_cookable_food()
	
	if food != {}: 
		return {
		"food_id": 0,
		"food_type": 0,
		"food_payment": 0,
		"customer": 0,
		"waste": 0,
		"satisfaction": 0
		}
		
	ingredient.spend_ingredients(food)
		
	
	var food_id = food["id"]
	var food_type = food["type"]
	var food_payment = food["base_price"]
	
	var customer = stats.type
	var waste = int(_noisefy(custo.BASE_WASTE * stats.waste_factor))
	var satisfaction = _noisefy(custo.BASE_SATISFACTION * stats.satisfaction_factor)
	
	var entry = {
		"food_id": food_id,
		"food_type": food_type,
		"food_payment": food_payment,
		"customer": customer,
		"waste": waste,
		"satisfaction": satisfaction
	} 
	
	add_purchase(entry)
	return entry

func add_purchase(entry: Dictionary) -> void:
	money += entry["food_payment"]
	waste += entry["waste"]
	satisfaction += entry["satisfaction"]


##### FOOD SHIZ #####

# Calculates possible food items that can be cooked given 
# the current ingredient stockpile
func update_cookable_food() -> String:
	var ingredient_stockpile = ingredient.get_stockpile()
	var food_list = food.get_food_list()

	for food in food_list:
		var cookable = true
		var temp_igdt_list = []
		for i_name in food["ingredients"]:
			var i_stock = ingredient_stockpile[str(i_name)]
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
	
	return str(cookable_food)

func get_rand_cookable_food() -> Dictionary:
	var c_food_keys = cookable_food.keys()
	if c_food_keys:
		var food_name = c_food_keys[randi() % c_food_keys.size()]
		return food.get_food(food_name)
	else:
		return {"type": "No Food!"}



##### GETTERS #####

func get_money() -> String:
	return "$" + _make_pretty_numbers(money)

func get_satisfaction() -> String:
	return _make_pretty_numbers(satisfaction) + " happy"
