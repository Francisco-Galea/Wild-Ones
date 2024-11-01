extends Node

signal fullscreen_changed(is_fullscreen: bool)
signal volume_changed(is_muted: bool)

var is_fullscreen: bool = false
var is_muted: bool = false

const CONFIG_FILE_PATH = "user://settings.cfg"

func _ready() -> void:
	load_settings()

func toggle_fullscreen() -> void:
	is_fullscreen = not is_fullscreen
	if is_fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	emit_signal("fullscreen_changed", is_fullscreen)
	save_settings()

func toggle_mute() -> void:
	is_muted = not is_muted
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), is_muted)
	emit_signal("volume_changed", is_muted)
	save_settings()

func save_settings() -> void:
	var config = ConfigFile.new()
	config.set_value("video", "fullscreen", is_fullscreen)
	config.set_value("audio", "muted", is_muted)
	var error = config.save(CONFIG_FILE_PATH)
	if error != OK:
		print("Error saving settings: ", error)

func load_settings() -> void:
	var config = ConfigFile.new()
	var error = config.load(CONFIG_FILE_PATH)
	if error == OK:
		is_fullscreen = config.get_value("video", "fullscreen", false)
		is_muted = config.get_value("audio", "muted", false)
		
		# Aplicar configuraciones cargadas
		if is_fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), is_muted)
		
		# Emitir señales para actualizar la UI
		emit_signal("fullscreen_changed", is_fullscreen)
		emit_signal("volume_changed", is_muted)
	else:
		print("No settings file found or error loading settings. Using defaults.")
