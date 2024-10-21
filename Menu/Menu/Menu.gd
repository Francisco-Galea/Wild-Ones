extends Control

@onready var player_count_lineedit = $VBoxContainer/HBoxContainer/PlayerCount

func start_game(player_count: int):
	queue_free() 
	var game_manager = preload("res://Director/GameManager/GameManager.tscn").instantiate()
	game_manager.set_player_count(player_count)
	get_tree().root.add_child(game_manager)

func _on_button_back_pressed():
	get_tree().change_scene_to_file("res://Menu/MainScene/MainScene.tscn")
	queue_free()

func _on_button_next_pressed():
	var player_count = int(player_count_lineedit.text)
	if player_count < 2 or player_count > 4:
		print("El número de jugadores debe ser entre 2 y 4")
		return
	start_game(player_count)
	queue_free()

