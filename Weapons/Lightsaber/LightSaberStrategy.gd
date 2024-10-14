extends WeaponStrategy
class_name LightsaberStrategy

var lightsaber_scene: PackedScene = preload("res://Weapons/Lightsaber/Lightsaber.tscn")

func shoot(start_position: Vector2, direction: Vector2) -> Node2D:
	var lightsaber_instance = lightsaber_scene.instantiate()
	lightsaber_instance.position = start_position
	return lightsaber_instance

func get_damage() -> int:
	return 20  

func get_projectile_speed() -> float:
	return 0.0  
