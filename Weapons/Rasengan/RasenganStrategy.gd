extends WeaponStrategy
class_name RasenganStrategy

var rasengan_scene : PackedScene = preload("res://Weapons/Rasengan/Rasengan.tscn")

func shoot(start_position: Vector2, direction: Vector2) -> Node2D:
	var projectile = rasengan_scene.instantiate()
	projectile.position = start_position
	projectile.linear_velocity = direction * get_projectile_speed()
	projectile.set_damage(get_damage())
	return projectile

func get_damage() -> int:
	return 100

func get_projectile_speed() -> float:
	return 800
