extends WeaponStrategy
class_name TripMineStrategy

var trip_mine_scene: PackedScene = preload("res://Weapons/TripMine/TripMine.tscn")

func shoot(start_position: Vector2, direction: Vector2) -> Node2D:
	var tripMine = trip_mine_scene.instantiate()
	tripMine.position = start_position
	tripMine.linear_velocity = direction * get_projectile_speed()
	tripMine.set_damage(get_damage())
	return tripMine

func get_damage() -> int:
	return 50

func get_projectile_speed() -> float:
	return 800 

func get_weapon_description() -> String:
	return "Mina trampa"
