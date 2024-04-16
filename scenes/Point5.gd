extends Area2D

@onready var points = $"..".points
@onready var sprite = $PointSprite5
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_mouse_entered():
	if (Input.is_action_pressed("left_click")):
		sprite.modulate = Color("ff00ff")
		if (points.find(5) == -1):
			points.append(5)
			print(points)
