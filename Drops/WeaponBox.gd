extends Area2D

signal weapon_collected(weapon_strategy)

var fall_speed: float = 100.0
var is_on_ground: bool = false
var weapons = [
	preload("res://Weapons/GasGrenade/GasGrenadeStrategy.gd"),
	preload("res://Weapons/TripMine/TripMineStrategy.gd")
]

func _physics_process(delta):
	if not is_on_ground: 
		position.y += fall_speed * delta

func _on_body_entered(body):
	if body.is_in_group("Players"):
		var random_weapon = weapons[randi() % weapons.size()].new()
		var available_weapons = body.get_available_weapons()  
		available_weapons.erase(GrenadeStrategy)
		if available_weapons.size() > 0:
			var random_ammo_weapon = available_weapons[randi() % available_weapons.size()]  
			body.add_ammo_to_weapon(random_ammo_weapon, 3)
		queue_free()
	if not is_on_ground:  
		is_on_ground = true  
		position.y = position.y
