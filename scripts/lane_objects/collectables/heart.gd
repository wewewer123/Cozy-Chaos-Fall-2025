extends CollisionObject

var t:float = 0
var amplitude:float = 0.025
var base_y:float
var speed:float = 9

func _ready():
	type = CollisionType.HEART
	base_y = scale.x - amplitude
	
func _process(delta: float) -> void:
	t += delta * speed
	var dynamic_scale = base_y + cos(t) * amplitude 
	scale = Vector3(dynamic_scale, dynamic_scale, dynamic_scale)

func apply_effect(player: Node3D) -> void:
	queue_free()
	player.incrementHealth()
	player.witch_audio_manager.playpickUpHeartSound()
