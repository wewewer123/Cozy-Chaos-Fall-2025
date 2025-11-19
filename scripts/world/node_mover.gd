extends Node

const DESPAWN_Y_VALUE: float = 70

var parent: Node3D  

func _ready() -> void:
	parent = get_parent()

func _process(delta):
	parent.global_position += Vector3(0, 0, 1.0) * 20 * delta
	if parent.global_position.z > DESPAWN_Y_VALUE:
		parent.queue_free()
