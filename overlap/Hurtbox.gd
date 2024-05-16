extends Area2D


@export_enum("Cooldown", "HitOnce", "DisableHitbox") var HurtboxType = 0

@onready var collision = $CollisionShape2D
#@onready var disableTimer = $DisableTimer

signal hurt(damage)
