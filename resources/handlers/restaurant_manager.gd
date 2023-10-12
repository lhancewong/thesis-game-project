class_name Restaurant
extends Resource

export(Resource) var custo
export(Resource) var food
export(Resource) var ingred

export(float) var money = 100
export(float) var waste = 0
export(float) var satisfaction = 0
export(int) var day = 0

export(Dictionary) var cookable_food

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
	update_cookable_food()
	
	var customer = custo.get_rand_type()
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
	var waste = int(_noisefy(custo.BASE_WASTE * customer.waste_factor))
	var satisfaction = _noisefy(custo.BASE_SATISFACTION * customer.satisfaction_factor)
	
	return {
		"food_id": food_id,
		"food_type": food_type,
		"food_payment": food_payment,
		"customer": customer_type,
		"waste": waste,
		"satisfaction": satisfaction
	} 


##### FOOD SHIZ #####

# Calculates possible food items that can be cooked given 
# the current ingredient stockpile
func update_cookable_food() -> String:
	var food_list = food.get_food_list()

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
	
	return str(cookable_food)

func get_rand_cookable_food() -> Dictionary:
	var c_food_keys = cookable_food.keys()
	if c_food_keys:
		var food_name = c_food_keys[randi() % c_food_keys.size()]
		return food.get_food(food_name)
	else:
		return {"type": "No Food!"}


##### INGREDIENT SHIZZ #####

func buy_ingredients(type: String, amount: int) -> void:
	var ingredient
	var price
	var debug_msg
	
	match (type):
		'Chicken': ingredient = ingred.get_dict('c')
		'Beef': ingredient = ingred.get_dict('b')
		'Pork': ingredient = ingred.get_dict('p')
		'Curry Powder': ingredient = ingred.get_dict('cp')
	
	price = ingredient.price * amount
	
	if money >= price:
		i_stockpile[ingredient.type] += amount
		money -= price
		
		debug_msg = "Bought %d dollars of %s"
	else:
		debug_msg = "You broke ass bitch you can't afford %d dollars of %s"
	
	print(debug_msg % [price, type])

func spend_ingredients(food: Dictionary) -> void:
	var ingredient_list = food.ingredients
	
	for i in (ingredient_list):
		if i in i_stockpile:
			i_stockpile[i] -= 1


##### GETTERS #####

func get_money() -> String:
	return "$" + _make_pretty_numbers(money)

func get_satisfaction() -> String:
	return _make_pretty_numbers(satisfaction) + " happy"

func get_stockpile() -> Dictionary:
	return i_stockpile
