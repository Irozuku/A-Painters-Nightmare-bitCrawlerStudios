extends Node2D

var BASE_DAMAGE = 10

@export var damage = BASE_DAMAGE

var colors

# Called when the node enters the scene tree for the first time.
func _ready():
	if 0 in colors:
		damage += int(damage*0.1)
	# Crear un temporizador para eliminar el nodo después de 2 segundos
	var timer = Timer.new()
	timer.wait_time = 2.0
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", Callable(self, "_on_timeout"))
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func assing_colors(paints):
	colors = paints

func _on_timeout():
	colors.clear()
	damage = BASE_DAMAGE
	queue_free()  # Auto eliminar el nodo
