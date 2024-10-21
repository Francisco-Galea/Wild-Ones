extends WeaponStrategy
class_name LightsaberStrategy

var lightsaber_scene: PackedScene = preload("res://Weapons/Lightsaber/Lightsaber.tscn")

func shoot(start_position: Vector2, direction: Vector2) -> Node2D:
	var saber = lightsaber_scene.instantiate()
	saber.position = start_position
	saber.set_damage(get_damage())
	return saber

func get_damage() -> int:
	return 35

func get_projectile_speed() -> float:
	return 0.0  

func get_weapon_description() -> String:
	return "Sable laser"
