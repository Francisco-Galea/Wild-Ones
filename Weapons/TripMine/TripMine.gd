extends RigidBody2D

var explosion_damage: int
@onready var activation_area: Area2D = $ActivationArea
@onready var explosion_area: Area2D = $ExplosionArea
@onready var explosion_sound = $ExplosionSound
@onready var explosion_particles = $ExplosionArea/GPUParticles2D
@onready var trip_mine_sprite = $Sprite2D

func _on_activation_area_body_entered(body):
	if body.is_in_group("Players"):
		explode()
		_on_delay_time_timeout()

func explode():
	explosion_sound.play()
	var bodies = explosion_area.get_overlapping_bodies()
	for body in bodies:
		if body.has_method("take_damage") and body != self:
			body.take_damage(explosion_damage)
	trip_mine_sprite.hide()
	await explosion_sound.finished
	queue_free()

func set_damage(damage: int):
	explosion_damage = damage

func _on_delay_time_timeout():
	explosion_particles.emitting = true
