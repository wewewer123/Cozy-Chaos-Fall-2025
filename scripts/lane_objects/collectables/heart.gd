extends CollisionObject

# Called when the node enters the scene tree for the first time.
func _ready():
	type = CollisionType.HEART

func apply_effect(player: Node3D) -> void:
	queue_free()
	player.incrementHealth()
	player.witch_audio_manager.playpickUpHeartSound()
