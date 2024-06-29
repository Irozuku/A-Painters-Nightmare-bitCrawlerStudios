extends AudioStreamPlayer2D

const bgm_music = preload("res://music/main_menu/11 - Sergio V. Quintero - Sorrows Embrace (Loop).mp3")

func _play_music(music: AudioStream, volume):
	if stream == music:
		return
	stream = music
	volume_db = volume
	play()
	
func play_bgm_music(volume = volume_db):
	_play_music(bgm_music, volume)
	
