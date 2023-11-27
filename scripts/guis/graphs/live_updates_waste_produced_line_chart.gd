extends Control

onready var chart: Chart = $Chart

# This Chart will plot 3 different functions
var f1: Function  # waste
var f2: Function  # customers_served
var f3: Function  # profits


func _ready():
	Game.day_hndlr.connect("day_ended", self, "_on_DayCycle_day_ended")

	var xy = calculate_x_y()
	var x: Array = xy[0]
	var y1: Array = xy[1]
	var y2: Array = xy[2]
	var y3: Array = xy[3]

	# Let's customize the chart properties, which specify how the chart
	# should look, plus some additional elements like labels, the scale, etc...
	var cp: ChartProperties = ChartProperties.new()
	cp.colors.frame = Color.bisque
	cp.colors.background = Color.bisque
	cp.colors.grid = Color.bisque
#	cp.colors.ticks = Color("#283442")
	cp.colors.text = Color.black
	cp.draw_bounding_box = true
	cp.title = ""
	cp.x_label = "Day"
	cp.y_label = ""
	cp.x_scale = 5
	cp.y_scale = 5
	cp.interactive = true  # false by default, it allows the chart to create a tooltip to show point values
	cp.show_legend = true
	# and interecept clicks on the plot

	# Let's add values to our functions
	f1 = Function.new(
		x,
		y1,
		"Total Waste",  # This will create a function with x and y values taken by the Arrays
		# we have created previously. This function will also be named "Pressure"
		# as it contains 'pressure' values.
		# If set, the name of a function will be used both in the Legend
		# (if enabled thourgh ChartProperties) and on the Tooltip (if enabled).
		# Let's also provide a dictionary of configuration parameters for this specific function.
		{
			color = Color.darkgreen,  # The color associated to this function
			marker = Function.Marker.CIRCLE,  # The marker that will be displayed for each drawn point (x,y)
			# since it is `NONE`, no marker will be shown.
			type = Function.Type.LINE,  # This defines what kind of plotting will be used,
			# in this case it will be an Area Chart.
			interpolation = Function.Interpolation.LINEAR  # Interpolation mode, only used for
			# Line Charts and Area Charts.
		}
	)

	f2 = Function.new(
		x,
		y2,
		"Total Customers Served",
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
		"Money Earned",
		{
			color = Color.darkcyan,
			type = Function.Type.LINE,
			marker = Function.Marker.CIRCLE,
			interpolation = Function.Interpolation.LINEAR
		}
	)

	# Now let's plot our data
	chart.plot([f1, f2, f3], cp)


func _on_DayCycle_day_ended(money_left, ewaste_left, iwaste_left):
	var day = Game.day
	var day_stats = Game.stats_per_day[str(day)]

	var total_waste = day_stats.ewaste_produced + day_stats.iwaste_produced
	var customers_served = (
		day_stats.customers_served["local"]
		+ day_stats.customers_served["regular"]
		+ day_stats.customers_served["tourist"]
	)
	var money_earned = day_stats.money_earned

	f1.add_point(day, total_waste)
	f2.add_point(day, customers_served)
	f3.add_point(day, money_earned)

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
		y1.append(Game.database_hndlr.get_waste_produced(i))
		y2.append(Game.database_hndlr.get_customers_served(i))
		y3.append(Game.database_hndlr.get_money_earned(i))

	return [x, y1, y2, y3]
