extends EntityBase
class_name Enemy

var type
var target = Vector2()
var acceleration = 1000
var frozen = false
@onready var animation_tree = $AnimationTree
@onready var animation_player = $AnimationPlayer
@onready var playback = animation_tree.get("parameters/playback")
@onready var hurtbox = $Hurtbox
@onready var hitbox = $Hitbox
@onready var hitbox_collision_shape = $Hitbox/CollisionShape2D2
@onready var hurtbox_collision_shape = $Hurtbox/CollisionShape2D
@onready var sprite = $Sprite


func _ready():
	target = get_node("/root/Main/Player")
	SignalManager.connect("power1_collision", Callable(self, "_on_power1_collision"))
	SignalManager.connect("blue_freeze", Callable(self, "_on_blue_freeze"))

func _physics_process(delta):
	if frozen:
		return
	var direction_x = global_position.direction_to(target.global_position).x
	var direction_y = global_position.direction_to(target.global_position).y
	velocity.x = move_toward(velocity.x, direction_x * SPEED, acceleration * delta)
	velocity.y = move_toward(velocity.y, direction_y * SPEED, acceleration * delta)
	move_and_slide()
	
	flip_sprite(direction_x)
	
func flip_sprite(direction_x):
	pass

func _on_power1_collision(obj, damage):
	# Emitir la señal de daño (o manejar el daño directamente)
	if hurtbox == obj:
		print("He sido colisionado")
		receive_damage(damage)

func _on_blue_freeze(obj, time):
	if hitbox == obj:
		print(name + ": Me congelo")
		self.frozen = true
		sprite.self_modulate = Color("00e1ff")
		await get_tree().create_timer(time).timeout
		sprite.self_modulate = Color("ffffff")
		self.frozen = false

func die():
	queue_free()

func _on_body_entered(body:Node2D):
	queue_free()


