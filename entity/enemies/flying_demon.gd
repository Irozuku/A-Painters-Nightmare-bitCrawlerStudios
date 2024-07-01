extends Enemy

func flip_sprite(direction_x):
	# Rotación del sprite según la dirección horizontal
	if direction_x < 0:
		sprite.flip_h = false  # Voltea el sprite hacia la izquierda
		hitbox_collision_shape.position.x = abs(hitbox_collision_shape.position.x) * -1
		hurtbox_collision_shape.position.x = abs(hurtbox_collision_shape.position.x) * -1
	elif direction_x > 0:
		hitbox_collision_shape.position.x = abs(hitbox_collision_shape.position.x)
		hurtbox_collision_shape.position.x = abs(hurtbox_collision_shape.position.x)
		sprite.flip_h = true   # Deja el sprite sin voltear hacia la derecha
