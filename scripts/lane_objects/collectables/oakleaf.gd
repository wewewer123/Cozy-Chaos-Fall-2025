extends CollisionObject

var amplitude:float = 2
var speed = 5
var t = 0

func _process(delta: float) -> void:
	t += delta * speed
	rotation_degrees.z = sin(t) * amplitude

func apply_effect(player: Node3D) -> void:
	super.apply_effect(player)
	
	if applied_collision_effect:
		return
	
	applied_collision_effect = true
	player.add_leaf(1)
	player.witch_audio_manager.playPickUpLeaf()
