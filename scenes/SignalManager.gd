extends Node

signal power_released(powers, paints)
signal power1_collision(obj, damage)
signal gain_life(hp)
signal blue_freeze(area, time)

func send_power(loaded_powers, loaded_paints):
	emit_signal("power_released", loaded_powers, loaded_paints)

func power1(obj, hitbox):
	emit_signal("power1_collision", obj, hitbox)

func lifesteal(hp):
	emit_signal("gain_life", hp)

func freeze(area, time):
	emit_signal("blue_freeze", area, time)
