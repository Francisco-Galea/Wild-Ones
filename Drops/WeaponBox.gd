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
		var available_weapons = get_available_weapons(body)
		if available_weapons.size() > 0:
			var random_weapon = available_weapons[randi() % available_weapons.size()].new()
			body.collect_weapon(random_weapon)
		queue_free()
	if not is_on_ground:
		is_on_ground = true
		position.y = position.y

func get_available_weapons(player) -> Array:
	var player_weapons = player.weapons
	var available_weapons = []
	for weapon in weapons:
		var is_new = true
		for player_weapon in player_weapons:
			if player_weapon.get_script() == weapon:
				is_new = false
				break
		if is_new:
			available_weapons.append(weapon) 
	return available_weapons
