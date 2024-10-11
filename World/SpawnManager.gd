extends Node2D
class_name SpawnManager

var spawn_points: Array[Node] = []
var available_spawn_points: Array[Node] = []

func _ready():
	for child in get_children():
		if child is Marker2D:
			spawn_points.append(child)
	reset_available_spawn_points()

func reset_available_spawn_points():
	available_spawn_points = spawn_points.duplicate()

func get_random_spawn_point() -> Vector2:
	if available_spawn_points.is_empty():
		push_warning("No available spawn points!")
		return Vector2.ZERO
	
	var random_index = randi() % available_spawn_points.size()
	var random_point = available_spawn_points[random_index]
	available_spawn_points.remove_at(random_index)
	
	return random_point.global_position

func are_spawn_points_available() -> bool:
	return not available_spawn_points.is_empty()
