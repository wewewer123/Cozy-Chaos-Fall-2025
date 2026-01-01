extends Resource
class_name TreeFactory

@export var tree_scene: PackedScene
@export var tree_textures: Array[Texture2D] = []

var trees : Array[TreeDecoration]

func instantiate_trees(count:int) -> void:
	for i in range(count):
		var tree : TreeDecoration = tree_scene.instantiate()
		tree.set_texture(tree_textures.pick_random())
		trees.append(tree)

func get_tree() -> Node3D:
	return trees.pop_back()

func get_random_tree_texture() -> Texture2D:
	return tree_textures.pick_random()

func return_tree_to_queue(tree:TreeDecoration) -> void:
	trees.append(tree)
