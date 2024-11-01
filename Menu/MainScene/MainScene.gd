extends Control

func _on_buttonExit_game_pressed() -> void:
	get_tree().quit()

func _on_button_play_pressed() -> void:
	SceneManager.change_scene("res://Menu/Menu/Menu.tscn")

func _on_button_config_pressed() -> void:
	SceneManager.change_scene("res://Menu/ConfigMenu/ConfigMenu.tscn")
