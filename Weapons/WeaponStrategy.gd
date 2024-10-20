extends Node
class_name WeaponStrategy

var ammo: int = 0

func shoot(start_position: Vector2, direction: Vector2) -> Node2D:
	return null

func get_damage() -> int:
	return 0

func get_projectile_speed() -> float:
	return 0.0

func get_weapon_description() -> String:
	return "Generic weapon"

func has_ammo() -> bool:
	return ammo > 0
