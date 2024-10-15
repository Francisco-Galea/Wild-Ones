extends RigidBody2D

var explosion_damage: int
@onready var activation_area: Area2D = $ActivationArea
@onready var explosion_area: Area2D = $ExplosionArea
@onready var explosion_sound = $ExplosionSound

func _on_activation_area_body_entered(body):
	if body.is_in_group("Players"):
		explode()

func explode():
	var explosion_area = $ExplosionArea
	explosion_sound.play()
	var bodies = explosion_area.get_overlapping_bodies()
	for body in bodies:
		if body.has_method("take_damage") and body != self:
			body.take_damage(explosion_damage)
	hide()
	await explosion_sound.finished
	queue_free()

func set_damage(damage: int):
	explosion_damage = damage
