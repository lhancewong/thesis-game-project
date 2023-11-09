extends Path2D

#var timer = 0
#var spawnTime = 1

var Tyrone = preload("res://entities/NPCs/Tyrone.tscn")
var Jerome = preload("res://entities/NPCs/Jerome.tscn")
var Matt = preload("res://entities/NPCs/Matt.tscn")
var Layla = preload("res://entities/NPCs/Layla.tscn")
var Harry = preload("res://entities/NPCs/Harry.tscn")
var Tessa = preload("res://entities/NPCs/Tessa.tscn")
var Hugh = preload("res://entities/NPCs/Hugh.tscn")
var John = preload("res://entities/NPCs/John.tscn")
var Chris = preload("res://entities/NPCs/Chris.tscn")
var James = preload("res://entities/NPCs/James.tscn")
var Jared = preload("res://entities/NPCs/Jared.tscn")
var Ted = preload("res://entities/NPCs/Ted.tscn")
var Steve = preload("res://entities/NPCs/Steve.tscn")
var Mona = preload("res://entities/NPCs/Mona.tscn")
var Lisa = preload("res://entities/NPCs/Lisa.tscn")

var npcArray = [Tyrone, Jerome, Matt, Layla, Harry, Tessa, Hugh, John, Chris, James, Jared, Ted, Mona, Lisa, Steve]

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
