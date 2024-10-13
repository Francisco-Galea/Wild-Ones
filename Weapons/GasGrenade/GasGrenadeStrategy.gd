extends WeaponStrategy
class_name GasGrenadeStrategy

var gas_grenade_scene: PackedScene = preload("res://Weapons/GasGrenade/GasGrenade.tscn")

func shoot(start_position: Vector2, direction: Vector2) -> Node2D:
	var grenade = gas_grenade_scene.instantiate()
	grenade.position = start_position
	grenade.linear_velocity = direction * get_projectile_speed()
	grenade.set_damage(get_damage())
	return grenade

func get_damage() -> int:
	return 3

func get_projectile_speed() -> float:
	return 600.0  
