extends Control

var choices = {
	0: {
		"int":0,
		"Name": "[center][i]Saint John on Patmos[/i][/center]",
		"Effect": "[center]Increase [color=red]Damage[/color] bonus[/center]"
	},
	1: {
		"int": 1,
		"Name": "[center][i]Saint Jerome at Prayer[/i][/center]",
		"Effect": "[center]Increase [color=blue]Freeze[/color] time[/center]"
	},
	2: {
		"int": 2,
		"Name": "[center][i]Saint Christopher[/i][/center]",
		"Effect": "[center]Increase [color=yellow]Heal[/color] bonus[/center]"
	},
	3: {
		"int": 3,
		"Name": "[center][i]Hermit Saints Triptych[/i][/center]",
		"Effect": "[center]Increase Speed[/center]"
	},
	4: {
		"int": 4,
		"Name": "[center][i]Saint Wilgefortis Triptych[/i][/center]",
		"Effect": "[center]Increase Glyph 1 speed[/center]"
	},
	5: {
		"int": 5,
		"Name": "[center][i]The Adoration of the Magi[/i][/center]",
		"Effect": "[center]Increase Glyph 2 radius[/center]"
	},
	6: {
		"int": 6,
		"Name": "[center][i]The Garden of Earthly Delights[/i][/center]",
		"Effect": "[center]Increase Glyph 3 Proyectiles[/center]"
	},
	7: {
		"int": 7,
		"Name": "[center][i]The Temptation of Saint Anthony[/i][/center]",
		"Effect": "[center]Increase [color=pink]Max HP[/color][/center]"
	}
}

var choice = preload("res://upgrades/choice.tscn")

@onready var skip = %Skip

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.connect("upgrade", Callable(self, "_on_upgrade"))
	skip.pressed.connect(_on_skip_pressed)
	var list = create_choices()
	var choice1 = choice.instantiate()
	choice1.position = Vector2(-230, 0)
	choice1.set_variables(choices.get(list[0]))
	add_child(choice1)
	var choice2 = choice.instantiate()
	choice2.position = Vector2(0, 0)
	choice2.set_variables(choices.get(list[1]))
	add_child(choice2)
	var choice3 = choice.instantiate()
	choice3.position = Vector2(230, 0)
	choice3.set_variables(choices.get(list[2]))
	add_child(choice3)

func _input(event):
	if Input.is_action_just_pressed("pause"):
		_on_skip_pressed()

func create_choices():
	var list = range(7)
	var sample = []
	for i in range(3):
		var x = randi()%list.size()
		sample.append(list[x])
		list.erase(x)
	print(sample)
	return sample

func apply_choice(val):
	if val == 0:
		Global.DAMAGE_BONUS += 0.05
		print("modification: " + str(Global.DAMAGE_BONUS))
	if val == 1:
		Global.FREEZE_TIME += 1
		print("modification: " + str(Global.FREEZE_TIME))
	if val == 2:
		Global.HEALING_BONUS += 0.05
		print("modification: " + str(Global.HEALING_BONUS))
	if val == 3:
		SignalManager.send_upgrade_speed(15)
	if val == 4:
		Global.POWER1_SPEED += 50
		print("modification: " + str(Global.POWER1_SPEED))
	if val == 5:
		Global.POWER2_RADIOUS += 25
		Global.POWER2_SCALE += Vector2(1.0, 1.0)
		print("modification: " + str(Global.POWER2_RADIOUS))
		print("modification: " + str(Global.POWER2_SCALE))
	if val == 6:
		Global.POWER3_ROUNDS += 5
		print("modification: " + str(Global.POWER3_ROUNDS))
	if val == 7:
		SignalManager.send_upgrade_max_hp(100)

func _on_skip_pressed():
	SignalManager.send_upgrade_taken()
	queue_free()

func _on_upgrade(upgrade):
	print("Recieving upgrade")
	apply_choice(upgrade.get("int"))
	SignalManager.send_upgrade_taken()
	queue_free()
