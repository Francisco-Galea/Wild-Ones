extends Node2D

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

func _ready():
	create_world()
	create_players()
	initialize_turn_system()
	drop_manager = drop_manager_scene.instantiate()
	add_child(drop_manager)
	print("Game initialized")

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
	if players.size() <= 1:
		end_game()
		return
	print("Periodo de gracia antes del turno de " + players[current_player_index].name)
	grace_period_timer.start()  
	set_players_turn_controls(false)  

func set_players_turn_controls(enable: bool):
	for i in range(players.size()):
		players[i].set_turn(enable and i == current_player_index)

func end_turn():
	turn_timer.stop() 
	if current_player_index < players.size():
		players[current_player_index].set_turn(false)  
	current_player_index = (current_player_index + 1) % players.size() 
	start_turn()

func _on_turn_timer_timeout():
	end_turn()

func _on_grace_period_timer_timeout():
	if players.size() > current_player_index:
		print("Periodo de gracia finalizado. Turno de " + players[current_player_index].name)
		turn_timer.start()
		set_players_turn_controls(true) 
	else:
		end_turn()

func player_died(dead_player):
	players.erase(dead_player)
	print(dead_player.name + " ha sido eliminado!")
	if players.size() <= 1:
		end_game()
	else:
		if dead_player == players[current_player_index]:
			end_turn()
		else:
			current_player_index = min(current_player_index, players.size() - 1)

func end_game():
	if players.size() == 1:
		print("¡El juego ha terminado! El ganador es: " + players[0].name)

