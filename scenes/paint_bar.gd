extends Area2D

@onready var RedBorder = $RedPaint/RedBorder
@onready var BlueBorder = $BluePaint/BlueBorder
@onready var YellowBorder = $YellowPaint/YellowBorder

@onready var active = load("res://assets/border_sprite/border_on.png")
@onready var inactive = load("res://assets/border_sprite/border_off.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	RedBorder.texture = active

# Add connection to active_paint in grid
func change_active(paint):
	if (paint == RedBorder):
		RedBorder.texture = active
		BlueBorder.texture = inactive
		YellowBorder.texture = inactive
	elif (paint == BlueBorder):
		RedBorder.texture = inactive
		BlueBorder.texture = active
		YellowBorder.texture = inactive
	elif (paint == YellowBorder):
		RedBorder.texture = inactive
		BlueBorder.texture = inactive
		YellowBorder.texture = active

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("red_paint")):
		change_active(RedBorder)
	elif (Input.is_action_just_pressed("blue_paint")):
		change_active(BlueBorder)
	elif (Input.is_action_just_pressed("yellow_paint")):
		change_active(YellowBorder)
