extends CharacterBody2D
class_name EntityBase

signal hp_max_changed(new_hp_max)
signal hp_changed(new_hp)
signal died

@export var hp_max: int = 100: set = set_hp_max
@export var hp: int = hp_max: set = set_hp, get = get_hp
@export var defense: int = 0

@export var SPEED: int = 300

@onready var collShape = $CollisionShape2D
@onready var animPlayer = $AnimationPlayer
@onready var inv_frame = $InvFrame


func set_hp_max(value):
	if value != hp_max:
		hp_max = max(0, value)
		emit_signal("hp_max_changed", hp_max)
		self.hp = hp_max

func set_hp(value):
	hp = clamp(value, 0, hp_max)
	emit_signal("hp_changed", hp)
	if hp == 0:
		emit_signal("died")
	
func get_hp():
	return hp

func _physics_process(delta):
	pass

func die():
	queue_free()

func receive_damage(base_damage: int):
	if inv_frame.is_stopped():
		inv_frame.start()
		
		var actual_damage = base_damage - defense
		self.hp -= actual_damage
	
		print(name + " received " + str(actual_damage) + " damage" + ", current hp: " + str(self.hp))

func heal(hp_gained: int):
	if self.hp + hp_gained > self.hp_max:
		self.hp = self.hp_max
	else:
		self.hp += hp_gained
	
	print(name + " healed " + str(hp_gained) + " hp" + ", current hp: " + str(self.hp))

func _on_hurtbox_area_entered(hitbox):
	receive_damage(hitbox.damage)
	
	#if hitbox.is_in_group("Power"):
		#pass
	
	#if hitbox.is_in_group("Projectile"):
		#hitbox.destroy()
		

func _on_died():
	die()


func _on_hp_changed(new_hp):
	pass
