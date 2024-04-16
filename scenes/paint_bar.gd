extends Area2D

@onready var RedBorder = $RedPaint/RedBorder
@onready var BlueBorder = $BluePaint/BlueBorder
@onready var YellowBorder = $YellowPaint/YellowBorder

@onready var active = load("res://assets/border_sprite/border_on.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	RedBorder.texture = active


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
