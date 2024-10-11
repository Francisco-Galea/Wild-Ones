extends RigidBody2D

var damage 

func _ready():
	add_to_group("bullets")

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func get_damage():
	return damage
