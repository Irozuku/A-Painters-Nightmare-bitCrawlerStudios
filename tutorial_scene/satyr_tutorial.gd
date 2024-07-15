extends "res://entity/enemies/satyr.gd"

const DISTANCE_TUTORIAL = 270
var startPosition: Vector2
var targetPosition: Vector2
var movingRight = true
var dir = 1
var prev_speed

func _ready():
	super()
	prev_speed = SPEED
	target = get_node("/root/Tutorial/Player")
	startPosition = position
	targetPosition = startPosition + Vector2(DISTANCE_TUTORIAL, 0)

func _physics_process(delta):
	if frozen:
		return
	if movingRight:
		position.x += SPEED * delta
		if position.x >= targetPosition.x:
			position.x = targetPosition.x
			movingRight = false
			dir = -1
	else:
		position.x -= SPEED * delta
		if position.x <= startPosition.x:
			position.x = startPosition.x
			movingRight = true
			dir = 1
	
	flip_sprite(dir)

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
	SPEED = prev_speed
	hitbox_collision_shape.set_deferred("disabled", false)
	hurtbox_collision_shape.set_deferred("disabled", false)
	self.show()
	self.hp = hp_max
