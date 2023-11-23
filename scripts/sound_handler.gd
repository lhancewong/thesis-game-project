extends Node

onready var vine_boom = $VineBoom
onready var bgm = $BackgroundMusic
onready var fart = $DryFart


func master_mute():
	bgm.stream_paused = !bgm.stream_paused
