extends CollisionObject

var amplitude:float = 3
var speed = 5
var t = 0

func _ready():
	type = CollisionType.LEAF

func _process(delta: float) -> void:
	t += delta * speed
	rotation_degrees.z = sin(t) * amplitude

func apply_effect(player: Node3D) -> void:
	player.add_leaf(1)
	player.witch_audio_manager.playPickUpLeaf()
