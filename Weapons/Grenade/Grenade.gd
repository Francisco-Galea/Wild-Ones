extends RigidBody2D

var explosion_damage: int
@onready var explosion_sound = $explosion
@onready  var fire_in_the_hole = $throwGrenade

func _ready():
	$Timer.start()
	fire_in_the_hole.play()

func _on_timer_timeout():
	explode()

func explode():
	var explosion_area = $Area2D
	var bodies = explosion_area.get_overlapping_bodies()
	for body in bodies:
		if body.has_method("take_damage") and body != self:
			body.take_damage(explosion_damage)
	hide()
	explosion_sound.play()
	await explosion_sound.finished
	queue_free()

func set_damage(damage: int):
	explosion_damage = damage


