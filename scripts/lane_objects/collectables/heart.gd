extends CollisionObject

var dynamic_scale:float
var frequency:float = 0.2
var multiplier:float = -1
var min_scale = 0.95
var max_scale = 1

func _ready():
	type = CollisionType.HEART
	
func _process(delta: float) -> void:
	dynamic_scale += delta * frequency * multiplier
	
	scale = Vector3(dynamic_scale, dynamic_scale, dynamic_scale)
	
	if dynamic_scale < min_scale:
		dynamic_scale = min_scale
		multiplier *= -1
	elif dynamic_scale > max_scale:
		dynamic_scale = max_scale
		multiplier *= -1

func apply_effect(player: Node3D) -> void:
	queue_free()
	player.incrementHealth()
	player.witch_audio_manager.playpickUpHeartSound()
