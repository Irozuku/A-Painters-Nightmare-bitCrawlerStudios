extends "res://entity/EntityBase.gd"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Select direction
	var direction = Input.get_vector("left", "right", "up", "down")
	# Get velocity
	velocity = direction * SPEED

	move_and_slide()
