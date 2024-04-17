extends "res://entity/EntityBase.gd"

@export var BASIC_ATTACK: PackedScene = preload("res://projectiles/basic_attack.tscn")
@onready var basic_attack_timer = $BasicAttackTimer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Select direction
	var direction = Input.get_vector("left", "right", "up", "down")
	# Get velocity
	velocity = direction * SPEED
	move_and_slide()
	
	if basic_attack_timer.is_stopped():
		basic_attack(self.global_position.direction_to(get_global_mouse_position()))

func basic_attack(att_direction: Vector2):
	if BASIC_ATTACK:
		var att = BASIC_ATTACK.instantiate()
		get_tree().current_scene.add_child(att)
		att.global_position = self.global_position
		
		var att_rotation = att_direction.angle()
		att.rotation = att_rotation
		
		basic_attack_timer.start()


