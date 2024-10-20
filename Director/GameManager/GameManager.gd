extends Node2D

@export var player_scene: PackedScene = preload("res://Player/Player.tscn")
@export var world_scene: PackedScene = preload("res://World/World.tscn")
@export var drop_manager_scene: PackedScene = preload("res://Director/DropManager/DropManager.tscn")
@export var game_hud_scene: PackedScene = preload("res://HUD/GameHUD/GameHUD.tscn")
@onready var turn_timer: Timer = $TurnTimer
@onready var grace_period_timer: Timer = $GracePeriodTimer
@onready var turn_transition_timer: Timer = $TurnTransitionTimer
var player_count: int
var players: Array[CharacterBody2D] = []
var current_player_index: int = 0
var world_instance: Node
var spawn_manager: SpawnManager
var drop_manager: Node2D  
var game_hud: GameHud

func _ready():
	create_world()
	create_players()
	initialize_turn_system()
	setup_drop_manager()
	setup_game_hud()

func setup_game_hud():
	game_hud = game_hud_scene.instantiate()
	add_child(game_hud)
	game_hud.update_hud(players[current_player_index].name, turn_timer.wait_time)

func setup_drop_manager():
	drop_manager = drop_manager_scene.instantiate()
	add_child(drop_manager)

func set_player_count(count: int):
	player_count = count

func create_players():
	spawn_manager.reset_available_spawn_points()
	players.clear()
	for i in range(player_count):
		var player_instance = player_scene.instantiate()
		player_instance.name = "Player" + str(i + 1)  
		player_instance.position = spawn_manager.get_random_spawn_point()
		add_child(player_instance)
		players.append(player_instance)

func create_world():
	world_instance = world_scene.instantiate()
	add_child(world_instance)
	spawn_manager = world_instance.get_node("SpawnPoints") as SpawnManager

func initialize_turn_system():
	start_turn()

func start_turn():
	if players.size() <= 1:
		end_game()
		return
	stop_all_timers()
	while current_player_index < players.size() and players[current_player_index].is_dead:
		current_player_index = (current_player_index + 1) % players.size()
	if current_player_index < players.size() and !players[current_player_index].is_dead:
		print("Iniciando transición antes del turno de " + players[current_player_index].name)
		turn_transition_timer.start() 
		set_players_turn_controls(false) 
	else:
		end_turn()

func stop_all_timers():
	if turn_timer.is_stopped() == false:
		turn_timer.stop()
	if grace_period_timer.is_stopped() == false:
		grace_period_timer.stop()
	if turn_transition_timer.is_stopped() == false:
		turn_transition_timer.stop()

func set_players_turn_controls(enable: bool):
	for player in players:
		player.set_turn(enable and player == players[current_player_index])

func end_turn():
	stop_all_timers()
	if current_player_index < players.size():
		players[current_player_index].set_turn(false)
	current_player_index = (current_player_index + 1) % players.size()
	turn_transition_timer.start()

func _on_turn_timer_timeout():
	end_turn()

func _on_grace_period_timer_timeout():
	if current_player_index < players.size():
		print("Periodo de gracia finalizado. Turno de " + players[current_player_index].name)
		turn_timer.start()
		set_players_turn_controls(true)
	else:
		end_turn()

func player_died(dead_player):
	dead_player.is_dead = true  
	print(dead_player.name + " ha sido eliminado!")
	players.erase(dead_player)
	
	if players.size() <= 1:
		end_game()
	else:
		check_next_player()

func end_game():
	if players.size() == 1:
		print("¡El juego ha terminado! El ganador es: " + players[0].name)

func check_next_player():
	while current_player_index < players.size() and players[current_player_index].is_dead:
		current_player_index = (current_player_index + 1) % players.size()
	start_turn()

func _process(delta: float):
	if turn_timer.is_stopped():
		return
	var time_remaining = turn_timer.time_left
	game_hud.update_hud(players[current_player_index].name, time_remaining)

func _on_turn_transition_timer_timeout():
	print("Periodo de gracia antes del turno de " + players[current_player_index].name)
	grace_period_timer.start()
	game_hud.update_hud(players[current_player_index].name, turn_timer.wait_time)

