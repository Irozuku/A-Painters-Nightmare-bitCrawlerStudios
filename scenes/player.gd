extends CharacterBody2D


const SPEED = 500.0


func _physics_process(delta):
	# Select direction
	var direction = Input.get_vector("left", "right", "up", "down")
	# Get velocity
	velocity = direction * SPEED

	move_and_slide()
