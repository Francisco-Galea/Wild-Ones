extends RigidBody2D

var velocity: Vector2 = Vector2.ZERO

func _ready():
	linear_velocity = velocity

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
