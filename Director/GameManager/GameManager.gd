extends Node2D

# Importante: El periodo de gracia cambiarlo a 10 segundos
# Importante: El tiempo de turno cambiarlo a 20
var player_scene: PackedScene = preload("res://Player/Player.tscn")
var world_scene: PackedScene = preload("res://World/World.tscn")
var player_count
var players: Array = []
var current_player_index: int = 0
var world_instance: Node
var spawn_manager: SpawnManager
@onready var turn_timer: Timer = $TurnTimer
@onready var grace_period_timer: Timer = $GracePeriodTimer
var drop_manager_scene: PackedScene = preload("res://Director/DropManager/DropManager.tscn")  
var drop_manager: Node2D  
var is_paused: bool = false

func _ready():
	create_world()
	create_players()
	initialize_turn_system()
	drop_manager = drop_manager_scene.instantiate()
	add_child(drop_manager)

func set_player_count(count: int):
	player_count = count

func create_players():
	spawn_manager.reset_available_spawn_points()
	for i in range(player_count):
		var player_instance = player_scene.instantiate()
		player_instance.name = "Player" + str(i + 1)
		player_instance.position = spawn_manager.get_random_spawn_point()
		add_child(player_instance)
		players.append(player_instance)

func create_world():
	var world_instance = world_scene.instantiate()
	add_child(world_instance)
	spawn_manager = world_instance.get_node("SpawnPoints") as SpawnManager

func initialize_turn_system():
	start_turn()

func start_turn():
	print("Periodo de gracia antes del turno de " + players[current_player_index].name)
	grace_period_timer.start()  
	set_players_turn_controls(false)  

func set_players_turn_controls(enable: bool):
	for i in range(players.size()):
		players[i].set_turn(enable and i == current_player_index)

func end_turn():
	turn_timer.stop() 
	players[current_player_index].set_turn(false)  
	current_player_index = (current_player_index + 1) % players.size() 
	start_turn()

func _on_turn_timer_timeout():
	end_turn()

func _on_grace_period_timer_timeout():
	print("Periodo de gracia finalizado. Turno de " + players[current_player_index].name)
	turn_timer.start()
	set_players_turn_controls(true) 

func player_died(dead_player):
	players.erase(dead_player)
	if dead_player == players[current_player_index]:
		end_turn()
