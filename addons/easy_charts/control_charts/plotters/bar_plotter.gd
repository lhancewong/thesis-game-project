extends FunctionPlotter
class_name BarPlotter

signal point_entered(point, function)
signal point_exited(point, function)

var bars: PoolVector2Array
var bars_rects: Array
var focused_bar_midpoint: Point

var bar_size: float


func _init(function: Function).(function) -> void:
	self.bar_size = function.props.get("bar_size", 5.0)


func _draw() -> void:
	var box: Rect2 = get_box()
	var x_sampled_domain: Dictionary = {lb = box.position.x, ub = box.end.x}
	var y_sampled_domain: Dictionary = {lb = box.end.y, ub = box.position.y}
	sample(x_sampled_domain, y_sampled_domain)
	_draw_bars()


func sample(x_sampled_domain: Dictionary, y_sampled_domain: Dictionary) -> void:
	bars = []
	bars_rects = []
	for i in function.x.size():
		var top: Vector2 = Vector2(
			ECUtilities._map_domain(i, x_domain, x_sampled_domain),
			ECUtilities._map_domain(function.y[i], y_domain, y_sampled_domain)
		)
		var base: Vector2 = Vector2(top.x, ECUtilities._map_domain(0.0, y_domain, y_sampled_domain))
		bars.push_back(top)
		bars.push_back(base)
		bars_rects.append(
			Rect2(Vector2(top.x - bar_size, top.y), Vector2(bar_size * 2, base.y - top.y))
		)


func _draw_bars() -> void:
	for bar in bars_rects:
		draw_rect(bar, function.get_color())


func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		for i in bars_rects.size():
			if bars_rects[i].grow(5).abs().has_point(get_relative_position(event.position)):
				var point: Point = Point.new(
					bars_rects[i].get_center(), {x = function.x[i], y = function.y[i]}
				)
				if focused_bar_midpoint == point:
					return
				else:
					focused_bar_midpoint = point
					emit_signal("point_entered", point, function)
					return
		# Mouse is not in any point's box
		emit_signal("point_exited", focused_bar_midpoint, function)
		focused_bar_midpoint = null
