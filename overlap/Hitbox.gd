extends Area2D

@export var damage = 10
@onready var collision = $CollisionShape2D2
@onready var disableTimer = $DisableTimer

func tempdisable():
	collision.call_deferred("set","disabled", true)
	disableTimer.start()




func _on_disable_timer_timeout():
	collision.call_deferred("set","disabled", false)
