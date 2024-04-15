extends "res://entity/EntityBase.gd"

func _physics_process(delta):
	pass
	
func die():
	queue_free()
