extends CharacterBody2D

@export var hp_max: int = 100
@export var hp: int = hp_max
@export var defense: int = 0

@export var SPEED: int = 300

@onready var sprite = $Sprite
@onready var collShape = $CollisionShape2D
@onready var animPlayer = $AnimationPlayer

func _physics_process(delta):
	move_and_slide()

func die():
	queue_free()


func _on_hurtbox_area_entered(hitbox):
	var base_damage = hitbox.damage
	self.hp -= base_damage
	print(hitbox.get_parent().name + "'s hitbox toched " + name + "'s hurtbox and dealt " + str(base_damage))
