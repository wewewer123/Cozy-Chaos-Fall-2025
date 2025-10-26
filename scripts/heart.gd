extends CollisionObject

# Called when the node enters the scene tree for the first time.
func _ready():
	type = CollisionType.HEART

func apply_effect(player: Node3D) -> void:
	player.lives += 1
