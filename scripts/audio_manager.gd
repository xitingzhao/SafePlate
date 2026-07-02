extends Node

var bgm_player: AudioStreamPlayer
func _ready() -> void:
	bgm_player = AudioStreamPlayer.new()
	bgm_player.name = "BGMPlayer"
	add_child(bgm_player)
	bgm_player.stream = preload("res://assets/sound/bgm.mp3")
	bgm_player.bus = "Music"
	bgm_player.play()

func set_music_volume(linear_value: float) -> void:
	var db = linear_to_db(clampf(linear_value, 0.0001, 1.0))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), db)

func get_music_volume() -> float:
	var db = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	return db_to_linear(db)
