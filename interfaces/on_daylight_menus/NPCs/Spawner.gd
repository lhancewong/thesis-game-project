extends Path2D

#var timer = 0
#var spawnTime = 1

var Tyrone = preload("res://interfaces/on_daylight_menus/NPCs/Tyrone.tscn")
var Jerome = preload("res://interfaces/on_daylight_menus/NPCs/Jerome.tscn")
var Matt = preload("res://interfaces/on_daylight_menus/NPCs/Matt.tscn")
var Layla = preload("res://interfaces/on_daylight_menus/NPCs/Layla.tscn")
var Harry = preload("res://interfaces/on_daylight_menus/NPCs/Harry.tscn")
var Tessa = preload("res://interfaces/on_daylight_menus/NPCs/Tessa.tscn")
var Hugh = preload("res://interfaces/on_daylight_menus/NPCs/Hugh.tscn")
var John = preload("res://interfaces/on_daylight_menus/NPCs/John.tscn")
var Chris = preload("res://interfaces/on_daylight_menus/NPCs/Chris.tscn")
var James = preload("res://interfaces/on_daylight_menus/NPCs/James.tscn")
var Jared = preload("res://interfaces/on_daylight_menus/NPCs/Jared.tscn")
var Ted = preload("res://interfaces/on_daylight_menus/NPCs/Ted.tscn")
var Steve = preload("res://interfaces/on_daylight_menus/NPCs/Steve.tscn")
var Mona = preload("res://interfaces/on_daylight_menus/NPCs/Mona.tscn")
var Lisa = preload("res://interfaces/on_daylight_menus/NPCs/Lisa.tscn")

var npcArray = [Tyrone, Jerome, Matt, Layla, Harry, Tessa, Hugh, John, Chris, James, Jared, Ted, Mona, Lisa, Steve]

func _spawnNPC():
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
