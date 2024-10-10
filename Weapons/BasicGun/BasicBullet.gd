# Weapons/BasicGun/BasicBullet.gd
extends RigidBody2D

func _ready():
	add_to_group("bullets")

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage()  # Use the damage value from the strategy
	queue_free()
