extends Enemy

@onready var damage_taken_sprite = $DamageTakenSprite
@onready var dead_sprite = $DeadSprite

func die():
	sprite.hide()
	damage_taken_sprite.hide()
	dead_sprite.show()
	playback.travel("dead")
	SPEED = 0
	hitbox_collision_shape.set_deferred("disabled", true)
	hurtbox_collision_shape.set_deferred("disabled", true)
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 0.677
	timer.one_shot = true
	timer.connect("timeout", _on_dead_animation_finished)
	timer.start()

func _on_dead_animation_finished():
	queue_free()

func _on_hp_changed(new_hp):
	if playback:
		sprite.hide()
		damage_taken_sprite.show()
		playback.travel("damage_taken")
		var timer = Timer.new()
		add_child(timer)
		timer.wait_time = 0.327
		timer.one_shot = true
		timer.connect("timeout", _on_damage_taken_animation_end)
		timer.start()

func _on_damage_taken_animation_end():
	if dead_sprite.visible == false:
		damage_taken_sprite.hide()
		sprite.show()

func flip_sprite(direction_x):
	# Rotación del sprite según la dirección horizontal
	if direction_x < 0:
		sprite.flip_h = true
		damage_taken_sprite.flip_h = true
		dead_sprite.flip_h = true
		hitbox_collision_shape.position.x = abs(hitbox_collision_shape.position.x) * -1
		hurtbox_collision_shape.position.x = abs(hurtbox_collision_shape.position.x) * -1
	elif direction_x > 0:
		hitbox_collision_shape.position.x = abs(hitbox_collision_shape.position.x)
		hurtbox_collision_shape.position.x = abs(hurtbox_collision_shape.position.x)
		sprite.flip_h = false
		damage_taken_sprite.flip_h = false
		dead_sprite.flip_h = false

func freeze(time):
	print(name + ": Me congelo")
	self.frozen = true
	self.modulate = Color("0005ff")
	await get_tree().create_timer(time).timeout
	self.modulate = Color("ffffff")
	self.frozen = false

func _on_power1_collision(obj, hitbox):
	# Emitir la señal de daño (o manejar el daño directamente)
	if hurtbox == obj:
		print("He sido colisionado")
		if 1 in hitbox.colors:
			self.freeze(hitbox.freeze_time)
			if 2 in hitbox.colors:
				# Lifesteal
				SignalManager.lifesteal(int(hitbox.damage*Global.HEALING_BONUS))
			# Red
			receive_damage(hitbox.damage)

func _on_hurtbox_area_entered(hitbox):
	if hitbox.is_in_group("Power"):
		if 1 in hitbox.colors:
			self.freeze(hitbox.freeze_time)
			if 2 in hitbox.colors:
				# Lifesteal
				SignalManager.lifesteal(int(hitbox.damage*Global.HEALING_BONUS))
			if hitbox.is_in_group("Projectile"):
				print(hitbox.colors, hitbox.damage)
				receive_damage(hitbox.damage, true)
			else:
				print(hitbox.colors, hitbox.damage)
				receive_damage(hitbox.damage)
	if hitbox.is_in_group("Projectile"):
		hitbox.destroy()
