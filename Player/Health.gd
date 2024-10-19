extends Node

signal health_changed(new_health)
signal died

@export var max_health: int = 100
var current_health: int

func _ready():
	current_health = max_health

func take_damage(amount: int):
	current_health = max(0, current_health - amount)
	emit_signal("health_changed", current_health)
	if current_health == 0:
		emit_signal("died")

func get_health():
	return current_health
