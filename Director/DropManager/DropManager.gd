extends Node2D

@export var weapon_box_scene: PackedScene = preload("res://Drops/WeaponBox.tscn")
@export var drop_interval: float = 10.0  
var drop_points: Array[Marker2D] = []
var drop_timer: Timer

func _ready():
	initialize_drop_points()
	initialize_drop_timer()

func initialize_drop_points():
	drop_points.clear()
	for child in get_children():
		if child is Marker2D:
			drop_points.append(child)

func initialize_drop_timer():
	drop_timer = Timer.new()
	drop_timer.set_wait_time(drop_interval)  
	drop_timer.set_one_shot(false)
	add_child(drop_timer)
	drop_timer.connect("timeout", Callable(self, "_on_drop_timer_timeout"))
	drop_timer.start()

func _on_drop_timer_timeout():
	spawn_weapon_box()

func spawn_weapon_box():
	if drop_points.is_empty():
		push_warning("No drop points available for spawning!")
		return
	var random_point = drop_points[randi() % drop_points.size()]
	var weapon_box = weapon_box_scene.instantiate()
	weapon_box.position = random_point.position
	weapon_box.connect("weapon_collected", Callable(self, "_on_weapon_collected"))
	add_child(weapon_box)

func _on_weapon_collected(weapon_strategy):
	pass 
