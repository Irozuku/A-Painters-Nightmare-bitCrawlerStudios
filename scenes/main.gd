extends Node2D

@onready var SATYR: PackedScene = preload("res://entity/enemies/satyr.tscn")
@onready var FLYING_DEMON: PackedScene = preload("res://entity/enemies/flying_demon.tscn")
@onready var player = $Player
@onready var spawn_timer = $SpawnTimer
@onready var game_timer = $Player/CanvasLayer/GameUI/GameTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)

# Called when the spawn timer times out
func _on_spawn_timer_timeout():
	var e = SATYR
	# At 8:30 min left spawn flying demons
	if game_timer.time_left <= 510:
		e = FLYING_DEMON
	spawn_enemy(e)
	
	## At 7 min spawn the boss and reduce the normal enemy spawn rate
	#if game_timer.time_left <= 420:
		#spawn_timer.set_wait_time(3)
	## At 5:30 min or when the boss is dead put the normal enemy spawn rate at 1 again (default)
	#if game_timer.time_left <= 330 or not is_boss_alive:
		#spawn_timer.set_wait_time(1)

func spawn_enemy(e):
	var enemy_instance = e.instantiate()
	enemy_instance.global_position = get_random_position()
	add_child(enemy_instance)

func get_random_position():
	var vpr = get_viewport_rect().size * randf_range(1.1, 1.4)
	var top_left = Vector2(player.global_position.x - vpr.x / 2, player.global_position.y - vpr.y / 2)
	var top_right = Vector2(player.global_position.x + vpr.x / 2, player.global_position.y - vpr.y / 2)
	var bottom_left = Vector2(player.global_position.x - vpr.x / 2, player.global_position.y + vpr.y / 2)
	var bottom_right = Vector2(player.global_position.x + vpr.x / 2, player.global_position.y + vpr.y / 2)
	var pos_side = ["up", "down", "right", "left"].pick_random()
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO
	
	match pos_side:
		"up":
			spawn_pos1 = top_left
			spawn_pos2 = top_right
		"down":
			spawn_pos1 = bottom_left
			spawn_pos2 = bottom_right
		"right":
			spawn_pos1 = top_right
			spawn_pos2 = bottom_right
		"left":
			spawn_pos1 = top_left
			spawn_pos2 = bottom_left
	
	var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos1.y, spawn_pos2.y)
	return Vector2(x_spawn, y_spawn)
