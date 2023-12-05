extends Node

var sum


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func compost_debuff():
	sum = 0
	for i in Game.compost_stack:
		sum += i
	print(sum)
	if sum > 250:
		return true
	else:
		return false


func feed_animals_buff():
	if Game.total_animals_fed > 500:
		return true
	else:
		return false


func add_animals_buff(amount):
	Game.total_animals_fed += amount
