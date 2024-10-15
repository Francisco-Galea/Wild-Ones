extends Control

func start_game(player_count: int):
	queue_free() 
	var game_manager = preload("res://Director/GameManager/GameManager.tscn").instantiate()
	game_manager.set_player_count(player_count)
	get_tree().root.add_child(game_manager)

func _on_Button2Players_pressed():
	start_game(2)

func _on_Button3Players_pressed():
	start_game(3)

func _on_button_4_players_pressed():
	start_game(4)

func _on_button_back_pressed():
	get_tree().change_scene_to_file("res://Menu/MainScene/MainScene.tscn")
	queue_free()


