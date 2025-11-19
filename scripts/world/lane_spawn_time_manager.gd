extends Timer
class_name LaneSpawnTimer

func init(_wait_time:float):
	wait_time = _wait_time
	
func start_timer() -> void:
	start()
	
func stop_timer() -> void:
	stop()
