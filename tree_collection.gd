extends Resource
class_name TreeCollection

@export var tree_scenes: Array[PackedScene] = []

func get_random_tree() -> PackedScene:
	return tree_scenes.pick_random()
