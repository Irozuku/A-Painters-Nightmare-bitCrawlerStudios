extends Area2D

var inactive = preload("res://assets/upgrade_sprite/border_0.png")
var active = preload("res://assets/upgrade_sprite/border_1.png")

@onready var art = $art
@onready var border = $border
@onready var name_txt = $Name
@onready var effect_txt = $Effect

var choice

# Called when the node enters the scene tree for the first time.
func _ready():
	art.texture = load("res://assets/upgrade_sprite/" + str(choice.get("int")) + ".jpg")
	name_txt.text = choice.get("Name")
	effect_txt.text = choice.get("Effect")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_variables(variable):
	choice = variable

func _on_mouse_entered():
	border.texture = active
	name_txt.show()
	effect_txt.show()

func _on_mouse_exited():
	border.texture = inactive
	name_txt.hide()
	effect_txt.hide()


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		print("Sending upgrade")
		SignalManager.send_upgrade(self.choice)
