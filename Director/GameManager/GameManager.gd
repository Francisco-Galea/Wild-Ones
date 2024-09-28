extends Node2D

var player_scene: PackedScene = preload("res://Player/Player.tscn")
var world_scene: PackedScene = preload("res://World/World.tscn")
var player_count
var players: Array = []
var current_player_index: int = 0
@onready var turn_timer: Timer = $TurnTimer
@onready var grace_period_timer: Timer = $GracePeriodTimer

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
		player_instance.position = Vector2(200 * i + 200, 200)
		add_child(player_instance)
		players.append(player_instance)

func create_world():
	var world_instance = world_scene.instantiate()
	add_child(world_instance)

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
	if players.size() == 1:
		end_game(players[0])
	elif players.size() == 0:
		end_game(null)
	else:
		if dead_player == players[current_player_index]:
			end_turn()

func end_game(winner):
	if winner:
		print("¡El juego ha terminado! El ganador es: " + winner.name)
	else:
		print("¡El juego ha terminado en empate!")

