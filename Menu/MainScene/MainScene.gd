extends Control

var menu_scene: PackedScene = preload("res://Menu/Menu/Menu.tscn")

func _on_buttonPlay_pressed():
	var instance = menu_scene.instantiate()
	get_tree().root.add_child(instance)
	queue_free()  

func _on_buttonExit_game_pressed():
	get_tree().quit()
