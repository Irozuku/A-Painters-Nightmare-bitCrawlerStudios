extends "res://entity/enemies/blue_slime.gd"

func _ready():
	super()
	target = get_node("/root/Tutorial/Player")

func _physics_process(delta):
	if frozen:
		return
	var direction = global_position.direction_to(target.global_position)
	
	flip_sprite(direction.x)

func _on_dead_animation_finished():
	self.hide()
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1
	timer.one_shot = true
	var cal = Callable(self, "respawn")
	cal = cal.bindv([timer])
	timer.connect("timeout", cal)
	timer.start()

func respawn(timer):
	timer.queue_free()
	playback.travel("idle")
	dead_sprite.visible = false
	damage_taken_sprite.visible = false
	sprite.visible = true
	hitbox_collision_shape.set_deferred("disabled", false)
	hurtbox_collision_shape.set_deferred("disabled", false)
	self.show()
	self.hp = hp_max
