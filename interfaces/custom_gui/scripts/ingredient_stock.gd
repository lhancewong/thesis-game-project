extends Node


func _init(stockpile: Dictionary, index: int):
	var ingredients = stockpile.keys()
	
	$Ingredient/Label.text = ingredienta["type"]
	$Amount/Amount.text = ingredient[index]
