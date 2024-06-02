extends Node

signal power_released(powers, paints)

func send_power(loaded_powers, loaded_paints):
	emit_signal("power_released", loaded_powers, loaded_paints)
