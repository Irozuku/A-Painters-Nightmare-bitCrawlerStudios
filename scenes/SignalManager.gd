extends Node

signal power_released(powers, paints)
signal power1_collision()

func send_power(loaded_powers, loaded_paints):
	emit_signal("power_released", loaded_powers, loaded_paints)

func power1():
	emit_signal("power1_collision")
