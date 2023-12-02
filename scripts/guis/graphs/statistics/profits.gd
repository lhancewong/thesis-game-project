extends Control

onready var chart: Chart = $Chart

var f1: Function  # gross income
var f2: Function  # expenses
var f3: Function  # profit
var cp: ChartProperties


func _ready():
	cp = ChartProperties.new()
	cp.colors.frame = Color.bisque
	cp.colors.background = Color.bisque
	cp.colors.grid = Color.bisque
	cp.colors.text = Color.black
	cp.draw_bounding_box = true
	cp.x_label = "Day"
	cp.y_label = "Money"
	cp.x_scale = 2
	cp.y_scale = 2
	cp.interactive = true
	cp.show_legend = true

	Game.day_hndlr.connect("day_ended", self, "_on_DayCycle_day_ended")

	if Game.day == 0:
		var dummy_x = [0]
		var dummy_y = [0]
		var dummy_func = Function.new(
			dummy_x,
			dummy_y,
			"Loading...",
			{
				color = Color.darkgreen,
				marker = Function.Marker.CIRCLE,
				type = Function.Type.LINE,
				interpolation = Function.Interpolation.LINEAR,
			}
		)
		chart.plot([dummy_func], cp)
	else:
		_plot()


func _plot():
	var xy = calculate_x_y()
	var x: Array = xy[0]
	var y1: Array = xy[1]
	var y2: Array = xy[2]
	var y3: Array = xy[3]

	f1 = Function.new(
		x,
		y1,
		"Profits",
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
		"Total Expenses",
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
		"Gross Income",
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

	if day == 0:
		return
	if day == 1:
		_plot()

	var gross_income = day_stats.money_earned
	var total_expense = day_stats.money_spent
	var profit = gross_income - total_expense

	f1.add_point(day, gross_income)
	f2.add_point(day, total_expense)
	f3.add_point(day, profit)

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
		y1.append(Game.database_hndlr.get_money_earned(i))
		y2.append(Game.database_hndlr.get_money_spent(i))
		y3.append(Game.database_hndlr.get_profit(i))

	return [x, y1, y2, y3]
