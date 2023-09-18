class_name Restaurant
extends Resource


export(float) var money
export(float) var waste
export(float) var satisfaction

func _init(p_money = 0, p_waste = 0, p_satisfaction = 0):
	money = p_money
	waste = p_waste
	satisfaction = p_satisfaction

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

func add_purchase(entry: Dictionary) -> void:
	money += entry["payment"]
	waste += entry["waste"]
	satisfaction += entry["satisfaction"]

func get_money() -> String:
	return "$" + _make_pretty_numbers(money)

func get_waste() -> String:
	return _make_pretty_numbers(waste) + " foods"

func get_satisfaction() -> String:
	return _make_pretty_numbers(satisfaction) + " happy"
