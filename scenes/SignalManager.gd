extends Node

signal power_released(powers, paints)
signal power1_collision(obj, damage)
signal gain_life(hp)
signal blue_freeze(area, time)
signal upgrade(up)
signal upgrade_taken()
signal upgrade_max_hp(value)
signal upgrade_speed(value)

func send_power(loaded_powers, loaded_paints):
	emit_signal("power_released", loaded_powers, loaded_paints)

func power1(obj, hitbox):
	emit_signal("power1_collision", obj, hitbox)

func lifesteal(hp):
	emit_signal("gain_life", hp)

func freeze(area, time):
	emit_signal("blue_freeze", area, time)

func send_upgrade(up):
	emit_signal("upgrade", up)

func send_upgrade_taken():
	emit_signal("upgrade_taken")

func send_upgrade_max_hp(value):
	emit_signal("upgrade_max_hp", value)
	
func send_upgrade_speed(value):
	emit_signal("upgrade_speed", value)
