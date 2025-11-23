extends CollisionObject

@export var tree_factory:TreeFactory
@export var material:ShaderMaterial

func _ready():
	textureSetter.set_texture_and_material(tree_factory.get_random_tree_texture(), material)

func apply_effect(player: Node3D) -> void:
	super.apply_effect(player)
	
	if applied_collision_effect:
		return
	
	applied_collision_effect = true
	player.decrementHealth()
	player.witch_audio_manager.playHurtByTree()
	create_tween().tween_method(set_move_speed, 0, Globals.max_move_speed, 1.5)
