extends RigidBody2D

var damage_rasengan

func _ready():
	add_to_group("projectiles")

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage_rasengan)
	queue_free()

func set_damage(damage: int):
	damage_rasengan = damage

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
