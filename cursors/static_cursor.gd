extends Area2D

var ang
var RADIUS = 250
var velocity
func _physics_process(delta):
	global_position += velocity * delta

func destroy():
	queue_free()
