extends Resource
class_name TreeFactory

@export var tree_scene: PackedScene
@export var tree_textures: Array[Texture2D] = []
@export var particles:bool
@export var amount:int=2

# TODO: Adding object pool for performance
func create_random_tree() -> Node3D:
	var tree : TreeDecoration = tree_scene.instantiate()
	tree.set_texture(tree_textures.pick_random(),particles,amount)
	return tree

func get_random_tree_texture() -> Texture2D:
	return tree_textures.pick_random()
