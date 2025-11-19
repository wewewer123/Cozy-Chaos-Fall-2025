extends CollisionObject

# Called when the node enters the scene tree for the first time.
func _ready():
	type = CollisionType.LEAF

func apply_effect(player: Node3D) -> void:
	player.add_leaf(1)
	player.witch_audio_manager.playPickUpLeaf()
