extends WeaponStrategy
class_name KamehaStrategy

var kameha_scene : PackedScene = preload("res://Weapons/Kameha/Kameha.tscn")

func shoot(start_position: Vector2, direction: Vector2) -> Node2D:
	var projectile = kameha_scene.instantiate()
	projectile.position = start_position
	projectile.linear_velocity = direction * get_projectile_speed()
	projectile.set_damage(get_damage())
	return projectile

func get_damage() -> int:
	return 40
#El daño final será de 35

func get_projectile_speed() -> float:
	return 500

func get_weapon_description() -> String:
	return "KAMEHAMEHAAA"
