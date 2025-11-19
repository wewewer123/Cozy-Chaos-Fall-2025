extends CollisionObject

var cur_offset:float = 0
var max_offset:float = 0.75
var multiplier:float = 1
var move_speed = 0.75

func _ready():
	type = CollisionType.GHOST

func _process(delta: float) -> void:
	cur_offset += delta * move_speed * multiplier
	global_position.y = cur_offset
	
	if cur_offset > max_offset:
		cur_offset = max_offset
		multiplier *= -1
	elif cur_offset < 0:
		cur_offset = 0
		multiplier *= -1

func apply_effect(player: Node3D) -> void:
	super.apply_effect(player)
	player.decrementHealth()
	player.witch_audio_manager.playHurtByGhost()
