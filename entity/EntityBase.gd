extends CharacterBody2D

signal hp_max_changed(new_hp_max)
signal hp_changed(new_hp)
signal died

@export var hp_max: int = 2000: set = set_hp_max
@export var hp: int = hp_max: set = set_hp, get = get_hp
@export var defense: int = 0

@export var SPEED: int = 300

@onready var sprite = $Sprite
@onready var collShape = $CollisionShape2D
@onready var animPlayer = $AnimationPlayer

func set_hp_max(value):
	if value != hp_max:
		hp_max = max(0, value)
		emit_signal("hp_max_changed", hp_max)
		self.hp = hp

func set_hp(value):
	if value != hp:
		hp = clamp(value, 0, hp_max)
		emit_signal("hp_changed", hp)
		if hp == 0:
			emit_signal("died")
	
func get_hp():
	return hp

func _physics_process(delta):
	move_and_slide()

func die():
	queue_free()

func receive_damage(base_damage: int):
	var actual_damage = base_damage
	actual_damage -= defense
	
	self.hp -= actual_damage
	print(name + " received " + str(actual_damage) + " damage" + ", current hp: " + str(hp))


func _on_hurtbox_area_entered(hitbox):
	receive_damage(hitbox.damage)
	
	if hitbox.is_in_group("Projectile"):
		hitbox.destroy()
		

func _on_died():
	die()
