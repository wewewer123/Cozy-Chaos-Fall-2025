extends CollisionObject

func _ready():
	type = CollisionType.TREE

func apply_effect(player: Node3D) -> void:
	player.decrementHealth()
	player.witch_audio_manager.playHurtByTree()
