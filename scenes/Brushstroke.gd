extends Line2D


@onready var point_array = $"..".points

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_released("left_click")):
		clear_points()

func _on_point_1_mouse_entered():
	if (Input.is_action_pressed("left_click")):
		if $"../Point1".position not in points:
			add_point($"../Point1".position)

func _on_point_2_mouse_entered():
	if (Input.is_action_pressed("left_click")):
		if $"../Point2".position not in points:
			add_point($"../Point2".position)

func _on_point_3_mouse_entered():
	if (Input.is_action_pressed("left_click")):
		if $"../Point3".position not in points:
			add_point($"../Point3".position)

func _on_point_4_mouse_entered():
	if (Input.is_action_pressed("left_click")):
		if $"../Point4".position not in points:
			add_point($"../Point4".position)

func _on_point_5_mouse_entered():
	if (Input.is_action_pressed("left_click")):
		if $"../Point5".position not in points:
			add_point($"../Point5".position)

func _on_point_6_mouse_entered():
	if (Input.is_action_pressed("left_click")):
		if $"../Point6".position not in points:
			add_point($"../Point6".position)

func _on_point_7_mouse_entered():
	if (Input.is_action_pressed("left_click")):
		if $"../Point7".position not in points:
			add_point($"../Point7".position)

func _on_point_8_mouse_entered():
	if (Input.is_action_pressed("left_click")):
		if $"../Point8".position not in points:
			add_point($"../Point8".position)

func _on_point_9_mouse_entered():
	if (Input.is_action_pressed("left_click")):
		if $"../Point9".position not in points:
			add_point($"../Point9".position)
