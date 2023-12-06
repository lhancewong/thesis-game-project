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
var Rob = preload("res://entities/NPCs/Rob.tscn")
var Mary = preload("res://entities/NPCs/Mary.tscn")
var Ken = preload("res://entities/NPCs/Ken.tscn")
var Alan = preload("res://entities/NPCs/Alan.tscn")
var Justine = preload("res://entities/NPCs/Justine.tscn")
var Dorothea = preload("res://entities/NPCs/Dorothea.tscn")
var Carmella = preload("res://entities/NPCs/Carmella.tscn")
var Sam = preload("res://entities/NPCs/Sam.tscn")
var Amy = preload("res://entities/NPCs/Amy.tscn")
var Serena = preload("res://entities/NPCs/Serena.tscn")
var Him = preload("res://entities/NPCs/Him.tscn")

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
	Him
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
