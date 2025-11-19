extends CollisionObject

@export var tree_factory:TreeFactory

func _ready():
	type = CollisionType.TREE
	textureSetter.set_texture(tree_factory.get_random_tree_texture())
	textureSetter.set_alpha_cut(SpriteBase3D.AlphaCutMode.ALPHA_CUT_DISABLED)

func apply_effect(player: Node3D) -> void:
	super.apply_effect(player)
	player.decrementHealth()
	player.witch_audio_manager.playHurtByTree()
