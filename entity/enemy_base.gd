extends CharacterBody2D

class_name Enemy

var type
var speed = 200
var target = Vector2()
var acceleration = 1000

	
	
func _ready():
	target = get_node("/root/Main/Player")

func _physics_process(delta):
	var direction_x = global_position.direction_to(target.global_position).x
	var direction_y = global_position.direction_to(target.global_position).y
	velocity.x = move_toward(velocity.x, direction_x * speed, acceleration * delta)
	velocity.y = move_toward(velocity.y, direction_y * speed, acceleration * delta)
	move_and_slide()
	
func die():
	queue_free()
