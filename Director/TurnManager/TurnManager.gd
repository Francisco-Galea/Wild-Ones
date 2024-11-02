extends Node
class_name TurnManager

signal turn_started(player: CharacterBody2D)
signal turn_ended(player: CharacterBody2D)
signal game_ended(winner: CharacterBody2D)

var players: Array[CharacterBody2D] = []
var current_player_index: int = -1
var game_over: bool = false

@onready var turn_timer: Timer = $TurnTimer
@onready var grace_period_timer: Timer = $GracePeriodTimer
@onready var turn_transition_timer: Timer = $TurnTransitionTimer

func initialize(player_list: Array[CharacterBody2D]):
	players = player_list
	start_game()

func start_game():
	if players.size() <= 1:
		end_game()
	else:
		current_player_index = -1
		start_turn()

func start_turn():
	if game_over:
		return
	current_player_index = get_next_valid_player_index()
	if current_player_index == -1:
		end_game()
		return
	var current_player = players[current_player_index]
	print("Starting turn for " + current_player.name)
	turn_transition_timer.start()

func end_turn():
	if game_over:
		return
	stop_all_timers()
	var current_player = players[current_player_index]
	current_player.end_turn()
	print("Ending turn for " + current_player.name)
	emit_signal("turn_ended", current_player)
	start_turn()

func player_died(dead_player: CharacterBody2D):
	players.erase(dead_player)
	print(dead_player.name + " has been eliminated!")
	if players.size() <= 1:
		end_game()
	elif dead_player == get_current_player():
		end_turn()

func end_game():
	game_over = true
	stop_all_timers()
	if players.size() == 1:
		print("Game over! The winner is: " + players[0].name)
		emit_signal("game_ended", players[0])
	else:
		print("Game over! No winners.")
		emit_signal("game_ended", null)

func get_next_valid_player_index() -> int:
	var start_index = (current_player_index + 1) % players.size()
	for i in range(players.size()):
		var index = (start_index + i) % players.size()
		if not players[index].is_dead:
			return index
	return -1

func get_current_player() -> CharacterBody2D:
	if current_player_index >= 0 and current_player_index < players.size():
		return players[current_player_index]
	return null

func get_turn_time_remaining() -> float:
	return turn_timer.time_left

func stop_all_timers():
	turn_timer.stop()
	grace_period_timer.stop()
	turn_transition_timer.stop()

func _on_turn_timer_timeout():
	print("Turn time ended for " + get_current_player().name)
	end_turn()

func _on_grace_period_timer_timeout():
	var current_player = get_current_player()
	if current_player:
		print("Grace period ended. Starting turn for " + current_player.name)
		turn_timer.start()
		current_player.start_turn()
		emit_signal("turn_started", current_player)
	else:
		end_turn()

func _on_turn_transition_timer_timeout():
	var current_player = get_current_player()
	if current_player:
		print("Turn transition ended. Starting grace period for " + current_player.name)
		grace_period_timer.start()
	else:
		end_turn()
