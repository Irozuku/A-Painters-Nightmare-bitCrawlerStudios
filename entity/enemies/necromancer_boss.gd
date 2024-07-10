extends Enemy

@onready var RED_SLIME: PackedScene = preload("res://entity/enemies/red_slime.tscn")
@onready var BLUE_SLIME: PackedScene = preload("res://entity/enemies/blue_slime.tscn")

@onready var PROJECTILE: PackedScene = preload("res://projectiles/enemy_projectile.tscn")

@onready var RED_EFFECT: PackedScene = preload("res://effects/red_slime_summon_effect.tscn")
@onready var BLUE_EFFECT: PackedScene = preload("res://effects/blue_slime_summon_effect.tscn")
@onready var WARNING_EFFECT: PackedScene = preload("res://effects/warning_effect.tscn")

var attack_timer = 4
var enraged = false

func _physics_process(delta):
	var direction = global_position.direction_to(target.global_position)
	velocity.x = move_toward(velocity.x, direction.x * SPEED, acceleration * delta)
	velocity.y = move_toward(velocity.y, direction.y * SPEED, acceleration * delta)
	
	flip_sprite(direction.x)
	
	if not enraged:
		if hp*4<hp_max:
			sprite.self_modulate = Color("ff009a")
			enraged = true
			SPEED = SPEED*1.1
	
	if global_position.distance_to(target.global_position) < 500 and attack_timer <= 0.0:
		choose_attack()
		attack_timer = 100
	else:
		attack_timer -= delta
		
	move_and_slide()

# Spawns enemies around the boss
func attack_1():
	var prev_speed = SPEED
	SPEED = 0
	# First wave with 5 enemies at 150 radius and if less than quarter hp 8 enemies
	var n_enemies = 5
	var radius = 150
	if enraged:
		n_enemies = 8
	if playback:
		playback.travel("attack")
	var rand_enemy = [[RED_SLIME, RED_EFFECT], [BLUE_SLIME, BLUE_EFFECT]].pick_random()
	spawn_wave_around(rand_enemy[0], rand_enemy[1], n_enemies, radius)
	
	# await for 2 seconds
	await get_tree().create_timer(2).timeout
	
	# Second wave with 7 enemies at 400 radius and if less than quarter hp 10 enemies
	n_enemies = 7
	radius = 420
	if enraged:
		n_enemies = 10
	if playback:
		playback.travel("attack")
	rand_enemy = [[RED_SLIME, RED_EFFECT], [BLUE_SLIME, BLUE_EFFECT]].pick_random()
	spawn_wave_around(rand_enemy[0], rand_enemy[1], n_enemies, radius)
	
	# await for 5 seconds
	await get_tree().create_timer(5).timeout
	SPEED = prev_speed
	attack_timer = 5

# Throws projectiles 3 times
func attack_2():
	var prev_speed = SPEED
	SPEED = 0

	for i in range(3):
		if playback:
			playback.travel("attack")
		var eff = WARNING_EFFECT.instantiate()
		eff.modulate = Color("623aff")
		eff.global_position.y = -70
		add_child(eff)
		
		var timer = Timer.new()
		add_child(timer)
		timer.wait_time = 1
		timer.one_shot = true
		
		var cal = Callable(self, "spawn_projectiles_around")
		var n_projectiles = 10
		if enraged:
			n_projectiles = 15
		if i == 1:
			n_projectiles += 4
		
		cal = cal.bindv([PROJECTILE, n_projectiles, eff, timer])
		timer.connect("timeout", cal)
		timer.start()
		
		await get_tree().create_timer(1).timeout
		
	# await for 2 seconds
	await get_tree().create_timer(2).timeout
	SPEED = prev_speed
	attack_timer = 5

