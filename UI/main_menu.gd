extends Control

@onready var start = %Start
@onready var credits = %Credits
@onready var exit = %Exit


# Called when the node enters the scene tree for the first time.
func _ready():
	start.pressed.connect(_on_start_pressed)
	exit.pressed.connect(_on_exit_pressed)
	credits.pressed.connect(_on_credits_pressed)
	AudioPlayer.play_bgm_music()


func _on_start_pressed():
	AudioPlayer._play_music(null, 0)
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
func _on_exit_pressed():
	get_tree().quit()

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://credits/GodotCredits.tscn")
