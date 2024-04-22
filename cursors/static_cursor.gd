extends Area2D


const RADIUS = 250
const RADIUS_SQUARED = RADIUS**2
var mouse_clicked
var player_position
var player_to_cursor
var ang
func _physics_process(delta):
	player_to_cursor = mouse_clicked - player_position
	if player_to_cursor.x**2 + player_to_cursor.y**2 < RADIUS_SQUARED:
		global_position = mouse_clicked
	else:
		global_position = RADIUS*player_position.direction_to(mouse_clicked) + player_position

func destroy():
	queue_free()
