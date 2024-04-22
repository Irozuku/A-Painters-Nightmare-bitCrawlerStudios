extends Line2D


@onready var point_array = $"..".points

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_released("left_click")):
		clear_points()

func add_stroke(vector: Vector2):
	add_point(vector)
