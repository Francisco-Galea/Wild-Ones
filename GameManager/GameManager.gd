extends Node2D

var player_scene: PackedScene = preload("res://Player/Player.tscn")

var player_count: int = 2

func _ready():
	_create_players()

func set_player_count(count: int):
	player_count = count

func _create_players():
	for i in range(player_count):
		var player_instance = player_scene.instantiate()
		player_instance.name = "Player" + str(i + 1)
		# Ajusta la posición inicial de los jugadores aquí
		player_instance.position = Vector2(100 * i + 100, 200)  # Ejemplo de posicionamiento
		add_child(player_instance)
