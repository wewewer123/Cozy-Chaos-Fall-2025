extends CollisionObject

@export var tree_factory:TreeFactory

func _ready():
	type = CollisionType.TREE
	textureSetter.set_texture(tree_factory.get_random_tree_texture())

func apply_effect(player: Node3D) -> void:
	player.decrementHealth()
	player.witch_audio_manager.playHurtByTree()
