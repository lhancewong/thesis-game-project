class_name Order_Manager
extends Resource


var old_text = ""

# Resources
export(Resource) var ingredients
export(Resource) var restaurant

# Labels
var order_chicken_amount = 0

var order_beef_amount = 0

var order_pork_amount = 0

var order_curry_amount = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


#func _physics_process(delta):
#	pass

# Chicken Buttons
func chicken_buy():
	restaurant.buy_ingredients('Chicken', order_chicken_amount)


func chicken_minus():
	if order_chicken_amount == 0:
		return "0"
	order_chicken_amount -= 1
	return str(order_chicken_amount)


func chicken_plus():
	order_chicken_amount += 1
	return str(order_chicken_amount)


func chicken_getAmount():
	return str(order_chicken_amount)


func chicken_setAmount(amount):
	order_chicken_amount = amount


# Beef Buttons
func beef_buy():
	restaurant.buy_ingredients('Beef', order_beef_amount)


func beef_minus():
	if order_beef_amount == 0:
		return "0"
	order_beef_amount -= 1
	return str(order_beef_amount)


func beef_plus():
	order_beef_amount += 1
	return str(order_beef_amount)


func beef_getAmount():
	return str(order_beef_amount)


func beef_setAmount(amount):
	order_beef_amount = amount


# Pork Buttons
func pork_buy():
	restaurant.buy_ingredients('Pork', order_pork_amount)


func pork_minus():
	if order_pork_amount == 0:
		return "0"
	order_pork_amount -= 1
	return str(order_pork_amount)


func pork_plus():
	order_pork_amount += 1
	return str(order_pork_amount)


func pork_getAmount():
	return str(order_pork_amount)


func pork_setAmount(amount):
	order_pork_amount = amount


# Curry Buttons
func curry_buy():
	restaurant.buy_ingredients('Curry Powder', order_curry_amount)


func curry_minus():
	if order_curry_amount == 0:
		return "0"
	order_curry_amount -= 1
	return str(order_curry_amount)


func curry_plus():
	print(order_curry_amount)
	order_curry_amount += 1
	return str(order_curry_amount)


func curry_getAmount():
	return str(order_curry_amount)


func curry_setAmount(amount):
	order_curry_amount = amount

