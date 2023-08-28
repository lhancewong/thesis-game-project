extends Control


onready var vine_boom = $VineBoom
onready var BGM = $BGM


# Called when the node enters the scene tree for the first time.
func _ready():
	$BGM.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Start_pressed():
	vine_boom.play()


func _on_Options_pressed():
	vine_boom.play()


func _on_About_pressed():
	vine_boom.play()


func _on_Quit_pressed():
	vine_boom.play()
