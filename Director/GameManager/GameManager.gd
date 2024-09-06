extends Node2D

var player_scene: PackedScene = preload("res://Player/Player.tscn")
var world_scene: PackedScene = preload("res://World/World.tscn")
var player_count
var players: Array = []
var current_player_index: int = 0
var turn_timer: Timer

func _ready():
	create_world()
	create_players()
	initialize_turn_system()

func set_player_count(count: int):
	player_count = count

func create_players():
	for i in range(player_count):
		var player_instance = player_scene.instantiate()
		player_instance.name = "Player" + str(i + 1)
		player_instance.position = Vector2(100 * i + 100, 200)
		add_child(player_instance)
		players.append(player_instance)

func create_world():
	var world_instance = world_scene.instantiate()
	add_child(world_instance)

func initialize_turn_system():
	turn_timer = Timer.new()
	turn_timer.wait_time = 5  
	turn_timer.one_shot = true
	turn_timer.connect("timeout", Callable(self, "_on_turn_timeout"))
	add_child(turn_timer)
	start_turn()

func start_turn():
	turn_timer.start()
	for i in range(players.size()):
		players[i].set_turn(i == current_player_index)
	var current_player = players[current_player_index]
	print("Turno de " + current_player.name)

func end_turn():
	var current_player = players[current_player_index]
	current_player.set_turn(false)
	current_player_index = (current_player_index + 1) % players.size()
	start_turn()

func _on_turn_timeout():
	
	end_turn()
