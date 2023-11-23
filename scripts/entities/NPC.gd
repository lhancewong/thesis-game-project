extends PathFollow2D

export var speed = 200


func _process(delta):
	set_offset(get_offset() + speed * delta)
	if get_unit_offset() == 1:
		queue_free()
