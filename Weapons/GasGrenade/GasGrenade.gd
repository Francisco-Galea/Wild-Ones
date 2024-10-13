extends RigidBody2D

var explosion_damage: int
var gas_duration: float = 10.0   
@onready var explosion_timer = $NadeWaitTime
@onready var explosion_area = $ExplosionArea
@onready var damage_ticks_timer = $DamageTicksTimer
@onready var particles = $ExplosionArea/GasParticles

func _ready():
	explosion_timer.start()
	particles.emitting = false

func explode():
	particles.emitting = true
	var bodies = explosion_area.get_overlapping_bodies()
	for body in bodies:
		if body.has_method("take_damage") and body != self:
			body.take_damage(explosion_damage)
		if body.has_method("apply_gas_effect"):
			body.apply_gas_effect(gas_duration)
	damage_ticks_timer.start()  
	await get_tree().create_timer(gas_duration).timeout
	damage_ticks_timer.stop()  
	queue_free()  

func set_damage(damage: int):
	explosion_damage = damage

func _on_nade_wait_time_timeout():
	explode()

func _on_damage_ticks_time_timeout():
	var bodies = explosion_area.get_overlapping_bodies()  
	for body in bodies:
		if body.has_method("take_damage") and body != self:
			body.take_damage(explosion_damage)  
