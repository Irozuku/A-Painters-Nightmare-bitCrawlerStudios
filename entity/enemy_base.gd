#extends CharacterBody2D
extends "res://entity/EntityBase.gd"
class_name Enemy

var type
var target = Vector2()
var acceleration = 1000

	
	
func _ready():
	target = get_node("/root/Main/Player")
	#body_entered.connect(_on_body_entered)

func _physics_process(delta):
	var direction_x = global_position.direction_to(target.global_position).x
	var direction_y = global_position.direction_to(target.global_position).y
	velocity.x = move_toward(velocity.x, direction_x * SPEED, acceleration * delta)
	velocity.y = move_toward(velocity.y, direction_y * SPEED, acceleration * delta)
	move_and_slide()
	
func die():
	queue_free()
	
func _on_body_entered(body:Node2D):
	queue_free()
