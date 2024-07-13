extends "res://overlap/Hitbox.gd"

@export var speed: int = 400
@export var piercing_enemies = 0
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var projectile_asset = $ProjectileAsset
@onready var explosion_asset = $ExplosionAsset

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * direction * delta
	
func destroy():
	speed = 0
	projectile_asset.hide()
	explosion_asset.show()
	var collision = get_node("CollisionShape2D")
	collision.call_deferred("set", "disabled", true)
	projectile_asset.hide()
	playback.travel("collision")
	await animation_tree.animation_finished
	queue_free()

func _on_area_entered(area):
	if piercing_enemies <= 0:
		destroy()
	else:
		piercing_enemies -= 1

func _on_body_entered(body):
	destroy()

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
