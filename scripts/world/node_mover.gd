extends Node

const DESPAWN_Y_VALUE: float = 70

var parent: Node3D  

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	parent.position += Vector3(0, 0, 1.0)*20*delta
	if parent.position.z > DESPAWN_Y_VALUE:
		queue_free()
