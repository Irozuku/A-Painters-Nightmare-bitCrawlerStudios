extends Area2D

@onready var points = $"..".points
@onready var stroke = $"../Brushstroke"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_mouse_entered():
	if (Input.is_action_pressed("left_click")):
		if (points.find(6) == -1):
			points.append(6)
			stroke.add_stroke(position)
			print(points)


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if (points.find(6) == -1):
			points.append(6)
			stroke.add_stroke(position)
			print(points)
