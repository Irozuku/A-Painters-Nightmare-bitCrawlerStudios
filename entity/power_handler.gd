extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.connect("power_released", Callable(self, "_on_power_released"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_power_released(powers, paints):
	print("Powers recieved")
	for power in powers:
		if (power == "Poder 1"):
			print("Lanzando poder 1")
			var power_scene = load("res://powers/power_1.tscn")
			var power_node = power_scene.instantiate()
			power_node.assing_colors(paints)
			add_child(power_node)
		elif (power == "Poder 2"):
			print("Lanzando poder 2")
			var power_scene = load("res://powers/power_2.tscn")
			var power_node = power_scene.instantiate()
			power_node.assing_colors(paints)
			add_child(power_node)
		elif (power == "Poder 3"):
			print("Lanzando poder 3")
			var power_scene = load("res://powers/power_3.tscn")
			for i in range(5):
				var power_node = power_scene.instantiate()
				var att_direction = get_parent().attack_direction
				att_direction = att_direction.rotated(randf_range(-1,1))
				var att_rotation = att_direction.angle()
				power_node.rotation = att_rotation
				power_node.assing_colors(paints)
				add_child(power_node)
