extends Area2D

var points = []
@export var loaded_powers = []
@export var loaded_paints = []
var active_paint

@onready var text = $Label
@onready var remainder = $SymbolRemainder
@onready var timer = $Lockdown

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Loads corrrect patterns into power arrays
func load_power(power: String, paint: int):
	if (power not in loaded_powers):
		loaded_powers.append(power)
		loaded_paints.append(paint)
		remainder.hold(power)
		

## ONLY FOR DEBUG - CUT FROM MAIN
#func show_powers():
	#text.text = ""
	#var i = 0
	#while i < loaded_powers.size():
		#text.text += loaded_powers[i]
		#text.text += ": "+ str(loaded_paints[i])
		#i += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#show_powers()
	if (Input.is_action_just_released("left_click")):
		active_paint = $PaintBar.current_index
		if (points == [1, 5, 9, 6, 3, 7] or points == [7, 5, 3, 6, 9, 1]):
			load_power("Poder 1", active_paint)
		elif (points == [1, 2, 3, 5, 7, 8, 9] or points == [9, 8, 7, 5, 3, 2, 1]):
			load_power("Poder 2", active_paint)
		elif (points == [4, 8, 5, 2, 6] or points == [6, 2, 5, 8, 4]):
			load_power("Poder 3", active_paint)
		points.clear()
	if (Input.is_action_just_pressed("release_power")):
		if not (Input.is_action_pressed("left_click")):
			if not loaded_paints.is_empty() and not loaded_powers.is_empty():
				print("Sending powers to controler")
				SignalManager.send_power(loaded_powers, loaded_paints)
				remainder.release()
