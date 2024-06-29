extends Node2D

@export var damage = 10

var colors

# Called when the node enters the scene tree for the first time.
func _ready():
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
	queue_free()  # Auto eliminar el nodo
