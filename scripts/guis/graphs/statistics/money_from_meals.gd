extends Control

onready var chart: Chart = $Chart

var f1: Function  # chicken
var f2: Function  # beef
var f3: Function  # pork


func _ready():
	Game.day_hndlr.connect("day_ended", self, "_on_DayCycle_day_ended")

	var xy = calculate_x_y()
	var x: Array = xy[0]
	var y1: Array = xy[1]
	var y2: Array = xy[2]
	var y3: Array = xy[3]

	var cp: ChartProperties = ChartProperties.new()
	cp.colors.frame = Color.bisque
	cp.colors.background = Color.bisque
	cp.colors.grid = Color.bisque
	cp.colors.text = Color.black
	cp.draw_bounding_box = true
	cp.x_label = "Day"
	cp.x_scale = 2
	cp.y_scale = 2
	cp.interactive = true
	cp.show_legend = true

	f1 = Function.new(
		x,
		y1,
		"Chicken Curry Gross Income",
		{
			color = Color.darkgreen,
			type = Function.Type.LINE,
			marker = Function.Marker.CIRCLE,
			interpolation = Function.Interpolation.LINEAR
		}
	)

	f2 = Function.new(
		x,
		y2,
		"Beef Curry Gross Income",
		{
			color = Color.darkred,
			type = Function.Type.LINE,
			marker = Function.Marker.CIRCLE,
			interpolation = Function.Interpolation.LINEAR
		}
	)

	f3 = Function.new(
		x,
		y3,
		"Pork Curry Gross Income",
		{
			color = Color.darkcyan,
			type = Function.Type.LINE,
			marker = Function.Marker.CIRCLE,
			interpolation = Function.Interpolation.LINEAR
		}
	)

	chart.plot([f1, f2, f3], cp)


func _on_DayCycle_day_ended(money_left, ewaste_left, iwaste_left):
	var day = Game.day
	var day_stats = Game.stats_per_day[str(day)]

	var chicken_gross_income = day_stats.money_earned_from_meals["chicken_curry"]
	var beef_gross_income = day_stats.money_earned_from_meals["beef_curry"]
	var pork_gross_income = day_stats.money_earned_from_meals["pork_curry"]

	f1.add_point(day, chicken_gross_income)
	f2.add_point(day, beef_gross_income)
	f3.add_point(day, pork_gross_income)

	chart.update()


func calculate_x_y():
	var x: Array = []
	var y1: Array = []
	var y2: Array = []
	var y3: Array = []

	if Game.day == 0:
		x = [0]
		y1 = [0]
		y2 = [0]
		y3 = [0]

	for i in range(Game.stats_per_day.size() - 1):
		x.append(int(i))
	for i in x:
		y1.append(Game.database_hndlr.get_money_earned_from_meal("chicken_curry", i))
		y2.append(Game.database_hndlr.get_money_earned_from_meal("beef_curry", i))
		y3.append(Game.database_hndlr.get_money_earned_from_meal("pork_curry", i))

	return [x, y1, y2, y3]
