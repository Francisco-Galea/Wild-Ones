extends RigidBody2D

var velocidad: float = 600
var _gravity: float

func _ready():
	_gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	apply_impulse(Vector2.ZERO, Vector2(velocidad, -velocidad))  # Aplica una fuerza inicial al proyectil

func _physics_process(delta):
	if position.y > 1000:  # Por ejemplo, si cae demasiado abajo, se elimina
		queue_free()
