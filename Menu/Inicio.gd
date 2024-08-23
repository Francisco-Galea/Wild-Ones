extends Node

func _ready():
	var menu_scene = preload("res://Menu/Menu.tscn").instantiate()
	add_child(menu_scene)
