extends Node

signal scene_changed(new_scene: Node)

var current_scene: Node = null

func change_scene(new_scene_path: String) -> void:
	if current_scene:
		current_scene.queue_free()
	var new_scene = load(new_scene_path).instantiate()
	get_tree().root.add_child(new_scene)
	current_scene = new_scene
	emit_signal("scene_changed", current_scene)

func get_current_scene() -> Node:
	return current_scene

func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
