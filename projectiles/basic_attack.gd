extends "res://overlap/Hitbox.gd"

@export var speed: int = 400
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * direction * delta
	

func destroy():
	speed = 0
	get_node("CollisionShape2D").disabled = true
	playback.travel("remove_projectile")
	await $AnimationPlayer.animation_finished
	queue_free()
	

func _on_area_entered(area):
	destroy()

func _on_body_entered(body):
	destroy()
	
func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
