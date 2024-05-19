extends Area2D

#ChildrenNodes
@onready var border1 = $Symbol1/Border
@onready var border2 = $Symbol2/Border
@onready var border3 = $Symbol3/Border
@onready var p1 = $Symbol1/Sprite
@onready var p2 = $Symbol2/Sprite
@onready var p3 = $Symbol3/Sprite

#Assets
@onready var border_active = load("res://assets/border_sprite/border_remainder_on.png")
@onready var border_inactive = load("res://assets/border_sprite/border_remainder_off.png")
@onready var p1_active = load("res://assets/remainder_sprite/p1_remainder_on.png")
@onready var p2_active = load("res://assets/remainder_sprite/p2_remainder_on.png")
@onready var p3_active = load("res://assets/remainder_sprite/p3_remainder_on.png")
@onready var p1_inactive = load("res://assets/remainder_sprite/p1_remainder_off.png")
@onready var p2_inactive = load("res://assets/remainder_sprite/p2_remainder_off.png")
@onready var p3_inactive = load("res://assets/remainder_sprite/p3_remainder_off.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	border1.texture = border_inactive
	border2.texture = border_inactive
	border3.texture = border_inactive
	p1.texture = p1_inactive
	p2.texture = p2_inactive
	p3.texture = p3_inactive

func hold(poder: String):
	if (poder == "Poder 1"):
		border1.texture = border_active
		p1.texture = p1_active
	elif (poder == "Poder 2"):
		border2.texture = border_active
		p2.texture = p2_active
	elif (poder == "Poder 3"):
		border3.texture = border_active
		p3.texture = p3_active

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
