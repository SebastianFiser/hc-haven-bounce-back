extends AudioStreamPlayer

const SAVE_PATH := "user://settings.cfg"


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	stream = preload("res://assets/audio/nigg2.mp3")
	bus = "Music"

	var volume: float = 0.8
	var cfg := ConfigFile.new()
	if cfg.load(SAVE_PATH) == OK:
		volume = cfg.get_value("audio", "music_volume", 0.8)
	set_music_volume(volume)
	play()


func set_music_volume(value: float) -> void:
	var idx: int = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(idx, linear_to_db(value))
	AudioServer.set_bus_mute(idx, value <= 0.001)


func save_music_volume(value: float) -> void:
	var cfg := ConfigFile.new()
	cfg.load(SAVE_PATH)
	cfg.set_value("audio", "music_volume", value)
	cfg.save(SAVE_PATH)
