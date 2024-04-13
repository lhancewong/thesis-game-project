extends Path2D

#var timer = 0
#var spawnTime = 1

var Tyrone = preload("res://entities/npcs/tyrone.tscn")
var Jerome = preload("res://entities/npcs/jerome.tscn")
var Matt = preload("res://entities/npcs/matt.tscn")
var Layla = preload("res://entities/npcs/layla.tscn")
var Harry = preload("res://entities/npcs/harry.tscn")
var Tessa = preload("res://entities/npcs/tessa.tscn")
var Hugh = preload("res://entities/npcs/hugh.tscn")
var John = preload("res://entities/npcs/john.tscn")
var Chris = preload("res://entities/npcs/chris.tscn")
var James = preload("res://entities/npcs/james.tscn")
var Jared = preload("res://entities/npcs/jared.tscn")
var Ted = preload("res://entities/npcs/ted.tscn")
var Steve = preload("res://entities/npcs/steve.tscn")
var Mona = preload("res://entities/npcs/mona.tscn")
var Lisa = preload("res://entities/npcs/lisa.tscn")
var Rob = preload("res://entities/npcs/rob.tscn")
var Mary = preload("res://entities/npcs/mary.tscn")
var Ken = preload("res://entities/npcs/ken.tscn")
var Alan = preload("res://entities/npcs/alan.tscn")
var Justine = preload("res://entities/npcs/justine.tscn")
var Dorothea = preload("res://entities/npcs/dorothea.tscn")
var Carmella = preload("res://entities/npcs/carmella.tscn")
var Sam = preload("res://entities/npcs/sam.tscn")
var Amy = preload("res://entities/npcs/amy.tscn")
var Serena = preload("res://entities/npcs/serena.tscn")

var npcArray = [
	Tyrone,
	Jerome,
	Matt,
	Layla,
	Harry,
	Tessa,
	Hugh,
	John,
	Chris,
	James,
	Jared,
	Ted,
	Mona,
	Lisa,
	Rob,
	Mary,
	Ken,
	Alan,
	Justine,
	Dorothea,
	Carmella,
	Sam,
	Amy,
	Serena,
	Steve,
]


func spawnNPC():
	var randomIndex = randi() % npcArray.size()
	var NPC = npcArray[randomIndex]
	var newNPC = NPC.instance()
	add_child(newNPC)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	timer += _delta
#	if (timer > spawnTime):
#		var randomIndex = randi() % npcArray.size()
#		var NPC = npcArray[randomIndex]
#		var newNPC = NPC.instance()
#		add_child(newNPC)
#		timer = 0
