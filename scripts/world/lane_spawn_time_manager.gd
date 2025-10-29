extends Timer

@export var level: GameManager.game_states = GameManager.game_states.LEVEL1

func _ready() -> void:
	wait_time = Globals.LANE_SPAWN_TIMERS.get(level)
