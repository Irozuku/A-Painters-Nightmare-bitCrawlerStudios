extends "res://overlap/Hitbox.gd"

@export var SPEED: int = 200

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += SPEED * direction * delta


func destroy():
	queue_free()

func _on_area_entered(area):
	destroy()

func _on_body_entered(body):
	destroy()
	
func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
