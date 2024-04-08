extends Area2D

var points = []

@onready var sprite1 = $Point1/PointSprite1
@onready var sprite2 = $Point2/PointSprite2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_released("left_click")):
		if (points == [1, 2]):
			sprite1.modulate = Color("ffffff")
			sprite2.modulate = Color("ffffff")
			print("Poder 1")
			points.clear()
		if (points == [2, 1]):
			sprite1.modulate = Color("ffffff")
			sprite2.modulate = Color("ffffff")
			print("Poder 2")
			points.clear()


func _on_point_1_mouse_entered():
	if (Input.is_action_pressed("left_click")):
		if (points.find(1) == -1):
			points.append(1)
			print(points)


func _on_point_2_mouse_entered():
	if (Input.is_action_pressed("left_click")):
		if (points.find(2) == -1):
			points.append(2)
			print(points)
