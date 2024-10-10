# Weapons/Grenade.gd
extends RigidBody2D

var explosion_damage = 50

func _ready():
	$Timer.start()
	$Area2D/CollisionShape2D.disabled = true

func _on_timer_timeout():
	explode()

func explode():
	$Area2D/CollisionShape2D.disabled = false
	var bodies = $Area2D.get_overlapping_bodies()
	for body in bodies:
		if body.has_method("take_damage"):
			body.take_damage(explosion_damage)
	queue_free()
