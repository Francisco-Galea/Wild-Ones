extends RigidBody2D

var velocity: Vector2 = Vector2.ZERO

func _ready():
	# Establece la velocidad inicial del proyectil
	linear_velocity = velocity

func _physics_process(delta):
	# Si el proyectil cae fuera del área visible, se elimina
	if position.y > 1000:  # Ajusta según sea necesario
		queue_free()

func _on_body_entered(body):
	# Verifica si el proyectil colisiona con un objeto en los grupos 'terrain' o 'player'
	if body.is_in_group("terrain") or body.is_in_group("player"):
		queue_free()  # Elimina el proyectil al colisionar
