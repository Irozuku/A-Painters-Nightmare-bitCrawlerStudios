extends Control

@onready var game_timer = $GameTimer
@onready var game_time_text = %GameTimeText
@onready var win_container = %WinContainer
@onready var back_menu = %BackMenu
@onready var exit = %ExitButton
@onready var player = %Player
@onready var lose_container = %LoseContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	game_timer.timeout.connect(_on_timeout)
	back_menu.pressed.connect(_on_menu_pressed)
	exit.pressed.connect(_on_exit_pressed)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	game_time_text.text = str(int(game_timer.get_time_left())/60) + ":" + str(int(game_timer.get_time_left())%60)

func _on_timeout():
	win_container.show()
	back_menu.show()
	exit.show()
	get_tree().paused = true

func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")

func _on_exit_pressed():
	get_tree().quit()

func _on_player_died():
	lose_container.show()
	back_menu.show()
	exit.show()
	get_tree().paused = true

