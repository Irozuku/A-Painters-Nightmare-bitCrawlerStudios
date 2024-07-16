extends "res://overlap/Hitbox.gd"

@onready var ColPolygon = $CollisionShape2D
@onready var sprite = $Sprite2D

@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")

var BASE_DAMAGE = Global.POWER_2_DAMAGE
var freeze_time = Global.FREEZE_TIME

@export var color: String

@export var colors: Array
var sprite_color

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.modulate = self.sprite_color
	damage = BASE_DAMAGE
	if 0 in colors:
		damage += int(damage*Global.DAMAGE_BONUS)
	# Crear un temporizador para eliminar el nodo después de 2 segundos
	var timer = Timer.new()
	timer.wait_time = 3.0
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", Callable(self, "_on_timeout"))
	timer.start()
	playback.travel("active")

#func _on_area_entered(area):
	#if 1 in colors:
		#SignalManager.freeze(area, freeze_time)
		#print("Freezing")
	#if 2 in colors:
		#SignalManager.lifesteal(int(damage*0.1))
		#print("Gaining life")

func assing_colors(paints):
	colors = paints
	if 0 in colors:
		if 1 in colors:
			if 2 in colors:
				# Black
				self.color = "Black"
				self.sprite_color = Color("262626")
			else:
				# Purple
				self.color = "Purple"
				self.sprite_color = Color("6300e6")
		elif 2 in colors:
			# Orange
			self.color = "Orange"
			self.sprite_color = Color("ffaf47")
		else:
			# Red
			self.color = "Red"
			self.sprite_color = Color("ff4747")
	elif 1 in colors:
		if 2 in colors:
			# Green
			self.color = "Green"
			self.sprite_color = Color("4aff47")
		else:
			# Blue
			self.color = "Blue"
			self.sprite_color = Color("4747ff")
	elif 2 in colors:
		# Yellow
		self.color = "Yellow"
		self.sprite_color = Color("f9ff47")

func _on_timeout():
	var collision = get_node("CollisionShape2D")
	collision.call_deferred("set", "disabled", true)
	playback.travel("End")
	await animation_tree.animation_finished
	self.sprite_color = Color("ffffff")
	colors.clear()
	damage = BASE_DAMAGE
	queue_free()
