extends Control

onready var console = $BG/Console


func add_entry(dict: Dictionary) -> void:
	var format_text = "> A %s bought ₱%.1f amount of %s which produced %.1fg of waste. They were %.1f happy."
	var text = (
		format_text
		% [
			dict["customer"],
			dict["meal_payment"],
			dict["meal_type"],
			dict["waste_amnt"],
			dict["satisfaction"]
		]
	)

	console.add_text(text)
	console.newline()


func add_text(text: String) -> void:
	console.add_text("> " + text)
	console.newline()
