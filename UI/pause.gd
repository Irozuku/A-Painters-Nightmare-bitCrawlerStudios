extends Control

@onready var resume = %Resume
@onready var menu = %Menu
@onready var exit = %Exit


# Called when the node enters the scene tree for the first time.
func _ready():
	resume.pressed.connect(_on_resume_pressed)
	menu.pressed.connect(_on_menu_pressed)
	exit.pressed.connect(_on_exit_pressed)
	
	hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = !get_tree().paused
		visible = get_tree().paused


func _on_resume_pressed():
	get_tree().paused = false
	hide()
	
func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")
	
func _on_exit_pressed():
	get_tree().quit()
