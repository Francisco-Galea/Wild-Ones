extends RigidBody2D

var damage_rasengan
var destruction_radius: int = 2

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage_rasengan)
	if body is TileMap:
		destroy_terrain(body, global_position)
	queue_free()

func destroy_terrain(tilemap: TileMap, impact_position: Vector2):
	for x in range(-destruction_radius, destruction_radius + 1):
		for y in range(-destruction_radius, destruction_radius + 1):
			var tile_pos = tilemap.local_to_map(tilemap.to_local(impact_position))
			tile_pos += Vector2i(x, y)
			tilemap.set_cell(0, tile_pos, -1)  

func set_damage(damage: int):
	damage_rasengan = damage
