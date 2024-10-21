extends Node
class_name TurnManager

signal turn_started(player_name: String)
signal turn_ended
signal game_ended(winner_name: String)

var players: Array[CharacterBody2D] = []
var current_player_index: int = 0

@onready var turn_timer: Timer = $TurnTimer
@onready var grace_period_timer: Timer = $GracePeriodTimer
@onready var turn_transition_timer: Timer = $TurnTransitionTimer

func initialize(player_list: Array[CharacterBody2D]):
	players = player_list
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
		emit_signal("game_ended", players[0].name)

func check_next_player():
	while current_player_index < players.size() and players[current_player_index].is_dead:
		current_player_index = (current_player_index + 1) % players.size()
	start_turn()

func _on_turn_timer_timeout():
	end_turn()

func _on_grace_period_timer_timeout():
	if current_player_index < players.size():
		print("Periodo de gracia finalizado. Turno de " + players[current_player_index].name)
		turn_timer.start()
		set_players_turn_controls(true)
		emit_signal("turn_started", players[current_player_index].name)
	else:
		end_turn()

func _on_turn_transition_timer_timeout():
	print("Periodo de gracia antes del turno de " + players[current_player_index].name)
	grace_period_timer.start()

func get_current_player():
	return players[current_player_index]

func get_turn_time_remaining():
	return turn_timer.time_left if not turn_timer.is_stopped() else turn_timer.wait_time
