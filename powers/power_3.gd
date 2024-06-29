extends "res://overlap/Hitbox.gd"

@export var speed: int = 400
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var projectile_asset = $ProjectileAsset

var BASE_DAMAGE = 10

var colors

# Called when the node enters the scene tree for the first time.
func _ready():
	damage = BASE_DAMAGE
	if 0 in colors:
		damage += int(damage*0.1)
	# Crear un temporizador para eliminar el nodo después de 2 segundos
	var timer = Timer.new()
	timer.wait_time = 2.0
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", Callable(self, "_on_timeout"))
	timer.start()

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * direction * delta
	
func destroy():
	colors.clear()
	damage = BASE_DAMAGE
	speed = 0
	var collision = get_node("CollisionShape2D")
	collision.call_deferred("set", "disabled", true)
	projectile_asset.hide()
	playback.travel("collision")
	await animation_tree.animation_finished
	queue_free()

func assing_colors(paints):
	colors = paints

func _on_area_entered(area):
	destroy()

func _on_body_entered(body):
	destroy()

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func _on_timeout():
	destroy()
