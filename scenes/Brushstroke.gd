extends Line2D


@onready var point_array = $"..".points

var point_dict = {
	1: Vector2(-119, -119),
	2: Vector2(0, -119),
	3: Vector2(119, -119),
	4: Vector2(-119, 0),
	5: Vector2(0, 0),
	6: Vector2(119, 0),
	7: Vector2(-119, 119),
	8: Vector2(0, 119),
	9: Vector2(119, 119)
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_released("left_click")):
		clear_points()

func _on_point_1_mouse_entered():
	if point_dict[1] not in points:
		add_point(point_dict[1])


func _on_point_2_mouse_entered():
	if point_dict[2] not in points:
		add_point(point_dict[2])


func _on_point_3_mouse_entered():
	pass # Replace with function body.


func _on_point_4_mouse_entered():
	pass # Replace with function body.


func _on_point_5_mouse_entered():
	pass # Replace with function body.


func _on_point_6_mouse_entered():
	pass # Replace with function body.


func _on_point_7_mouse_entered():
	pass # Replace with function body.


func _on_point_8_mouse_entered():
	pass # Replace with function body.


func _on_point_9_mouse_entered():
	pass # Replace with function body.
