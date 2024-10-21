extends Area2D

var cut_damage: int 
@onready var swing_animation = $Sprite2D/SwingAnimation

func _ready():
	swing_animation.play("swing")
	await swing_animation.animation_finished
	queue_free()

func _on_body_entered(body):
	swing_animation.play("swing")
	print("Estoy dentro de sable laser")
	if body.has_method("take_damage"):
		body.take_damage(cut_damage)

func set_damage(damage: int):
	cut_damage = damage
