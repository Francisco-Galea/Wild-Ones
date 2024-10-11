extends WeaponStrategy
class_name BasicGunStrategy

func shoot(start_position: Vector2, direction: Vector2) -> Node2D:
	var projectile = preload("res://Weapons/BasicGun/BasicBullet.tscn").instantiate()
	projectile.position = start_position
	projectile.linear_velocity = direction * get_projectile_speed()
	projectile.damage = get_damage()
	return projectile

func get_damage() -> int:
	return 20

func get_projectile_speed() -> float:
	return 10000


