extends Control

func _ready():
	$Button2Players.connect("pressed", Callable(self, "_on_Button2Players_pressed"))
	$Button3Players.connect("pressed", Callable(self, "_on_Button3Players_pressed"))

func _start_game(player_count: int):
	queue_free() 
	var game_manager = preload("res://Director/GameManager/GameManager.tscn").instantiate()
	game_manager.set_player_count(player_count)
	get_tree().root.add_child(game_manager)

func _on_Button2Players_pressed():
	_start_game(2)

func _on_Button3Players_pressed():
	_start_game(3)
