extends Area2D

var cut_damage: int 
var attack_range: float = 30.0  

func _ready():
	pass

func attack():
	var bodies = get_overlapping_bodies() 
	for body in bodies:
		if body.has_method("take_damage"):
			body.take_damage(cut_damage)

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(cut_damage)

func set_damage(damage: int):
	cut_damage = damage
