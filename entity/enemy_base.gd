extends EntityBase
class_name Enemy

var target = Vector2()
var frozen = false
@onready var animation_tree = $AnimationTree
@onready var animation_player = $AnimationPlayer
@onready var playback = animation_tree.get("parameters/playback")
@onready var hurtbox = $Hurtbox
@onready var hitbox = $Hitbox
@onready var hitbox_collision_shape = $Hitbox/CollisionShape2D2
@onready var hurtbox_collision_shape = $Hurtbox/CollisionShape2D
@onready var sprite = $Sprite
@export var ACCELERATION = 1000


func _ready():
	target = get_node("/root/Main/Player")
	SignalManager.connect("power1_collision", Callable(self, "_on_power1_collision"))
	SignalManager.connect("blue_freeze", Callable(self, "_on_blue_freeze"))

func _physics_process(delta):
	if frozen:
		return
	var direction = global_position.direction_to(target.global_position)
	velocity = velocity.move_toward(direction * SPEED, ACCELERATION * delta)
	move_and_slide()
	
	flip_sprite(direction.x)
	
func flip_sprite(direction_x):
	pass

func _on_power1_collision(obj, hitbox):
	# Emitir la señal de daño (o manejar el daño directamente)
	if hurtbox == obj:
		print("He sido colisionado")
		receive_damage(hitbox.damage)
		if 1 in hitbox.colors:
			# Freeze
			self.freeze(hitbox.freeze_time)
		if 2 in hitbox.colors:
			# Lifesteal
			SignalManager.lifesteal(int(hitbox.damage*0.1))

func freeze(time):
	print(name + ": Me congelo")
	self.frozen = true
	self.modulate = Color("00e1ff")
	await get_tree().create_timer(time).timeout
	self.modulate = Color("ffffff")
	self.frozen = false

func die():
	queue_free()

func _on_body_entered(body:Node2D):
	queue_free()

func _on_hurtbox_area_entered(hitbox):
	receive_damage(hitbox.damage)
	
	if hitbox.is_in_group("Power"):
		if 1 in hitbox.colors:
			# Freeze
			self.freeze(hitbox.freeze_time)
		if 2 in hitbox.colors:
			# Lifesteal
			SignalManager.lifesteal(int(hitbox.damage*0.1))
			
	if hitbox.is_in_group("Projectile"):
		hitbox.destroy()
		

