extends "res://entity/EntityBase.gd"

@export var BASIC_ATTACK: PackedScene = preload("res://projectiles/basic_attack.tscn")
@onready var basic_attack_timer = $BasicAttackTimer

@onready var STATIC_CURSOR : PackedScene = preload("res://cursor/static_cursor.tscn")


var attack_direction
var static_direction
var change_attack = false
var static_cursor_img = null

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Select direction
	var direction = Input.get_vector("left", "right", "up", "down")
	# Get velocity
	velocity = direction * SPEED
	move_and_slide()
	
	attack_direction = self.global_position.direction_to(get_global_mouse_position())
	if change_attack:
		attack_direction = self.global_position.direction_to(static_cursor_img.global_position)
		static_cursor_img.player_position = self.global_position
	
	if Input.is_action_just_pressed("static_basic_attack"):
		change_attack = !change_attack
		if change_attack:
			static_cursor_img = STATIC_CURSOR.instantiate()
			get_tree().current_scene.add_child(static_cursor_img)
			static_cursor_img.mouse_clicked = get_global_mouse_position()
			static_cursor_img.player_position = self.global_position
		else:
			static_cursor_img.destroy()
		
	if basic_attack_timer.is_stopped():
		basic_attack(attack_direction)

func basic_attack(att_direction: Vector2):
	if BASIC_ATTACK:
		var att = BASIC_ATTACK.instantiate()
		get_tree().current_scene.add_child(att)
		att.global_position = self.global_position
		
		var att_rotation = att_direction.angle()
		att.rotation = att_rotation
		
		basic_attack_timer.start()


