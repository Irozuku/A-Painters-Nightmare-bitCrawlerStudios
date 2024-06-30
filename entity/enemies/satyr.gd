extends Enemy

func die():
	playback.travel("dead")
	SPEED = 0
	hitbox_collision_shape.set_deferred("disabled", true)
	hurtbox_collision_shape.set_deferred("disabled", true)
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = animation_player.current_animation_length
	timer.one_shot = true
	timer.connect("timeout", _on_dead_animation_finished)
	timer.start()

func _on_dead_animation_finished():
	queue_free()

func _on_hp_changed(new_hp):
	if playback:
		playback.travel("damage_taken")

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
