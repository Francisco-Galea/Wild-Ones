extends Node2D
class_name SpawnManager

var available_spawn_points: Array[Marker2D] = []

func _ready():
	initialize_spawn_points()

func initialize_spawn_points():
	available_spawn_points.clear()
	for child in get_children():
		if child is Marker2D:
			available_spawn_points.append(child)

func get_random_spawn_point() -> Vector2:
	if available_spawn_points.is_empty():
		return Vector2.ZERO
	var random_index = randi() % available_spawn_points.size()
	var spawn_point = available_spawn_points[random_index]
	available_spawn_points.remove_at(random_index)
	return spawn_point.position

func reset_available_spawn_points():
	initialize_spawn_points()

