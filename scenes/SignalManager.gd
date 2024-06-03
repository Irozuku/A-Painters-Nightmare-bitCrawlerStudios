extends Node

signal power_released(powers, paints)
signal power1_collision(obj)

func send_power(loaded_powers, loaded_paints):
	emit_signal("power_released", loaded_powers, loaded_paints)

func power1(obj):
	emit_signal("power1_collision", obj)
