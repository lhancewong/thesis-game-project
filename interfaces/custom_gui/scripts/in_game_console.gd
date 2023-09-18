extends Control

onready var console = $BG/Console

func add_entry(dict: Dictionary) -> void:
	var format_text = "> A %s bought $%.1f amount of [food] which produced %.1fg of waste. They were %.1f happy."
	var text = format_text % [dict["customer"], dict["payment"], dict["waste"], dict["satisfaction"]]
	
	console.append_bbcode(text)
	console.newline()

