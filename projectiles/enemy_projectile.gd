extends "res://overlap/Hitbox.gd"

@export var speed: int = 400
@export var piercing_enemies = 0
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var sprite_2d = $Sprite2D

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * direction * delta
	
func destroy():
	queue_free()

func _on_area_entered(area):
	if piercing_enemies <= 0:
		destroy()
	else:
		piercing_enemies -= 1

func _on_time_alive_timeout():
	queue_free()
