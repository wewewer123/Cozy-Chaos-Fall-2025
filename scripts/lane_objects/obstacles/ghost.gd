extends CollisionObject

var amplitude:float = 0.75
var t:float = 0
var move_speed = 2
var start_y:float

func _ready():
	type = CollisionType.GHOST
	start_y = global_position.y

func _process(delta: float) -> void:
	t += delta * move_speed
	global_position.y = start_y + sin(t) * amplitude

func apply_effect(player: Node3D) -> void:
	super.apply_effect(player)
	player.decrementHealth()
	player.witch_audio_manager.playHurtByGhost()
