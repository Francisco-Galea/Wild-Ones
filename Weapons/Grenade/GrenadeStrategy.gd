extends WeaponStrategy
class_name GrenadeStrategy

var grenade_scene: PackedScene = preload("res://Weapons/Grenade/Grenade.tscn")

func shoot(start_position: Vector2, direction: Vector2) -> Node2D:
	var projectile = grenade_scene.instantiate()
	projectile.position = start_position
	projectile.linear_velocity = direction * get_projectile_speed()
	projectile.set_damage(get_damage())
	return projectile

func get_damage() -> int:
	return 100
# El daño al final será de 20

func get_projectile_speed() -> float:
	return 600.0

func get_weapon_description() -> String:
	return "Tiro lata A"
