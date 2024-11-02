extends Node2D
class_name GameManager

@export var player_scene: PackedScene = preload("res://Player/Player.tscn")
@export var world_scene: PackedScene = preload("res://World/World.tscn")
@export var drop_manager_scene: PackedScene = preload("res://Director/DropManager/DropManager.tscn")
@export var game_hud_scene: PackedScene = preload("res://HUD/GameHUD/GameHUD.tscn")
@export var turn_manager_scene: PackedScene = preload("res://Director/TurnManager/TurnManager.tscn")

var player_count: int
var players: Array[CharacterBody2D] = []
var world_instance: Node
var spawn_manager: SpawnManager
var drop_manager: Node2D  
var game_hud: GameHud
var turn_manager: TurnManager

func _ready():
	create_world()
	create_players()
	setup_turn_manager()
	setup_drop_manager()
	setup_game_hud()

func setup_game_hud():
	game_hud = game_hud_scene.instantiate()
	add_child(game_hud)
	update_hud()

func setup_drop_manager():
	drop_manager = drop_manager_scene.instantiate()
	add_child(drop_manager)

func setup_turn_manager():
	turn_manager = turn_manager_scene.instantiate()
	add_child(turn_manager)
	turn_manager.initialize(players)
	turn_manager.connect("turn_started", _on_turn_started)
	turn_manager.connect("turn_ended", _on_turn_ended)
	turn_manager.connect("game_ended", _on_game_ended)

func set_player_count(count: int):
	player_count = count

func create_players():
	spawn_manager.reset_available_spawn_points()
	players.clear()
	for i in range(player_count):
		var player_instance = player_scene.instantiate()
		player_instance.name = "Player" + str(i + 1)  
		player_instance.position = spawn_manager.get_random_spawn_point()
		player_instance.connect("player_died", _on_player_died) 
		add_child(player_instance)
		players.append(player_instance)

func create_world():
	world_instance = world_scene.instantiate()
	add_child(world_instance)
	spawn_manager = world_instance.get_node("SpawnPoints") as SpawnManager

func _process(delta: float):
	update_hud()

func update_hud():
	var current_player = turn_manager.get_current_player()
	if current_player:
		game_hud.update_hud(current_player.name, turn_manager.get_turn_time_remaining(), current_player.get_current_weapon())

func _on_turn_started(player: CharacterBody2D):
	print("Turn started for " + player.name)
	player.start_turn()

func _on_turn_ended(player: CharacterBody2D):
	print("Turn ended for " + player.name)
	player.end_turn()

func _on_game_ended(winner: CharacterBody2D):
	if winner:
		print("Game ended. Winner: " + winner.name)
		game_hud.show_winner(winner.name)
	else:
		print("Game ended. No winner.")
		game_hud.show_winner("Ninguno")

func _on_player_died(dead_player: CharacterBody2D):
	players.erase(dead_player)
	turn_manager.player_died(dead_player)


