extends Timer
class_name LaneSpawnTimer

@export var level: GameManager.game_states = GameManager.game_states.LEVEL1

func _ready() -> void:
	wait_time = Globals.LANE_SPAWN_TIMERS.get(level)
	
func start_timer() -> void:
	start()
	
func stop_timer() -> void:
	stop()
