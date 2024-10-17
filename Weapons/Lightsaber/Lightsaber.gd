extends Area2D

var cut_damage: int 


func _on_body_entered(body):
	print("Estoy dentro de sable laser")
	if body.has_method("take_damage"):
		body.take_damage(cut_damage)
	queue_free()

func set_damage(damage: int):
	cut_damage = damage
