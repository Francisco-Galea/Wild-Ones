# Weapons/WeaponStrategy.gd
extends Node
class_name WeaponStrategy

func shoot(start_position: Vector2, direction: Vector2) -> Node2D:
	return null

func get_damage() -> int:
	return 0

func get_projectile_speed() -> float:
	return 0.0


