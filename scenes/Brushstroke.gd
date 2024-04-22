extends Line2D

@onready var point_array = $"..".points

@onready var red_stroke = load("res://assets/stroke_sprite/stroke1.png")
@onready var blue_stroke = load("res://assets/stroke_sprite/stroke2.png")
@onready var yellow_stroke = load("res://assets/stroke_sprite/stroke3.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var paint = $"../PaintBar".current_index
	if not (Input.is_action_pressed("left_click")):
		if(paint == 0):
			texture = red_stroke
		elif(paint == 1):
			texture = blue_stroke
		elif(paint == 2):
			texture = yellow_stroke
	if (Input.is_action_just_released("left_click")):
		clear_points()

func add_stroke(vector: Vector2):
	add_point(vector)
