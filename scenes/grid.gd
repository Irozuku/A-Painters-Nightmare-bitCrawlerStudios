extends Area2D

var points = []
var active_paint

@onready var text = $Label
@onready var sprite1 = $Point1/PointSprite1
@onready var sprite2 = $Point2/PointSprite2
@onready var sprite3 = $Point3/PointSprite3
@onready var sprite4 = $Point4/PointSprite4
@onready var sprite5 = $Point5/PointSprite5
@onready var sprite6 = $Point6/PointSprite6
@onready var sprite7 = $Point7/PointSprite7
@onready var sprite8 = $Point8/PointSprite8
@onready var sprite9 = $Point9/PointSprite9

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_released("left_click")):
		if (points == []):
			text.text = "Nada"
		elif (points == [1, 5, 9, 6, 3, 7] or points == [7, 5, 3, 6, 9, 1]):
			text.text = "Poder 1"
		elif (points == [1, 2, 3, 5, 7, 8, 9] or points == [9, 8, 7, 5, 3, 2, 1]):
			text.text = "Poder 2"
		elif (points == [4, 8, 5, 2, 6] or points == [6, 2, 5, 8, 4]):
			text.text = "Poder 3"
		else:
			text.text = "Incorrecto"
		sprite1.modulate = Color("ffffff")
		sprite2.modulate = Color("ffffff")
		sprite3.modulate = Color("ffffff")
		sprite4.modulate = Color("ffffff")
		sprite5.modulate = Color("ffffff")
		sprite6.modulate = Color("ffffff")
		sprite7.modulate = Color("ffffff")
		sprite8.modulate = Color("ffffff")
		sprite9.modulate = Color("ffffff")
		points.clear()
