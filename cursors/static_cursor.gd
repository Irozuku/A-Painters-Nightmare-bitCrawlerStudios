extends Area2D

const RADIUS = 250
var mouse_clicked
var player_position
var on_screen = true
var player_to_cursor


func _physics_process(delta):
	player_to_cursor = mouse_clicked - player_position
	if on_screen:
		global_position = mouse_clicked
	else:
		global_position = RADIUS * player_position.direction_to(mouse_clicked) + player_position


func _on_visible_on_screen_notifier_2d_screen_entered():
	on_screen = true

func _on_visible_on_screen_notifier_2d_screen_exited():
	on_screen = false

func destroy():
	queue_free()
