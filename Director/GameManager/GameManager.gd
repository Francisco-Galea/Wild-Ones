extends Node2D

var player_scene: PackedScene = preload("res://Player/Player.tscn")
var world_scene: PackedScene = preload("res://World/World.tscn")

var player_count: int = 2

func _ready():
	_create_world()
	_create_players()

func set_player_count(count: int):
	player_count = count

func _create_players():
	for i in range(player_count):
		var player_instance = player_scene.instantiate()
		player_instance.name = "Player" + str(i + 1)
		player_instance.position = Vector2(100 * i + 100, 200)
		add_child(player_instance)

func _create_world():
	var world_instance = world_scene.instantiate()
	add_child(world_instance)
