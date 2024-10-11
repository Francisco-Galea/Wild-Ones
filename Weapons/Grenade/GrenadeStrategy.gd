extends WeaponStrategy
class_name GrenadeStrategy

func shoot(start_position: Vector2, direction: Vector2) -> Node2D:
	var projectile = preload("res://Weapons/Grenade/Grenade.tscn").instantiate()
	projectile.position = start_position
	projectile.linear_velocity = direction * get_projectile_speed()
	projectile.explosion_damage = get_damage()
	return projectile

func get_damage() -> int:
	return 40

func get_projectile_speed() -> float:
	return 350.0

