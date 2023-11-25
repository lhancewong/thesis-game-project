extends Control

onready var chart: Chart = $Chart

# This Chart will plot 3 different functions
var f1: Function


func _ready():
	# Let's create our @x values
	var x: Array = [0] + Game.database_hndlr.get_day_values()
	
	# And our y values. It can be an n-size array of arrays.
	# NOTE: `x.size() == y.size()` or `x.size() == y[n].size()`
	var y: Array = [0] + Game.database_hndlr.get_waste_produced_values()
	
	# Let's customize the chart properties, which specify how the chart
	# should look, plus some additional elements like labels, the scale, etc...
	var cp: ChartProperties = ChartProperties.new()
	cp.colors.frame = Color.bisque
	cp.colors.background = Color.bisque
	cp.colors.grid = Color.bisque
	cp.colors.ticks = Color("#283442")
	cp.colors.text = Color.black
	cp.draw_bounding_box = true
	cp.title = "Total Produced Waste Per Day"
	cp.x_label = "Day"
	cp.y_label = "Waste"
	cp.x_scale = 5
	cp.y_scale = 5
	cp.interactive = true # false by default, it allows the chart to create a tooltip to show point values
	# and interecept clicks on the plot
	
	# Let's add values to our functions
	f1 = Function.new(
		x, y, "Total Waste", # This will create a function with x and y values taken by the Arrays 
						  # we have created previously. This function will also be named "Pressure"
						  # as it contains 'pressure' values.
						  # If set, the name of a function will be used both in the Legend
						  # (if enabled thourgh ChartProperties) and on the Tooltip (if enabled).
		# Let's also provide a dictionary of configuration parameters for this specific function.
		{ 
			color = Color.darkgreen, 		# The color associated to this function
			marker = Function.Marker.CIRCLE,# The marker that will be displayed for each drawn point (x,y)
											# since it is `NONE`, no marker will be shown.
			type = Function.Type.LINE,  	# This defines what kind of plotting will be used, 
											# in this case it will be an Area Chart.
			interpolation = Function.Interpolation.LINEAR   # Interpolation mode, only used for 
															# Line Charts and Area Charts.
		}
	)
	
	# Now let's plot our data
	chart.plot([f1], cp)
	Game.day_hndlr.connect("day_ended", self, "_on_DayCycle_day_ended")


func _on_DayCycle_day_ended(money_left, ewaste_left, iwaste_left):
	var day = Game.day
	var day_stats = Game.stats_per_day[day]
	var total_waste = day_stats.ewaste_produced + day_stats.iwaste_produced
	
	f1.add_point(day, total_waste)
	chart.update()
