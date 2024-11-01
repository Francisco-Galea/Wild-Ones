extends Control

@onready var fullscreen_button: Button = $VBoxContainer/FullScreenButton
@onready var mute_button: Button = $VBoxContainer/MuteButton

func _ready() -> void:
	fullscreen_button.pressed.connect(_on_fullscreen_button_pressed)
	mute_button.pressed.connect(_on_mute_button_pressed)
	ConfigManager.fullscreen_changed.connect(_on_fullscreen_changed)
	ConfigManager.volume_changed.connect(_on_volume_changed)
	_on_fullscreen_changed(ConfigManager.is_fullscreen)
	_on_volume_changed(ConfigManager.is_muted)

func _on_fullscreen_button_pressed() -> void:
	ConfigManager.toggle_fullscreen()

func _on_mute_button_pressed() -> void:
	ConfigManager.toggle_mute()

func _on_save_button_pressed() -> void:
	ConfigManager.save_settings()

func _on_fullscreen_changed(is_fullscreen: bool) -> void:
	fullscreen_button.text = "Pantalla Completa: " + ("ON" if is_fullscreen else "OFF")

func _on_back_button_pressed():
	pass 

func _on_volume_changed(is_muted: bool) -> void:
	mute_button.text = "Silenciar: " + ("ON" if is_muted else "OFF")





