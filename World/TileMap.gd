# TileMap.gd
extends TileMap

func destroy_tile(global_position: Vector2):
	var tile_pos = local_to_map(to_local(global_position))
	set_cell(0, tile_pos, -1)  # -1 elimina la celda
