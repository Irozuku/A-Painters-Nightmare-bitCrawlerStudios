extends "res://overlap/Hitbox.gd"

@export var speed: int = 400
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var projectile_asset = $ProjectileAsset

var BASE_DAMAGE = 182
var freeze_time = 4

var colors
var sprite_color

# Called when the node enters the scene tree for the first time.
func _ready():
	projectile_asset.modulate = self.sprite_color
	damage = BASE_DAMAGE
	if 0 in colors:
		damage += int(damage*0.1)

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * direction * delta
	
func destroy():
	colors.clear()
	self.sprite_color = Color("ffffff")
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
	if 0 in colors:
		if 1 in colors:
			if 2 in colors:
				self.sprite_color = Color("262626")
			else:
				self.sprite_color = Color("7c00c9")
		elif 2 in colors:
			self.sprite_color = Color("ffad5c")
		else:
			self.sprite_color = Color("ff5c5c")
	elif 1 in colors:
		if 2 in colors:
			self.sprite_color = Color("15ff00")
		else:
			self.sprite_color = Color("3023de")
	elif 2 in colors:
		self.sprite_color = Color("ddff00")

func _on_area_entered(area):
	if 1 in colors:
		SignalManager.freeze(area, freeze_time)
		print("Freezing")
	if 2 in colors:
		SignalManager.lifesteal(int(damage*0.1))
		print("Gaining life")
	destroy()

func _on_body_entered(body):
	destroy()

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
