extends EntityBase

@export var BASIC_ATTACK: PackedScene = preload("res://projectiles/basic_attack.tscn")
@onready var basic_attack_timer = $BasicAttackTimer

signal dead_animation_finished

@onready var STATIC_CURSOR : PackedScene = preload("res://cursor/static_cursor.tscn")
@onready var health_bar = %HealthBar
@onready var sprite = $Sprite
@onready var hurtbox_collision_shape = $Hurtbox/CollisionShape2D
@onready var animation_tree = $AnimationTree
@onready var animation_player = $AnimationPlayer
@onready var playback = animation_tree.get("parameters/playback")
@onready var Basic_attack_sound = $Basic_attack_sound
@onready var collision_shape_2d = $CollisionShape2D

var attack_direction
var static_direction
var change_attack = false
var static_cursor_img = null

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	SignalManager.connect("gain_life", Callable(self, "_on_gain_life"))
	health_bar.max_value = self.hp_max
	health_bar.value = self.hp

func _physics_process(delta):
	# Select direction
	var direction = Input.get_vector("left", "right", "up", "down")
	# Get velocity
	velocity = direction * SPEED
	move_and_slide()
	
	flip_sprite(direction.x)
	
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
		Basic_attack_sound.play()
		var att = BASIC_ATTACK.instantiate()
		get_tree().current_scene.add_child(att)
		att.global_position = self.global_position
		
		var att_rotation = att_direction.angle()
		att.rotation = att_rotation
		
		basic_attack_timer.start()


func _input(event):
	if event.is_action_pressed("remove_health"):
		self.set_hp(self.hp-1)

func _on_gain_life(hp):
	heal(hp)

func _on_hp_changed(new_hp):
	if health_bar:
		health_bar.value = new_hp
	if playback:
		playback.travel("damage_taken")

func die():
	playback.travel("dead")
	SPEED = 0
	basic_attack_timer.start(999999999)
	hurtbox_collision_shape.set_deferred("disabled", true)
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 0.6
	timer.one_shot = true
	timer.connect("timeout", _on_dead_animation_finished)
	timer.start()

func _on_dead_animation_finished():
	emit_signal("dead_animation_finished")

func flip_sprite(direction_x):
	# Rotación del sprite según la dirección horizontal
	if direction_x < 0:
		sprite.flip_h = true  # Voltea el sprite hacia la izquierda
		hurtbox_collision_shape.position.x = abs(hurtbox_collision_shape.position.x) * -1
		collision_shape_2d.position.x = abs(hurtbox_collision_shape.position.x) * -1
	elif direction_x > 0:
		hurtbox_collision_shape.position.x = abs(hurtbox_collision_shape.position.x)
		collision_shape_2d.position.x = abs(hurtbox_collision_shape.position.x)
		sprite.flip_h = false   # Deja el sprite sin voltear hacia la derecha