# Increases Speed for 3 seconds and throws projectiles to the player afterwards standing still
func attack_3():
	var prev_speed = SPEED
	SPEED *= 1.5
	if enraged:
		SPEED *= 2
	await get_tree().create_timer(3).timeout
	
	SPEED = 0
	if playback:
		playback.travel("attack")
	var eff = WARNING_EFFECT.instantiate()
	eff.modulate = Color("ff0000")
	eff.global_position.y = -70
	add_child(eff)
	
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 2
	timer.one_shot = true
	
	var cal = Callable(self, "_throw_projectile_to_player")
	var n_projectiles = 12
	if enraged:
		n_projectiles = 16
		
	cal = cal.bindv([PROJECTILE, n_projectiles, eff, timer])
	timer.connect("timeout", cal)
	timer.start()
	
	# await for 5 seconds
	await get_tree().create_timer(5).timeout
	SPEED = prev_speed
	attack_timer = 5

func _throw_projectile_to_player(projectile, n_projectiles, effect, timer):
	effect.queue_free()
	timer.queue_free()
	throw_projectiles_to_player(projectile, n_projectiles)

func throw_projectiles_to_player(projectile, n_projectiles):
	for i in range(n_projectiles):
		var att = projectile.instantiate()
		att.speed = att.speed + i*8
		add_child(att)
		
		var att_direction = self.global_position.direction_to(target.global_position) 
		var att_rotation = att_direction.angle()
		
		att.rotation = att_rotation
		
		await get_tree().create_timer(0.2).timeout

func spawn_wave_around(enemy, effect, n_enemies, radius):
	for i in range(n_enemies):
		var angle = i * (2 * PI / n_enemies)
		var pos = Vector2(cos(angle), sin(angle)) * radius
		var eff = effect.instantiate()
		eff.global_position = pos
		add_child(eff)
		var timer = Timer.new()
		add_child(timer)
		timer.wait_time = 2
		timer.one_shot = true
		var cal = Callable(self, "_spawn_enemy")
		cal = cal.bindv([enemy, pos, eff, timer])
		timer.connect("timeout", cal)
		timer.start()

func spawn_projectiles_around(projectile, n_projectiles, effect, timer):
	effect.queue_free()
	timer.queue_free()
	for i in range(n_projectiles):
		var angle = i * (2 * PI / n_projectiles)
		var att = projectile.instantiate()
		add_child(att) 
		
		att.global_position = self.global_position
		att.rotation = angle

func _spawn_enemy(enemy, pos, effect, timer):
	timer.queue_free()
	effect.queue_free()
	spawn_enemy(enemy, pos)

func spawn_enemy(enemy, pos):
	var enemy_instance = enemy.instantiate()
	enemy_instance.global_position = pos
	enemy_instance.SPEED = 50
	enemy_instance.hp_max = 10
	add_child(enemy_instance)

func choose_attack():
	var attack_number = randi() % 3
	match attack_number:
		0:
			attack_1()
		1:
			attack_2()
		2:
			attack_3()

func flip_sprite(direction_x):
	# Rotación del sprite según la dirección horizontal
	if direction_x < 0:
		sprite.flip_h = true  # Voltea el sprite hacia la izquierda
		hitbox_collision_shape.position.x = abs(hitbox_collision_shape.position.x) * -1
		hurtbox_collision_shape.position.x = abs(hurtbox_collision_shape.position.x) * -1
	elif direction_x > 0:
		hitbox_collision_shape.position.x = abs(hitbox_collision_shape.position.x)
		hurtbox_collision_shape.position.x = abs(hurtbox_collision_shape.position.x)
		sprite.flip_h = false   # Deja el sprite sin voltear hacia la derecha

func _on_hp_changed(new_hp):
	if playback:
		playback.travel("damage_taken")
	

func _on_power1_collision(obj, damage):
	pass

func _on_blue_freeze(obj, time):
	pass

func _on_hurtbox_area_entered(hitbox):
	if hitbox.is_in_group("Power"):
		pass
	
	if hitbox.is_in_group("Projectile"):
		receive_damage(hitbox.damage)
		hitbox.destroy()

func die():
	playback.travel("dead")
	SPEED = 0
	hitbox_collision_shape.set_deferred("disabled", true)
	hurtbox_collision_shape.set_deferred("disabled", true)
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1
	timer.one_shot = true
	timer.connect("timeout", _on_dead_animation_finished)
	timer.start()

func _on_dead_animation_finished():
	queue_free()
