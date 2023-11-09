extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var time := 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_on_Timer_timeout(delta)


func _on_Timer_timeout(delta: float) -> void:
	time += delta
	$Path2D/Tyrone.offset = time * 200.0
	$Path2D/Jerome.offset = time * 100.0
	# Replace with function body.
