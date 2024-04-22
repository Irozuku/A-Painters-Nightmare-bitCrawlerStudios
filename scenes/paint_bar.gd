extends Area2D

@onready var RedBorder = $RedPaint/RedBorder
@onready var BlueBorder = $BluePaint/BlueBorder
@onready var YellowBorder = $YellowPaint/YellowBorder

@onready var PaintList = [RedBorder, BlueBorder, YellowBorder]
@onready var current_index

@onready var active = load("res://assets/border_sprite/border_on.png")
@onready var inactive = load("res://assets/border_sprite/border_off.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	RedBorder.texture = active
	current_index = 0

# Change the active paint color
func change_active(paint):
	for border in PaintList:
		border.texture = inactive
	current_index = paint
	PaintList[current_index].texture = active

func shift_active_right():
	current_index = (current_index+1)%3
	for border in PaintList:
		border.texture = inactive
	PaintList[current_index].texture = active
	
func shift_active_left():
	current_index = (current_index-1)%3
	for border in PaintList:
		border.texture = inactive
	PaintList[current_index].texture = active
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("red_paint")):
		change_active(0)
	if (Input.is_action_just_pressed("blue_paint")):
		change_active(1)
	if (Input.is_action_just_pressed("yellow_paint")):
		change_active(2)
	if (Input.is_action_just_pressed("change_paint_left")):
		shift_active_left()
	if (Input.is_action_just_pressed("change_paint_right")):
		shift_active_right()
