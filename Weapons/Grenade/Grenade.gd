extends RigidBody2D

var explosion_damage = 50
@onready var explosion_sound = $AudioStreamPlayer2D

func _ready():
	$Timer.start()

func _on_timer_timeout():
	explode()

func explode():
	var explosion_area = $Area2D
	var bodies = explosion_area.get_overlapping_bodies()
	for body in bodies:
		if body.has_method("take_damage") and body != self:
			print("Dealing " + str(explosion_damage) + " damage to " + body.name)
			body.take_damage(explosion_damage)
	hide()
	explosion_sound.play()
	await explosion_sound.finished
	queue_free()

func get_damage():
	return explosion_damage
