extends Node

onready var vine_boom = $VineBoom
onready var bgm = $BackgroundMusic
onready var fart = $DryFart
onready var crimson_moon = $CrimsonMoon
onready var scream = $Scream
onready var nani = $Nani

onready var king_laugh = $KingLaugh
onready var king_cry = $KingCry
onready var button_click = $ButtonClick
onready var button_click_two = $ButtonClickTwo
onready var value_change = $ValueChange
onready var progress_fill = $ProgressFill
onready var angry_noise = $AngryNoise
onready var happy_noise = $HappyNoise


func master_mute():
	bgm.stream_paused = !bgm.stream_paused
