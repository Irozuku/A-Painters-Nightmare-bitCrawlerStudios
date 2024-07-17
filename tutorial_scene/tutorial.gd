extends Node2D

func _ready():
	AudioPlayer._play_music(null, 0)
	Global.reset_globals()
