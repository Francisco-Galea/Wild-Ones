extends RigidBody2D

var velocity: Vector2 = Vector2.ZERO

func _ready():
	linear_velocity = velocity

func _physics_process(delta):
	if position.y > 1000:  
		queue_free()

