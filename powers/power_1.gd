extends Area2D

var speed: int = 250

var BASE_DAMAGE = Global.POWER_1_DAMAGE
var freeze_time = Global.FREEZE_TIME

@export var damage = BASE_DAMAGE
@export var color: Color

@export var colors: Array
var sprite_color

@onready var ray1 = $Ray1
@onready var sprite1 = $Line1
@onready var ray2 = $Ray2
@onready var sprite2 = $Line2
@onready var ray3 = $Ray3
@onready var sprite3 = $Line3
@onready var ray4 = $Ray4
@onready var sprite4 = $Line4

# Called when the node enters the scene tree for the first time.
func _ready():
	assign_colors(colors)
	sprite1.modulate = self.sprite_color
	sprite2.modulate = self.sprite_color
	sprite3.modulate = self.sprite_color
	sprite4.modulate = self.sprite_color
	if 0 in colors:
		damage += int(damage*Global.DAMAGE_BONUS)
	# Crear un temporizador para eliminar el nodo después de 2 segundos
	var timer = Timer.new()
	timer.wait_time = 2.5
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", Callable(self, "_on_timeout"))
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ray1.target_position += speed * Vector2.RIGHT * delta
	ray2.target_position += speed * Vector2.LEFT * delta
	ray3.target_position += speed * Vector2.UP * delta
	ray4.target_position += speed * Vector2.DOWN * delta
	sprite1.clear_points()
	sprite2.clear_points()
	sprite3.clear_points()
	sprite4.clear_points()
	sprite1.add_point(Vector2(0,0))
	sprite2.add_point(Vector2(0,0))
	sprite3.add_point(Vector2(0,0))
	sprite4.add_point(Vector2(0,0))
	sprite1.add_point(ray1.target_position)
	sprite2.add_point(ray2.target_position)
	sprite3.add_point(ray3.target_position)
	sprite4.add_point(ray4.target_position)
	check_collision(ray1)
	check_collision(ray2)
	check_collision(ray3)
	check_collision(ray4)

func check_collision(ray):
	if ray.is_colliding():
		var col_int = ray.get_collision_count()
		for i in col_int:
			var collider = ray.get_collider(i)
			SignalManager.power1(collider, self)
			#if 1 in colors:
				#SignalManager.freeze(collider, freeze_time)
				#print("Freezing")
			#if 2 in colors:
				#SignalManager.lifesteal(int(damage*0.1))
				#print("Gaining life")

func add_colors(paints):
	self.colors = paints.duplicate()
	
func assign_colors(colors):
	if 0 in colors:
		if 1 in colors:
			if 2 in colors:
				# Black
				self.color = "Black"
				self.sprite_color = Color("262626")
			else:
				# Purple
				self.color = "Purple"
				self.sprite_color = Color("aa00ff")
		elif 2 in colors:
			# Orange
			self.color = "Orange"
			self.sprite_color = Color("ffa200")
		else:
			# Red
			self.color = "Red"
			self.sprite_color = Color("ff0000")
	elif 1 in colors:
		if 2 in colors:
			# Green
			self.color = "Green"
			self.sprite_color = Color("0dff00")
		else:
			# Blue
			self.color = "Blue"
			self.sprite_color = Color("1100ff")
	elif 2 in colors:
		# Yellow
		self.color = "Yellow"
		self.sprite_color = Color("fbff00")

func _on_timeout():
	self.sprite_color = Color("ffffff")
	damage = BASE_DAMAGE
	queue_free()  # Auto eliminar el nodo
