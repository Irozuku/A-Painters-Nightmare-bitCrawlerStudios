extends Node2D

@onready var SATYR: PackedScene = preload("res://entity/enemies/satyr.tscn")
@onready var FLYING_DEMON: PackedScene = preload("res://entity/enemies/flying_demon.tscn")
@onready var RED_SLIME: PackedScene = preload("res://entity/enemies/red_slime.tscn")
@onready var BLUE_SLIME: PackedScene = preload("res://entity/enemies/blue_slime.tscn")
@onready var WHITE_SLIME: PackedScene = preload("res://entity/enemies/white_slime.tscn")
@onready var NECROMANCER_BOSS: PackedScene = preload("res://entity/enemies/necromancer_boss.tscn")
@onready var player = $Player
@onready var spawn_timer = $SpawnTimer
@onready var game_timer = $Player/CanvasLayer/GameUI/GameTimer
@onready var boss_timer = $BossTimer

var spawn_rate_changed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	AudioPlayer._play_music(null, 0)
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	boss_timer.timeout.connect(_on_boss_spawn)

# Spawn the boss at 5:00 and reduce the spawn rate
func _on_boss_spawn():
	spawn_timer.set_wait_time(1.2)
	spawn_enemy(NECROMANCER_BOSS)

# Called when the spawn timer times out
func _on_spawn_timer_timeout():
	# At 1:00 min left spawn all enemies and increase spawn rate by 1.1x
	if game_timer.time_left <= 60:
		if not spawn_rate_changed:
			spawn_rate_changed = true
			spawn_timer.set_wait_time(0.9)
		var e = [SATYR, FLYING_DEMON, RED_SLIME, BLUE_SLIME, WHITE_SLIME].pick_random()
		spawn_enemy(e)
	# At 2:00 min left spawn blue, slimes, flying demons
	elif game_timer.time_left <= 120:
		var e = [BLUE_SLIME, FLYING_DEMON].pick_random()
		spawn_enemy(e)
	# At 3:30 min left spawn blue slimes, red slimes
	# At 3:30 min left put the normal enemy spawn rate at 1 again (default
	elif game_timer.time_left <= 210:
		var e = [RED_SLIME, BLUE_SLIME].pick_random()
		spawn_timer.set_wait_time(1)
		spawn_enemy(e)
	# At 6:30 min left spawn white slimes with satyres
	elif game_timer.time_left <= 390:
		var e = [SATYR, WHITE_SLIME].pick_random()
		spawn_enemy(e)
	# At 8:30 min left spawn flying demons
	elif game_timer.time_left <= 510:
		spawn_enemy(FLYING_DEMON)
	# From the start to 8:30 spawn satyr
	else:
		spawn_enemy(SATYR)

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
