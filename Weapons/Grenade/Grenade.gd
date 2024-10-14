extends RigidBody2D

var explosion_damage: int
var destruction_radius: int = 1
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
		if body is TileMap:
			destroy_terrain(body, global_position)
	hide()
	explosion_sound.play()
	await explosion_sound.finished
	queue_free()

func destroy_terrain(tilemap: TileMap, impact_position: Vector2):
	for x in range(-destruction_radius, destruction_radius + 1):
		for y in range(-destruction_radius, destruction_radius + 1):
			var tile_pos = tilemap.local_to_map(tilemap.to_local(impact_position))
			tile_pos += Vector2i(x, y)
			tilemap.set_cell(0, tile_pos, -1)  

func set_damage(damage: int):
	explosion_damage = damage

func _on_body_entered(body):
	if body is TileMap:
		destroy_terrain(body, global_position)
	queue_free()
