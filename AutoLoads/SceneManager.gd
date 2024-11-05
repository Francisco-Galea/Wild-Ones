extends Node

signal scene_changed(new_scene: Node)

var current_scene: Node = null

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func change_scene(new_scene_path: String) -> void:
	if is_instance_valid(current_scene):
		for child in current_scene.get_children():
			child.queue_free()
		current_scene.queue_free()
	await get_tree().process_frame
	var new_scene = load(new_scene_path).instantiate()
	get_tree().root.add_child(new_scene)
	current_scene = new_scene
	emit_signal("scene_changed", current_scene)

func get_current_scene() -> Node:
	return current_scene
