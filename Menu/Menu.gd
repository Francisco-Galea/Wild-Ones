extends Control

func _ready():
	assert($Button2Players, "Button2Players not found!")
	assert($Button3Players, "Button3Players not found!")

	print("Button2Players: ", $Button2Players)
	print("Button3Players: ", $Button3Players)
	
	$Button2Players.connect("pressed", Callable(self, "_on_Button2Players_pressed"))
	$Button3Players.connect("pressed", Callable(self, "_on_Button3Players_pressed"))



func _start_game(player_count: int):
	var game_manager = preload("res://GameManager/GameManager.tscn").instantiate()
	game_manager.set_player_count(player_count)
	get_tree().root.add_child(game_manager)
	queue_free()  # Elimina la escena del menú





func _on_Button2Players_pressed():
	print("Button 2 Players Pressed")
	_start_game(2)


func _on_Button3Players_pressed():
	print("Button 3 Players Pressed")
	_start_game(3)
