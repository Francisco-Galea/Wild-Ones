extends Node2D

var weapon_box_scene = preload("res://Drops/WeaponBox.tscn")
var drop_points: Array[Node] = []
var drop_timer: Timer

func _ready():
	for child in get_children():
		if child is Marker2D:
			drop_points.append(child)
	
	drop_timer = Timer.new()
	add_child(drop_timer)
	drop_timer.connect("timeout", Callable(self, "_on_drop_timer_timeout"))
	drop_timer.set_wait_time(5)  #Despues cambiar a 20, en 5 está para probar
	drop_timer.set_one_shot(false)
	drop_timer.start()

func _on_drop_timer_timeout():
	spawn_weapon_box()

func spawn_weapon_box():
	if drop_points.is_empty():
		return
	
	var random_point = drop_points[randi() % drop_points.size()]
	var weapon_box = weapon_box_scene.instantiate()
	weapon_box.position = random_point.position
	weapon_box.connect("weapon_collected", Callable(self, "_on_weapon_collected"))
	add_child(weapon_box)

func _on_weapon_collected(weapon_strategy):
	pass
