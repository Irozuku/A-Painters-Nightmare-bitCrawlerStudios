extends Node2D

const RADIUS = 250
var mouse_clicked
var player_position
var on_screen = true
var player_to_cursor
@onready var on_screen_cursor = $OnScreenCursor
@onready var off_screen_cursor = $OffScreenCursor


func _physics_process(delta):
	player_to_cursor = mouse_clicked - player_position
	if on_screen:
		global_position = mouse_clicked
	else:
		# global_position = RADIUS * player_position.direction_to(mouse_clicked) + player_position
		off_screen_cursor.global_position = RADIUS * player_position.direction_to(mouse_clicked) + player_position


func _on_visible_on_screen_notifier_2d_screen_entered():
	on_screen = true
	on_screen_cursor.show()
	off_screen_cursor.hide()

func _on_visible_on_screen_notifier_2d_screen_exited():
	on_screen = false
	on_screen_cursor.hide()
	off_screen_cursor.show()

func destroy():
	queue_free()
