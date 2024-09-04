extends Node2D

var player_scene: PackedScene = preload("res://Player/Player.tscn")
var world_scene: PackedScene = preload("res://World/World.tscn")
var player_count: int = 2
var players: Array = []
var current_player_index: int = 0
var turn_timer: Timer

func _ready():
	_create_world()
	_create_players()
	_initialize_turn_system()

func set_player_count(count: int):
	player_count = count

func _create_players():
	for i in range(player_count):
		var player_instance = player_scene.instantiate()
		player_instance.name = "Player" + str(i + 1)
		player_instance.position = Vector2(100 * i + 100, 200)
		add_child(player_instance)
		players.append(player_instance)

func _create_world():
	var world_instance = world_scene.instantiate()
	add_child(world_instance)

func _initialize_turn_system():
	# Crear el temporizador para los turnos
	turn_timer = Timer.new()
	turn_timer.wait_time = 5  # Duración máxima del turno en segundos
	turn_timer.one_shot = true
	turn_timer.connect("timeout", Callable(self, "_on_turn_timeout"))
	add_child(turn_timer)
	_start_turn()

func _start_turn():
	# Reiniciar el temporizador y habilitar los controles del jugador actual
	turn_timer.start()
	for i in range(players.size()):
		# Solo habilitar el turno para el jugador actual
		players[i].set_turn(i == current_player_index)
	
	var current_player = players[current_player_index]
	print("Turno de " + current_player.name)

func _end_turn():
	# Deshabilitar los controles del jugador actual
	var current_player = players[current_player_index]
	current_player.set_turn(false)

	# Cambiar al siguiente jugador
	current_player_index = (current_player_index + 1) % players.size()
	_start_turn()

func _on_turn_timeout():
	# Llamado cuando se acaba el tiempo del turno actual
	_end_turn()
