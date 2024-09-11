extends Node

var chill_music = [
	preload("res://Audio/chill/chill1.WAV"),
	preload("res://Audio/chill/chill2.WAV"),
	preload("res://Audio/chill/chill3.WAV")
]

var hyped_music = [
	preload("res://Audio/hyped/hyped1.WAV"),
	preload("res://Audio/hyped/hyped2.WAV"),
	preload("res://Audio/hyped/hyped3.WAV")
]

var current_mode = "chill"
var music_player: AudioStreamPlayer

func _ready():
	music_player = $AudioStreamPlayer

# Rastgele bir müzik çalar
func play_random_music():
	var music_to_play: AudioStream
	if current_mode == "chill":
		music_to_play = chill_music[randi() % chill_music.size()]
	elif current_mode == "hyped":
		music_to_play = hyped_music[randi() % hyped_music.size()]
	if music_player != null:
		music_player.stream = music_to_play
		music_player.play()

# Müzik modunu değiştirir ve yeni bir müzik çalar
func change_music_mode(new_mode: String):
	current_mode = new_mode

#Oyun başladığında çağırılacak fonksiyon
func start_music():
	play_random_music()

func stop_music():
	music_player.stop()
