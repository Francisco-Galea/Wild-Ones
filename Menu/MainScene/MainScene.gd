extends Control

var menu_scene: PackedScene = preload("res://Menu/Menu/Menu.tscn")

func _on_buttonExit_game_pressed():
	get_tree().quit()

func _on_button_play_pressed():
	var instance = menu_scene.instantiate()
	get_tree().root.add_child(instance)
	queue_free()  
