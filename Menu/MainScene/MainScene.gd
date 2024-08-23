extends Control

var menu_scene: PackedScene = preload("res://Menu/Menu/Menu.tscn")

func _on_buttonPlay_pressed():
	# Instanciar y agregar la escena Menu cuando se presiona el botón Play
	var instance = menu_scene.instantiate()
	get_tree().root.add_child(instance)
	queue_free()  # Elimina la escena actual para dejar paso a Menu

func _on_buttonExit_game_pressed():
	# Lógica para salir del juego
	get_tree().quit()
