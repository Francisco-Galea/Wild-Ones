extends Area2D

signal weapon_collected(weapon_strategy)

var fall_speed: float = 100.0
var is_on_ground: bool = false
var weapons = [
	preload("res://Weapons/Rasengan/RasenganStrategy.gd"),
	preload("res://Weapons/Grenade/GrenadeStrategy.gd")
]

func _physics_process(delta):
	if not is_on_ground: 
		position.y += fall_speed * delta

func _on_body_entered(body):
	if body.is_in_group("Players"):
		var random_weapon = weapons[randi() % weapons.size()].new()
		emit_signal("weapon_collected", random_weapon)
		body.collect_weapon(random_weapon)
		queue_free()
	if not is_on_ground:  
		is_on_ground = true  
		position.y = position.y
