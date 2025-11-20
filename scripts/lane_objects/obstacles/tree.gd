extends CollisionObject

@export var tree_factory:TreeFactory

func _ready():
	textureSetter.set_texture(tree_factory.get_random_tree_texture())
	textureSetter.set_alpha_cut(SpriteBase3D.AlphaCutMode.ALPHA_CUT_DISABLED)

func apply_effect(player: Node3D) -> void:
	super.apply_effect(player)
	
	if applied_collision_effect:
		return
	
	applied_collision_effect = true
	player.decrementHealth()
	player.witch_audio_manager.playHurtByTree()
	create_tween().tween_method(set_move_speed, 0, Globals.max_move_speed, 1.5)
